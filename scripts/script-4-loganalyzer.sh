#!/bin/bash

# ===== INPUT HANDLING =====
# Accept logfile as first argument and keyword as second (default: "error")
INPUT_LOG=${1:-""}
SEARCH_TERM=${2:-"error"}

# ===== COLOR SETUP =====
# Used for formatted terminal output
C_RED='\033[0;31m'      # Error messages
C_GREEN='\033[0;32m'    # Success / no issues
C_YELLOW='\033[1;33m'   # Warnings
C_BLUE='\033[0;34m'     # Info messages
C_RESET='\033[0m'       # Reset color

# Clear terminal screen
clear

# ===== HEADER =====
echo "╔══════════════════════════════════════════════╗"
echo "║            SYSTEM LOG INSPECTION TOOL        ║"
echo "╚══════════════════════════════════════════════╝"

# ===== HANDLE MISSING INPUT =====
# If no logfile is provided, try to discover LibreOffice logs
if [ -z "$INPUT_LOG" ]; then
    echo ""
    echo -e "${C_YELLOW}⚠ No input file specified${C_RESET}"
    echo ""

    LO_DIR="$HOME/.config/libreoffice"

    echo "┌─[ AUTO SEARCH ]─────────────────────────────"
    
    # Check if LibreOffice config directory exists
    if [ -d "$LO_DIR" ]; then
        echo -e "│ ${C_BLUE}Looking for LibreOffice log files...${C_RESET}"
        
        # Find all .log files inside the directory
        find "$LO_DIR" -type f -name "*.log" 2>/dev/null | while read -r file; do
            echo "│ • $file"
        done
    else
        echo "│ LibreOffice directory not available"
    fi

    echo "└──────────────────────────────────────────────"
    echo ""
    echo "Usage: $0 <logfile> [keyword]"
    exit 1
fi

# ===== FILE VALIDATION =====
# Check if file exists
if [ ! -f "$INPUT_LOG" ]; then
    echo -e "${C_RED}Error: File does not exist -> $INPUT_LOG${C_RESET}"
    exit 1
fi

# Check if file is readable
if [ ! -r "$INPUT_LOG" ]; then
    echo -e "${C_RED}Error: Cannot read file${C_RESET}"
    exit 1
fi

# ===== FILE DETAILS =====
# Get file size, total lines, and last modified time
FILE_SIZE=$(du -h "$INPUT_LOG" | awk '{print $1}')
TOTAL_LINES=$(wc -l < "$INPUT_LOG")
LAST_MOD=$(stat -c %y "$INPUT_LOG" | cut -d'.' -f1)

echo ""
echo "┌─[ LOG DETAILS ]─────────────────────────────"
echo "│ File Path   : $INPUT_LOG"
echo "│ File Size   : $FILE_SIZE"
echo "│ Total Lines : $TOTAL_LINES"
echo "│ Last Update : $LAST_MOD"
echo "└──────────────────────────────────────────────"

# ===== KEYWORD SEARCH =====
# Count occurrences of keyword (case-insensitive)
MATCH_TOTAL=$(grep -i "$SEARCH_TERM" "$INPUT_LOG" | wc -l)

echo ""
echo "┌─[ SEARCH SUMMARY ]──────────────────────────"
echo "│ Keyword Used : $SEARCH_TERM"
echo -e "│ Matches Found: ${C_GREEN}$MATCH_TOTAL${C_RESET}"
echo "└──────────────────────────────────────────────"

# ===== IF MATCHES FOUND =====
if [ "$MATCH_TOTAL" -gt 0 ]; then

    # Show last 5 matching lines with line numbers
    echo ""
    echo "┌─[ RECENT MATCHES ]──────────────────────────"
    grep -in "$SEARCH_TERM" "$INPUT_LOG" | tail -5 | while IFS=: read -r ln txt; do
        echo -e "│ ${C_YELLOW}[$ln]${C_RESET} $txt"
    done
    echo "└──────────────────────────────────────────────"

    # Show first occurrence of keyword
    echo ""
    echo "┌─[ INITIAL OCCURRENCE ]──────────────────────"
    FIRST_LINE=$(grep -in "$SEARCH_TERM" "$INPUT_LOG" | head -1)
    LINE_NO=$(echo "$FIRST_LINE" | cut -d: -f1)
    LINE_TXT=$(echo "$FIRST_LINE" | cut -d: -f2-)
    echo -e "│ ${C_YELLOW}[$LINE_NO]${C_RESET} $LINE_TXT"
    echo "└──────────────────────────────────────────────"

    # ===== ISSUE PATTERN DETECTION =====
    echo ""
    echo "┌─[ ISSUE CATEGORIES ]────────────────────────"

    # Count common issue types
    CRASHES=$(grep -ic "crash\|segfault\|abort\|assert" "$INPUT_LOG")
    PERMS=$(grep -ic "permission\|denied\|access" "$INPUT_LOG")
    NETWORK=$(grep -ic "network\|connection\|timeout\|socket" "$INPUT_LOG")

    # Display detected issues if any
    [ "$CRASHES" -gt 0 ] && echo "│ Crash-related      : $CRASHES"
    [ "$PERMS" -gt 0 ] && echo "│ Permission-related : $PERMS"
    [ "$NETWORK" -gt 0 ] && echo "│ Network-related    : $NETWORK"

    echo "└──────────────────────────────────────────────"

    # ===== STATISTICS =====
    # Calculate percentage of matching lines (if bc is available)
    if command -v bc >/dev/null 2>&1 && [ "$TOTAL_LINES" -gt 0 ]; then
        PERCENT=$(echo "scale=2; $MATCH_TOTAL*100/$TOTAL_LINES" | bc)

        echo ""
        echo "┌─[ ANALYTICS ]───────────────────────────────"
        echo "│ Occurrence Rate : $PERCENT %"
        echo "└──────────────────────────────────────────────"
    fi

else
    # No matches found
    echo -e "\n${C_GREEN}✔ No matching entries detected${C_RESET}"
fi

# ===== FOOTER =====
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║             LOG ANALYSIS FINISHED            ║"
echo "╚══════════════════════════════════════════════╝"
