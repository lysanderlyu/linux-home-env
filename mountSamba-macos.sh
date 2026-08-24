#!/bin/bash

set -u

# Hostnames → macOS can resolve these directly
Win10="lysander-pc"
Win11="feasycom"
arm_ubuntu="arm-ubuntu"

# Share passwords
Win10_user="lyuyosin"
Win10_pass="http.147."

Win11_user="feasycom"
Win11_pass="Feasycom%40123."
WSL2_pass="856312"

Mount_option=""

# Mount points used by the active WSL2 mounts
# WSLHome="$HOME/mnt/Wsl/Home"
# Android109="$HOME/mnt/Android109"
# FeasycomFTP="$HOME/mnt/FeasycomFTP"

# Inactive / optional
# Ubuntu="$HOME/mnt/Ubuntu"
# System="$HOME/mnt/Win10/System"
# Document="$HOME/mnt/Win10/Document"
# Software="$HOME/mnt/Win10/Software"
# Lenovo="$HOME/mnt/Win10/Lenovo"
# Data="$HOME/mnt/Win10/Data"

ALL_MOUNTS=(
    "$WSLHome"
    "$Android109"
    "$FeasycomFTP"
)

ping_ok() {
    ping -c 1 -W 1000 "$1" >/dev/null 2>&1
}

# Prefer df over mount(8): a stale SMB share can make `mount` hang indefinitely.
is_mounted() {
    local mp="$1"
    df -P 2>/dev/null | awk -v mp="$mp" 'NR > 1 && $NF == mp { found = 1 } END { exit !found }'
}

ensure_mount_dir() {
    mkdir -p "$1"
}

force_unmount() {
    local mp="$1"
    if ! is_mounted "$mp"; then
        echo "Not mounted: $mp"
        return 0
    fi

    echo "Force unmounting $mp ..."
    # diskutil takes a bare "force" flag, not --force
    if diskutil unmount force "$mp"; then
        echo "Unmounted: $mp"
        return 0
    fi

    echo "diskutil failed for $mp, trying umount -f ..."
    if umount -f "$mp"; then
        echo "Unmounted: $mp"
        return 0
    fi

    echo "Failed to unmount: $mp" >&2
    return 1
}

resolve_unmount_targets() {
    local arg name
    if [[ $# -eq 0 ]]; then
        printf '%s\n' "${ALL_MOUNTS[@]}"
        return 0
    fi

    for arg in "$@"; do
        case "$arg" in
            Home|WSLHome|wsl|Wsl) echo "$WSLHome" ;;
            Android109|android109|android) echo "$Android109" ;;
            FeasycomFTP|ftp|FTP) echo "$FeasycomFTP" ;;
            /*) echo "$arg" ;;
            *)
                echo "Unknown mount target: $arg" >&2
                echo "Known names: Home, Android109, FeasycomFTP" >&2
                return 1
                ;;
        esac
    done
}

unmount_shares() {
    local targets mp status=0
    targets="$(resolve_unmount_targets "$@")" || return 1
    while IFS= read -r mp; do
        [[ -z "$mp" ]] && continue
        force_unmount "$mp" || status=1
    done <<< "$targets"
    return "$status"
}

testAndMountWin10() {
    if ping_ok "$Win10"; then
        echo "Win10 online, mounting..."

        if ! mount | grep -q "$System"; then
            mount_smbfs "//${Win10_user}:${Win10_pass}@${Win10}/System"   "$System"
        fi
        if ! mount | grep -q "$Learning"; then
            mount_smbfs "//${Win10_user}:${Win10_pass}@${Win10}/Software" "$Software"
        fi
        if ! mount | grep -q "$Other"; then
            mount_smbfs "//${Win10_user}:${Win10_pass}@${Win10}/Document"   "$Document"
        fi
        if ! mount | grep -q "$Data"; then
            mount_smbfs "//${Win10_user}:${Win10_pass}@${Win10}/Lenovo"     "$Lenovo"
        fi

        echo "Win10 mounted."
    fi
}

testAndMountWin11() {
    if ! ping_ok "$Win11"; then
        echo "Win11 offline (ping failed)"
        return 1
    fi

    if is_mounted "$Data"; then
        echo "Already mounted"
        return 0
    fi

    if ! nc -z -w 3 "$Win11" 445; then
        echo "Error: SMB port 445 unreachable – check firewall and routing"
        return 1
    fi

    if mount_smbfs ${Mount_option} "//${Win11_user}:${Win11_pass}@${Win11}/Data" "$Data"; then
        echo "Win11 mounted."
    else
        echo "Mount failed with exit code $?"
        return 1
    fi
}

testAndMountWSL2() {
    if ! ping_ok "$Win11"; then
        echo "Win11 offline (ping failed)"
        return 1
    fi

    if ! nc -z -w 3 "$Win11" 1445; then
        echo "Error: SMB port 1445 unreachable – check firewall and routing"
        return 1
    fi

    ensure_mount_dir "$WSLHome"
    ensure_mount_dir "$Android109"
    ensure_mount_dir "$FeasycomFTP"

    if is_mounted "$WSLHome"; then
        echo "Already mounted: $WSLHome"
    elif mount_smbfs ${Mount_option} "//${Win11_user}:${WSL2_pass}@${Win11}:1445/Home" "$WSLHome"; then
        echo "WSLHome mounted."
    else
        echo "Mount failed with exit code $? : $WSLHome"
    fi

    if is_mounted "$Android109"; then
        echo "Already mounted: $Android109"
    elif mount_smbfs ${Mount_option} "//${Win11_user}:${WSL2_pass}@${Win11}:1445/Android109" "$Android109"; then
        echo "Android109 mounted."
    else
        echo "Mount failed with exit code $? : $Android109"
    fi

    if is_mounted "$FeasycomFTP"; then
        echo "Already mounted: $FeasycomFTP"
    elif mount_smbfs ${Mount_option} "//${Win11_user}:${WSL2_pass}@${Win11}:1445/ftp" "$FeasycomFTP"; then
        echo "FeasycomFTP mounted."
    else
        echo "Mount failed with exit code $? : $FeasycomFTP"
    fi
}

testAndMountArmUbuntu() {
    if ping_ok "$arm_ubuntu"; then
        echo "arm-ubuntu online, mounting..."
        if ! mount | grep -q "$Ubuntu"; then
            mount_smbfs "//lysander:${Win10_pass}@${arm_ubuntu}/Home" "$Ubuntu"
        fi
        echo "arm-ubuntu mounted."
    fi
}

usage() {
    cat <<EOF
Usage: $(basename "$0") [mount|unmount] [target ...]

  (default) | mount
                Mount WSL SMB shares (Home, Android109, FeasycomFTP)

  -u, --unmount, unmount
                Force-unmount shares with: diskutil unmount force <path>
                Optional targets: Home, Android109, FeasycomFTP, or a full path

  -h, --help    Show this help

Examples:
  $(basename "$0")
  $(basename "$0") -u
  $(basename "$0") -u Home Android109
EOF
}

mode="mount"
targets=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -u|--unmount|unmount|umount)
            mode="unmount"
            shift
            ;;
        mount)
            mode="mount"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            targets+=("$@")
            break
            ;;
        -*)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 1
            ;;
        *)
            targets+=("$1")
            shift
            ;;
    esac
done

case "$mode" in
    unmount)
        unmount_shares "${targets[@]+"${targets[@]}"}"
        ;;
    mount)
        if [[ ${#targets[@]} -gt 0 ]]; then
            echo "Mount targets are not supported yet; mounting all WSL shares." >&2
        fi
        testAndMountWSL2
        ;;
esac
