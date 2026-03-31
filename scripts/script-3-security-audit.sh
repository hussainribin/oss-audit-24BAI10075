#!/bin/bash

# Color Definitions
CLR_RED='\033[0;31m'
CLR_GREEN='\033[0;32m'
CLR_YELLOW='\033[1;33m'
CLR_RESET='\033[0m'

# Target Directories
TARGET_PATHS=("/usr/lib/libreoffice" "/usr/share/libreoffice" "/etc/libreoffice")

clear

echo "╔══════════════════════════════════════════════╗"
echo "║        LIBREOFFICE PERMISSION INSPECTOR      ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

echo "┌─[ SCAN RESULTS ]─────────────────────────────"

ISSUE_FLAG=0

for PATH_ITEM in "${TARGET_PATHS[@]}"; do

    if [ -d "$PATH_ITEM" ]; then

        PERMISSION=$(stat -c %A "$PATH_ITEM")
        OTHER_ACCESS=$(stat -c %a "$PATH_ITEM" | cut -c3)

        if [ "$OTHER_ACCESS" -ge 2 ]; then
            echo -e "│ ${CLR_RED}⚠ Warning: $PATH_ITEM${CLR_RESET}"
            echo "│   Permissions : $PERMISSION"
            echo "│   Issue       : Public write access detected"
            echo "├──────────────────────────────────────────────"
            ISSUE_FLAG=1
        else
            echo -e "│ ${CLR_GREEN}✔ Safe: $PATH_ITEM${CLR_RESET}"
            echo "│   Permissions : $PERMISSION"
            echo "├──────────────────────────────────────────────"
        fi

    else
        echo -e "│ ${CLR_YELLOW}• Not Found: $PATH_ITEM${CLR_RESET}"
        echo "├──────────────────────────────────────────────"
    fi

done

if [ $ISSUE_FLAG -eq 0 ]; then
    echo -e "│ ${CLR_GREEN}All checked directories have secure permissions${CLR_RESET}"
fi

echo "└──────────────────────────────────────────────"
echo ""

# Final Status Banner
STATUS_MSG=$([ $ISSUE_FLAG -eq 0 ] && echo -e "${CLR_GREEN}SYSTEM SAFE${CLR_RESET}" || echo -e "${CLR_RED}REVIEW REQUIRED${CLR_RESET}")

echo "╔══════════════════════════════════════════════╗"
echo "║ Final Status : $STATUS_MSG"
echo "╚══════════════════════════════════════════════╝"