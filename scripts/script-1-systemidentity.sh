#!/bin/bash

# Clear the terminal screen
clear

# ===== HEADER SECTION =====
echo "╔══════════════════════════════════════════════╗"
echo "║            SYSTEM INSPECTION DASHBOARD       ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ===== CORE SYSTEM DETAILS =====
echo "┌─[ CORE DETAILS ]─────────────────────────────"

# Display current logged-in user
echo "│ Current User : $(whoami)"

# Display hostname (machine name)
echo "│ Machine Name : $(hostname)"

# Show active shell
echo "│ Active Shell : $SHELL"

# Show system uptime in readable format
echo "│ System Uptime: $(uptime -p)"

# Show current date and time
echo "│ Current Time : $(date '+%d %B %Y %I:%M %p')"
echo "├──────────────────────────────────────────────"

# Detect OS information from system file
if [ -f /etc/os-release ]; then
    OS_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
    echo "│ OS Version   : $OS_NAME"
else
    # Fallback if os-release file is missing
    echo "│ OS Version   : $(uname -s)"
fi

# Display kernel version
echo "│ Kernel Info  : $(uname -r)"

# Display system architecture
echo "│ Architecture : $(uname -m)"
echo "└──────────────────────────────────────────────"
echo ""

# ===== HARDWARE INFORMATION =====
echo "┌─[ HARDWARE STATUS ]──────────────────────────"

# Get CPU model name
CPU_INFO=$(lscpu | awk -F: '/Model name/ {print $2}' | xargs)

# Get memory usage (used / total)
RAM_INFO=$(free -h | awk '/Mem:/ {print $3 " used of " $2}')

# Get root partition disk usage
DISK_INFO=$(df -h / | awk 'NR==2 {print $3 " used of " $2}')

echo "│ Processor    : $CPU_INFO"
echo "│ RAM Usage    : $RAM_INFO"
echo "│ Root Storage : $DISK_INFO"

echo "└──────────────────────────────────────────────"
echo ""

# ===== LICENSING INFORMATION =====
echo "┌─[ LICENSING INFO ]───────────────────────────"

# Display kernel license
echo "│ Kernel License : GNU GPL v2"

# General OS licensing info
echo "│ OS Licensing   : Combination of GPL, MIT, BSD"

echo "└──────────────────────────────────────────────"
echo ""

# ===== APPLICATION CHECK (LibreOffice) =====
echo "┌─[ APPLICATION CHECK ]────────────────────────"

# Check if LibreOffice is installed
if command -v libreoffice >/dev/null 2>&1; then
    LO_VER=$(libreoffice --version | head -n 1)

    # If installed, show version
    echo "│ LibreOffice   : Available"
    echo "│ Installed Ver.: $LO_VER"
else
    # If not installed
    echo "│ LibreOffice   : Not Found"
fi

# Display application license and maintainer
echo "│ License       : MPL 2.0"
echo "│ Developed By  : The Document Foundation"

echo "└──────────────────────────────────────────────"
echo ""

# ===== FOOTER =====
echo "╔══════════════════════════════════════════════╗"
echo "║        Scan completed at: $(date '+%H:%M:%S')       ║"
echo "╚══════════════════════════════════════════════╝"
