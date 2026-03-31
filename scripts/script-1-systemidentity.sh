#!/bin/bash

clear

echo "╔══════════════════════════════════════════════╗"
echo "║            SYSTEM INSPECTION DASHBOARD       ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

echo "┌─[ CORE DETAILS ]─────────────────────────────"
echo "│ Current User : $(whoami)"
echo "│ Machine Name : $(hostname)"
echo "│ Active Shell : $SHELL"
echo "│ System Uptime: $(uptime -p)"
echo "│ Current Time : $(date '+%d %B %Y %I:%M %p')"
echo "├──────────────────────────────────────────────"

if [ -f /etc/os-release ]; then
    OS_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
    echo "│ OS Version   : $OS_NAME"
else
    echo "│ OS Version   : $(uname -s)"
fi

echo "│ Kernel Info  : $(uname -r)"
echo "│ Architecture : $(uname -m)"
echo "└──────────────────────────────────────────────"
echo ""

echo "┌─[ HARDWARE STATUS ]──────────────────────────"

CPU_INFO=$(lscpu | awk -F: '/Model name/ {print $2}' | xargs)
RAM_INFO=$(free -h | awk '/Mem:/ {print $3 " used of " $2}')
DISK_INFO=$(df -h / | awk 'NR==2 {print $3 " used of " $2}')

echo "│ Processor    : $CPU_INFO"
echo "│ RAM Usage    : $RAM_INFO"
echo "│ Root Storage : $DISK_INFO"

echo "└──────────────────────────────────────────────"
echo ""

echo "┌─[ LICENSING INFO ]───────────────────────────"

echo "│ Kernel License : GNU GPL v2"
echo "│ OS Licensing   : Combination of GPL, MIT, BSD"

echo "└──────────────────────────────────────────────"
echo ""

echo "┌─[ APPLICATION CHECK ]────────────────────────"

if command -v libreoffice >/dev/null 2>&1; then
    LO_VER=$(libreoffice --version | head -n 1)
    echo "│ LibreOffice   : Available"
    echo "│ Installed Ver.: $LO_VER"
else
    echo "│ LibreOffice   : Not Found"
fi

echo "│ License       : MPL 2.0"
echo "│ Developed By  : The Document Foundation"

echo "└──────────────────────────────────────────────"
echo ""

echo "╔══════════════════════════════════════════════╗"
echo "║        Scan completed at: $(date '+%H:%M:%S')       ║"
echo "╚══════════════════════════════════════════════╝"