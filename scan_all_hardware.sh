#!/bin/bash

# Detect platform
OS=""
case "$(uname -s)" in
    Linux*)     OS="Linux";;
    Darwin*)    OS="Mac";;
    CYGWIN*|MINGW*|MSYS*) OS="Windows";;
    *)          OS="Unknown";;
esac

# Color functions, more vibrant
bold=$(tput bold 2>/dev/null || echo "")
reset=$(tput sgr0 2>/dev/null || echo "")
magenta=$(tput setaf 5 2>/dev/null || echo "")
yellow=$(tput setaf 3 2>/dev/null || echo "")
cyan=$(tput setaf 6 2>/dev/null || echo "")
white=$(tput setaf 7 2>/dev/null || echo "")

function headline {
  echo -e "${bold}${magenta}"
  echo "========================================="
  echo "           HARDWARE SCAN"
  echo "========================================="
  echo -e "${reset}${yellow}_$(date)_ on host: ${bold}$(hostname)${reset}\n"
}

function section {
  echo -e "\n${bold}${cyan}==[ $1 ]==${reset}\n"
}

headline

# Platform-specific commands
if [ "$OS" = "Linux" ]; then
    section "System & Kernel"
    uname -a

    section "CPU Info"
    lscpu 2>/dev/null || cat /proc/cpuinfo

    section "Memory"
    free -h 2>/dev/null || cat /proc/meminfo

    section "RAM Details"
    sudo dmidecode --type 17 2>/dev/null

    section "Storage"
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,MODEL,SERIAL 2>/dev/null || fdisk -l

    section "Detailed Disk Info"
    for disk in /dev/sd?; do
      echo -e "${bold}${white}${disk}${reset}"
      sudo smartctl -a $disk 2>/dev/null
    done

    section "PCI Devices"
    lspci -nnvv 2>/dev/null

    section "USB Devices"
    lsusb -tv 2>/dev/null

    section "Network Interfaces"
    ip -br a 2>/dev/null || ifconfig -a

    section "Network Hardware Details"
    lshw -C network 2>/dev/null

    section "Graphics Info"
    lshw -C display 2>/dev/null || lspci | grep -i vga

    section "Sensors"
    sensors 2>/dev/null

    section "Battery"
    upower -i $(upower -e | grep battery) 2>/dev/null

    section "RAID and LVM"
    cat /proc/mdstat
    lsblk | grep "lvm"

    section "HWinfo"
    hwinfo --short 2>/dev/null

    section "Inxi Full Report"
    inxi -Fxxxrz 2>/dev/null

    section "DMI/SMBIOS"
    sudo dmidecode 2>/dev/null

    section "Kernel Ring Buffer"
    dmesg | grep -i 'firmware\|error\|fail\|hardware\|acpi'

    section "Loaded Modules"
    lsmod

    section "Devices by Class"
    ls /sys/class/

    section "Devices by Bus"
    ls /sys/bus/

    section "Audio Devices"
    aplay -l 2>/dev/null
    lshw -C multimedia 2>/dev/null

    section "Printers/Scanners"
    lpstat -p -d 2>/dev/null
    scanimage -L 2>/dev/null

elif [ "$OS" = "Mac" ]; then
    section "System Overview"
    system_profiler SPSoftwareDataType

    section "Hardware Overview"
    system_profiler SPHardwareDataType

    section "CPU Info"
    sysctl -n machdep.cpu.brand_string

    section "Memory"
    system_profiler SPMemoryDataType

    section "Storage"
    diskutil list
    system_profiler SPStorageDataType

    section "Network"
    networksetup -listallhardwareports
    ifconfig

    section "USB Devices"
    system_profiler SPUSBDataType

    section "PCI Devices"
    system_profiler SPPciDataType

    section "Graphics/Displays"
    system_profiler SPDisplaysDataType

    section "Audio Devices"
    system_profiler SPAudioDataType

    section "Battery"
    system_profiler SPPowerDataType

elif [ "$OS" = "Windows" ]; then
    section "System Info"
    systeminfo 2>/dev/null

    section "CPU Info"
    wmic cpu get name,NumberOfCores,NumberOfLogicalProcessors /format:list 2>/dev/null

    section "Memory"
    wmic memorychip get BankLabel,Capacity,Speed,MemoryType /format:list 2>/dev/null

    section "Disk Drives"
    wmic diskdrive get Caption,Model,SerialNumber,Size /format:list 2>/dev/null

    section "Logical Disks"
    wmic logicaldisk get DeviceID,FileSystem,FreeSpace,Size,VolumeName /format:list 2>/dev/null

    section "Network Adapters"
    wmic nic get Name,MACAddress,Speed /format:list 2>/dev/null

    section "USB Devices"
    wmic path Win32_USBControllerDevice get Dependent 2>/dev/null

    section "Graphics"
    wmic path win32_VideoController get name,adapterram /format:list 2>/dev/null

    section "Audio Devices"
    wmic sounddev get Name /format:list 2>/dev/null

    section "Battery"
    wmic path Win32_Battery get * /format:list 2>/dev/null
else
    section "Unknown Platform"
    echo "Sorry, this script couldn't identify your system type or platform."
fi

echo -e "\n${bold}${magenta}========= END OF SCAN =========${reset}\n"

