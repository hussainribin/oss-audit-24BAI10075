#!/bin/bash

# ===== COLOR DEFINITIONS =====
# Used for highlighting output in terminal
CLR_RED='\033[0;31m'      # Red for warnings/errors
CLR_GREEN='\033[0;32m'    # Green for safe status
CLR_YELLOW='\033[1;33m'   # Yellow for missing items
CLR_RESET='\033[0m'       # Reset color

# ===== TARGET DIRECTORIES =====
# Directories related to LibreOffice to be checked
TARGET_PATHS=("/usr/lib/libreoffice" "/usr/share/libreoffice" "/etc/libreoffice")

# Clear terminal screen
clear

# ===== HEADER =====
echo "╔══════════════════════════════════════════════╗"
echo "║        LIBREOFFICE PERMISSION INSPECTOR      ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ===== SCAN SECTION =====
echo "┌─[ SCAN RESULTS ]─────────────────────────────"

# Flag to track if any insecure directory is found
ISSUE_FLAG=0

# Loop through each directory
for PATH_ITEM in "${TARGET_PATHS[@]}"; do

    # Check if directory exists
    if [ -d "$PATH_ITEM" ]; then

        # Get symbolic permissions (e.g., drwxr-xr-x)
        PERMISSION=$(stat -c %A "$PATH_ITEM")

        # Extract "others" permission digit (last digit of octal)
        OTHER_ACCESS=$(stat -c %a "$PATH_ITEM" | cut -c3)

        # Check if directory is world-writable (others >= 2 means write access)
        if [ "$OTHER_ACCESS" -ge 2 ]; then
            echo -e "│ ${CLR_RED}⚠ Warning: $PATH_ITEM${CLR_RESET}"
            echo "│   Permissions : $PERMISSION"
            echo "│   Issue       : Public write access detected"
            echo "├──────────────────────────────────────────────"

            # Mark issue found
            ISSUE_FLAG=1
        else
            # Directory is safe
            echo -e "│ ${CLR_GREEN}✔ Safe: $PATH_ITEM${CLR_RESET}"
            echo "│   Permissions : $PERMISSION"
            echo "├──────────────────────────────────────────────"
        fi

    else
        # Directory does not exist
        echo -e "│ ${CLR_YELLOW}• Not Found: $PATH_ITEM${CLR_RESET}"
        echo "├──────────────────────────────────────────────"
    fi

done

# If no issues found, display secure message
if [ $ISSUE_FLAG -eq 0 ]; then
    echo -e "│ ${CLR_GREEN}All checked directories have secure permissions${CLR_RESET}"
fi

echo "└──────────────────────────────────────────────"
echo ""

# ===== FINAL STATUS =====
# Display overall result based on scan
STATUS_MSG=$([ $ISSUE_FLAG -eq 0 ] && echo -e "${CLR_GREEN}SYSTEM SAFE${CLR_RESET}" || echo -e "${CLR_RED}REVIEW REQUIRED${CLR_RESET}")

echo "╔══════════════════════════════════════════════╗"
echo "║ Final Status : $STATUS_MSG"
echo "╚══════════════════════════════════════════════╝"
