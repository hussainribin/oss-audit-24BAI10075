#!/bin/bash

# ===== PACKAGE NAME TO INSPECT =====
PKG_NAME="libreoffice"

# Clear terminal screen
clear

# ===== HEADER =====
echo "╔══════════════════════════════════════════════╗"
echo "║           OPEN SOURCE PACKAGE REVIEW         ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ===== DISPLAY SELECTED PACKAGE =====
echo "┌─[ SELECTED PACKAGE ]─────────────────────────"
echo "│ Name        : $PKG_NAME"
echo "└──────────────────────────────────────────────"
echo ""

# ===== CHECK PACKAGE INSTALLATION =====
echo "┌─[ INSTALLATION INFO ]────────────────────────"

# Check if package exists using pacman
if pacman -Qi "$PKG_NAME" >/dev/null 2>&1; then

    echo "│ Availability : Present on system"
    echo "├──────────────────────────────────────────────"

    # Store package information for reuse
    PKG_INFO=$(pacman -Qi "$PKG_NAME")

    # Extract and display package details
    echo "│ Version      : $(echo "$PKG_INFO" | awk -F': ' '/Version/ {print $2}')"
    echo "│ Platform     : $(echo "$PKG_INFO" | awk -F': ' '/Architecture/ {print $2}')"
    echo "│ License Type : $(echo "$PKG_INFO" | awk -F': ' '/Licenses/ {print $2}')"
    echo "│ Build Time   : $(echo "$PKG_INFO" | awk -F': ' '/Build Date/ {print $2}')"
    echo "│ Maintained By: $(echo "$PKG_INFO" | awk -F': ' '/Packager/ {print $2}')"

    # Check if executable command exists and show version
    if command -v "$PKG_NAME" >/dev/null 2>&1; then
        RUN_VER=$($PKG_NAME --version 2>/dev/null | head -n1)
        echo "│ Executable   : $RUN_VER"
    fi

else
    # If package is not installed
    echo "│ Availability : Not found"
    echo "│ Suggestion   : sudo pacman -S ${PKG_NAME}"
fi

echo "└──────────────────────────────────────────────"
echo ""

# ===== PROJECT BACKGROUND / PHILOSOPHY =====
echo "┌─[ PROJECT BACKGROUND ]───────────────────────"

# Display information based on selected package
case "$PKG_NAME" in
    libreoffice)
        echo "│ LibreOffice Suite"
        echo "│"
        echo "│ Emerged as a community-led fork in 2010"
        echo "│ Promotes openness and independence"
        echo "│"
        echo "│ License Model : MPL 2.0"
        echo "│ Structure     : File-level copyleft"
        echo "│ Emphasis      : Open Document Formats"
        echo "│"
        echo "│ Core Value    : User data ownership"
        ;;
    httpd)
        echo "│ Apache Web Server"
        echo "│ A major foundation of modern web hosting"
        ;;
    mysql)
        echo "│ MySQL Database System"
        echo "│ Popular relational database solution"
        ;;
    vlc)
        echo "│ VLC Media Player"
        echo "│ Known for broad media compatibility"
        ;;
    firefox)
        echo "│ Mozilla Firefox"
        echo "│ Focuses on privacy and open web standards"
        ;;
    *)
        # Default message for unknown packages
        echo "│ No additional background available"
        ;;
esac

echo "└──────────────────────────────────────────────"
echo ""

# ===== OPEN SOURCE PRINCIPLES =====
echo "┌─[ OPEN SOURCE VALUES ]───────────────────────"

echo "│ ✔ Collaborative development"
echo "│ ✔ Source code transparency"
echo "│ ✔ Freedom to customize and redistribute"
echo "│ ✔ Independence from vendors"
echo "│ ✔ Open and free accessibility"

echo "└──────────────────────────────────────────────"
echo ""

# ===== FOOTER =====
echo "╔══════════════════════════════════════════════╗"
echo "║   Report created on: $(date '+%H:%M:%S %d-%m-%Y')   ║"
echo "╚══════════════════════════════════════════════╝"
