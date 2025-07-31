# Frequently Asked Questions (FAQ)

## General Questions

### Q: What operating systems are supported?
**A:** The hardware scan tool supports Linux, macOS, and Windows. It automatically detects your platform and runs the appropriate commands for your system.

### Q: Do I need administrator/root privileges to run this script?
**A:** The script will run without elevated privileges, but some hardware information requires sudo/administrator access. The script gracefully handles permission errors and will show available information. For complete results, run with elevated privileges:
- Linux/macOS: `sudo ./scan_all_hardware.sh`
- Windows: Run as Administrator

### Q: How long does the scan take?
**A:** Typically 30 seconds to 2 minutes, depending on your system complexity and the number of devices. SMART disk scans and detailed PCI enumeration can take longer on systems with many drives or devices.

## Installation & Setup

### Q: I'm getting "command not found" errors on Linux. What should I do?
**A:** Some utilities aren't installed by default. Install the missing packages:

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install lshw hwinfo inxi smartmontools lm-sensors dmidecode
```

**RHEL/CentOS/Fedora:**
```bash
sudo dnf install lshw hwinfo inxi smartmontools lm_sensors dmidecode
```

### Q: The script isn't executable. How do I fix this?
**A:** Make the script executable with:
```bash
chmod +x scan_all_hardware.sh
```

### Q: Can I run this script remotely via SSH?
**A:** Yes, the script works fine over SSH. However, some hardware detection (like graphics info) may be limited in headless environments.

## Output & Results

### Q: How can I save the output to a file?
**A:** Redirect the output to a file:
```bash
./scan_all_hardware.sh > hardware_report.txt
```

To capture both output and error messages:
```bash
./scan_all_hardware.sh > hardware_report.txt 2>&1
```

### Q: The output has strange characters or no colors. Why?
**A:** Colors are disabled when output is redirected or the terminal doesn't support them. This is normal behavior. The strange characters are likely ANSI color codes that your viewer can't interpret.

### Q: Some sections show "command not found" or are empty. Is this normal?
**A:** Yes, this is normal. Different systems have different tools available, and the script tries multiple approaches. Missing commands are silently ignored, and the script continues with available alternatives.

## Platform-Specific Questions

### Q: On macOS, why do I see "permission denied" errors?
**A:** Recent macOS versions require explicit permission for system information access. Run with `sudo` or grant Terminal appropriate permissions in System Preferences > Security & Privacy.

### Q: Windows version shows limited information. Why?
**A:** The Windows implementation uses `wmic` and `systeminfo` commands. Some newer Windows versions have deprecated `wmic`. The script falls back to available alternatives.

### Q: Linux shows "access denied" for SMART data. How do I fix this?
**A:** SMART data requires root access to disk devices. Run with `sudo` or add your user to the appropriate group (usually `disk`):
```bash
sudo usermod -a -G disk $USER
```
(Requires logout/login to take effect)

## Troubleshooting

### Q: The script seems to hang or takes very long. What's happening?
**A:** Some commands can be slow, especially:
- SMART disk scanning on systems with many drives
- Network interface enumeration with many virtual interfaces
- PCI device scanning with detailed verbosity

You can interrupt with Ctrl+C if needed.

### Q: I'm getting "sudo: no tty present" errors in automated environments.
**A:** This happens when running in environments without interactive terminals. Either:
1. Run without sudo (limited information)
2. Configure passwordless sudo for specific commands
3. Run as root user directly

### Q: Can I customize which sections are scanned?
**A:** Currently, the script runs all available scans. You can modify the script to comment out sections you don't need, or create a custom version with only desired sections.

### Q: The script detects wrong OS or shows "Unknown platform".
**A:** This can happen in containers or unusual environments. The script uses `uname -s` to detect the platform. You can manually set the OS variable at the top of the script if needed.

## Performance & Resource Usage

### Q: Does this script modify any system settings?
**A:** No, the script is read-only. It only queries system information and doesn't modify any settings or configurations.

### Q: Is it safe to run this script in production environments?
**A:** Yes, the script only reads system information and doesn't make changes. However, some commands might briefly increase system load, so consider running during maintenance windows on critical systems.

### Q: Can I run this script repeatedly?
**A:** Yes, you can run it as often as needed. There's no state maintained between runs.

## Integration & Automation

### Q: Can I integrate this with monitoring systems?
**A:** Yes, you can parse the output or modify the script to output in formats like JSON or XML for integration with monitoring tools.

### Q: How can I compare hardware changes over time?
**A:** Save outputs with timestamps and use diff tools:
```bash
./scan_all_hardware.sh > scan_$(date +%Y%m%d_%H%M%S).txt
diff scan_20250731_100000.txt scan_20250731_110000.txt
```

### Q: Can I run this from a cron job?
**A:** Yes, but consider:
- Use absolute paths
- Redirect output appropriately
- Some commands may need TTY (use `script` command if needed)
- Consider sudo requirements for automated runs

## Getting Help

### Q: I found a bug or want to request a feature. How do I report it?
**A:** Please open an issue on the GitHub repository with:
- Your operating system and version
- The complete error message or unexpected behavior
- Steps to reproduce the issue

### Q: Can I contribute to this project?
**A:** Yes! Contributions are welcome. Please fork the repository, make your changes, and submit a pull request. For major changes, please open an issue first to discuss the proposed changes.
