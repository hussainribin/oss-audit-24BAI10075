# Open Source Audit Toolkit

A set of Bash-based utilities designed to examine, audit, and evaluate open source systems and software environments. This toolkit relies on standard Linux tools and delivers a unified command-line experience across all its features.

---

## Overview

This project includes the following components:

* **System Information Reporter**
  Provides detailed insights into the system, including OS distribution, kernel details, uptime, and hardware specifications.

* **FOSS Package Analyzer**
  Collects and displays information about installed packages through the system’s package manager, such as version details, licensing, and build data.

* **Storage and Permission Scanner**
  Examines selected directories to identify unsafe permission settings, including files or folders with world-writable access.

* **Log Analysis Tool**
  Parses log files to detect keyword matches, highlight important entries, and identify patterns commonly associated with system issues.

* **Open Source Manifest Generator**
  Creates a structured manifesto document using user-provided input along with system-related information.

---

## Requirements

* A Linux-based operating system (best suited for Arch Linux)
* Bash version 4 or higher

### Mandatory Utilities

* `pacman`
* `grep`, `awk`, `sed`
* `find`, `stat`, `df`, `du`, `wc`
* `lscpu`, `free`

### Optional Utility

* `bc` (used for calculating percentages in log processing)

---

## Installation

Clone the repository using:

```bash
git clone https://github.com/yourusername/open-source-audit-toolkit.git
cd open-source-audit-toolkit
```

---

## How to Use

### System Information Reporter

```bash
./script-1-systemidentity.sh
```

Displays essential system-level information including OS, kernel, uptime, and hardware configuration.

---

### FOSS Package Analyzer

```bash
./script-2-foss-package.sh
```

Analyzes a predefined package (default: LibreOffice) and outputs details like version, license, and metadata.

---

### Storage and Permission Scanner

```bash
./script-3-security-audit.sh
```

Scans directories to detect insecure file permissions such as world-writable access.

---

### Log Analysis Tool

```bash
./script-4-loganalyzer.sh <logfile> [keyword]
```

Examples:

```bash
./script-4-loganalyzer.sh /var/log/syslog
./script-4-loganalyzer.sh /var/log/pacman.log warning
```

If no log file is specified, the script will attempt to automatically locate LibreOffice logs.

---

### Open Source Manifest Generator

```bash
./script-5-opensourcemanifesto.sh
```

Prompts the user for input and generates a manifesto file in the current working directory.

---

## Additional Notes

Some scripts may require elevated privileges:

```bash
sudo ./script-4-loganalyzer.sh /var/log/syslog
```

Ensure all required utilities are installed before running the toolkit.
The scripts are designed for terminal usage with formatted output.

Make all scripts executable:

```bash
chmod +x *.sh
```

---

## Author

**HUSEN RIBINWALA 24BAI10075**
