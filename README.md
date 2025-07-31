# Hardware Scan Tool

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform: Linux/macOS/Windows](https://img.shields.io/badge/platform-linux--macos--windows-blue)


A comprehensive cross-platform hardware scanning utility that provides detailed information about your system's hardware components and configuration.

## Features

- **Cross-platform support**: Works on Linux, macOS, and Windows
- **Comprehensive scanning**: Covers CPU, memory, storage, network, graphics, audio, and more
- **Colorized output**: Easy-to-read formatted output with color-coded sections
- **Multiple data sources**: Uses various system tools and utilities for complete coverage
- **Error-resilient**: Gracefully handles missing commands or permissions

## Supported Platforms

### Linux
- System & kernel information
- CPU details (via `lscpu` and `/proc/cpuinfo`)
- Memory information (via `free` and `dmidecode`)
- Storage devices (via `lsblk`, `smartctl`, RAID/LVM status)
- PCI and USB devices
- Network interfaces and hardware
- Graphics information
- System sensors and battery status
- Audio devices and printers/scanners
- Hardware info via `hwinfo` and `inxi`
- DMI/SMBIOS data
- Kernel modules and device classes

### macOS
- System and hardware overview
- CPU, memory, and storage details
- Network configuration
- USB and PCI devices
- Graphics/displays and audio devices
- Battery information

### Windows
- System information
- CPU and memory details
- Disk drives and logical disks
- Network adapters
- USB devices and graphics cards
- Audio devices and battery status

## Installation

1. Clone or download the script:
    ```bash
    git clone https://github.com/amuzetnoM/hardware_scan.git
    cd hardware_scan
    ```

2. Make the script executable:
    ```bash
    chmod +x scan_all_hardware.sh
    ```

## Usage

Run the script directly:
```bash
./scan_all_hardware.sh
```

Or with bash:
```bash
bash scan_all_hardware.sh
```

### Output Redirection

Save the output to a file:
```bash
./scan_all_hardware.sh > hardware_report.txt
```

Save both output and errors:
```bash
./scan_all_hardware.sh > hardware_report.txt 2>&1
```

## Requirements

### Linux
The script uses various system utilities. Most are available by default, but you may need to install:
- `lshw` - Hardware lister
- `hwinfo` - Hardware information tool
- `inxi` - System information script
- `smartmontools` - For SMART disk data
- `lm-sensors` - For temperature sensors
- `dmidecode` - For DMI/SMBIOS data (requires sudo)

Install on Ubuntu/Debian:
```bash
sudo apt update
sudo apt install lshw hwinfo inxi smartmontools lm-sensors dmidecode
```

Install on RHEL/CentOS/Fedora:
```bash
sudo yum install lshw hwinfo inxi smartmontools lm_sensors dmidecode
# or for newer versions:
sudo dnf install lshw hwinfo inxi smartmontools lm_sensors dmidecode
```

### macOS
Most commands use built-in `system_profiler` utility. No additional installation required.

### Windows
Uses built-in `wmic` and `systeminfo` commands. No additional installation required.

## Permissions

Some commands require elevated privileges (sudo on Linux/macOS, Administrator on Windows) to access certain hardware information:
- Memory module details
- SMART disk data
- DMI/SMBIOS information
- Some PCI device details

The script will attempt to run these commands and gracefully handle permission errors.

## Sample Output

```
=========================================
              HARDWARE SCAN
=========================================
Mon Jul 31 10:30:45 UTC 2025 on host: my-computer

==[ System & Kernel ]==

Linux my-computer 6.5.0-generic #1 SMP x86_64 GNU/Linux

==[ CPU Info ]==

Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Model name:          Intel(R) Core(TM) i7-12700K CPU @ 3.60GHz
CPU(s):              20
...
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please check the [FAQ](FAQ.md) or open an issue on GitHub.

## Changelog

### v1.0.0
- Initial release with cross-platform support
- Comprehensive hardware scanning for Linux, macOS, and Windows
- Colorized output formatting
- Error-resilient command execution

