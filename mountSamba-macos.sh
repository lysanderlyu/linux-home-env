#!/bin/bash

# Hostnames → macOS can resolve these directly
rbWin10="rbWin10"
android156="android156"
rbdebian="rbdebian"
arm_win11="arm-win11"
arm_debian="arm-debian"

# Share passwords
android156_pass="realbom"
rbWin10_pass="856312"

# Mount points
# Android156="$HOME/mnt/android156"
# RBDebian="$HOME/mnt/rbdebian"
# System="$HOME/mnt/System"
# Learning="$HOME/mnt/Learning"
# Other="$HOME/mnt/Other"
# Data="$HOME/mnt/Data"
# Wsl="$HOME/mnt/Wsl"

# Ensure dirs exist
# mkdir -p "$Android156" "$RBDebian" "$System" "$Learning" "$Other" "$Data"

# macOS SMB mount syntax:
# mount_smbfs "//user:pass@hostname/share" /Local/MountPoint

ping_ok() {
    # ping -t 1 "$1" 2>/dev/null | grep -q "1 packets"
    ping -c 1 -W 1000 "$1" >/dev/null 2>&1
}

testAndMountAndroid() {
    if ping_ok "$android156"; then
        echo "android156 online, mounting..."
        if ! mount | grep -q "$Android156"; then
            mount_smbfs "//yclv:${android156_pass}@${android156}/work_yclv" "$Android156"
        fi
        echo "android156 mounted."
    fi
}

testAndMountRBDebian() {
    if ping_ok "$rbdebian"; then
        echo "rbdebian online, mounting..."
        if ! mount | grep -q "$RBDebian"; then
            mount_smbfs "//lysander:${rbWin10_pass}@${rbdebian}/Home" "$RBDebian"
        fi
        echo "rbdebian mounted."
    fi
}

testAndMountRBWin10() {
    if ping_ok "$rbWin10"; then
        echo "rbWin10 online, mounting..."

        if ! mount | grep -q "$System"; then
            mount_smbfs "//lysander:${rbWin10_pass}@${rbWin10}/System"   "$System"
        fi
        if ! mount | grep -q "$Learning"; then
            mount_smbfs "//lysander:${rbWin10_pass}@${rbWin10}/Learning" "$Learning"
        fi
        if ! mount | grep -q "$Other"; then
            mount_smbfs "//lysander:${rbWin10_pass}@${rbWin10}/Other"    "$Other"
        fi
        if ! mount | grep -q "$Data"; then
            mount_smbfs "//lysander:${rbWin10_pass}@${rbWin10}/Data"     "$Data"
        fi
        # SSHFS works the same on macOS if you installed it via brew (osxfuse + sshfs)
        # sshfs -o allow_other -p 20222 lysander@"${rbWin10}":/home/lysander "$Wsl"

        echo "rbWin10 mounted."
    fi
}

testAndMountArmWin11() {
    if ping_ok "${arm_win11}"; then
        echo "arm-win11 online, mounting..."

        if ! mount | grep -q "$ArmWin11_Dev"; then
            mount_smbfs "//lysander:${rbWin10_pass}@${arm_win11}/Dev"   "${ArmWin11_Dev}"
        fi
        echo "arm-win11 mounted."
    fi
}

testAndMountArmDebian() {
    if ping_ok "$arm_debian"; then
        echo "arm-debian online, mounting..."
        if ! mount | grep -q "$RBDebian"; then
            mount_smbfs "//lysander:${rbWin10_pass}@${arm_debian}/Home" "$RBDebian"
        fi
        echo "rbdebian mounted."
    fi
}

testAndMountAndroid
testAndMountRBDebian
testAndMountRBWin10
testAndMountArmWin11
testAndMountArmDebian
