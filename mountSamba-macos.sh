#!/bin/bash

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

# Mount points
# Ubuntu="$HOME/mnt/Ubuntu"
# System="$HOME/mnt/System"
# Document="$HOME/mnt/Document"
# Software="$HOME/mnt/Software"
# Lenovo="$HOME/mnt/Lenovo"

ping_ok() {
    # ping -t 1 "$1" 2>/dev/null | grep -q "1 packets"
    ping -c 1 -W 1000 "$1" >/dev/null 2>&1
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

    # Check already mounted?
    if mount | grep -q "$Data"; then
        echo "Already mounted"
        return 0
    fi

    # Try to connect to SMB port first
    if ! nc -z -w 3 "$Win11" 445; then
        echo "Error: SMB port 445 unreachable – check firewall and routing"
        return 1
    fi

    # Attempt the mount
    if mount_smbfs "//${Win11_user}:${Win11_pass}@${Win11}/Data" "$Data"; then
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

    # Check already mounted?
    if mount | grep -q "$WSLHome"; then
        echo "Already mounted"
        return 0
    fi

    # Try to connect to SMB port first
    if ! nc -z -w 3 "$Win11" 1445; then
        echo "Error: SMB port 1445 unreachable – check firewall and routing"
        return 1
    fi

    # Attempt the mount
    if mount_smbfs "//${Win11_user}:${WSL2_pass}@${Win11}:1445/Home" "$WSLHome"; then
        echo "WSLHome mounted."
    else
        echo "Mount failed with exit code $?"
        return 1
    fi

    # Attempt the mount
    if mount_smbfs "//${Win11_user}:${WSL2_pass}@${Win11}:1445/Android109" "$Android109"; then
        echo "Android109 mounted."
    else
        echo "Mount failed with exit code $?"
        return 1
    fi

    # Attempt the mount
    if mount_smbfs "//${Win11_user}:${WSL2_pass}@${Win11}:1445/ftp" "$FeasycomFTP"; then
        echo "FeasycomFTP mounted."
    else
        echo "Mount failed with exit code $?"
        return 1
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

# testAndMountWin11
testAndMountWSL2
