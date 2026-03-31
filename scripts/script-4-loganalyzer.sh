#!/bin/bash

# Input Handling
INPUT_LOG=${1:-""}
SEARCH_TERM=${2:-"error"}

# Color Setup
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_BLUE='\033[0;34m'
C_RESET='\033[0m'

clear

echo "╔══════════════════════════════════════════════╗"
echo "║            SYSTEM LOG INSPECTION TOOL        ║"
echo "╚══════════════════════════════════════════════╝"

# If no logfile provided
if [ -z "$INPUT_LOG" ]; then
    echo ""
    echo -e "${C_YELLOW}⚠ No input file specified${C_RESET}"
    echo ""

    LO_DIR="$HOME/.config/libreoffice"

    echo "┌─[ AUTO SEARCH ]─────────────────────────────"
    if [ -d "$LO_DIR" ]; then
        echo -e "│ ${C_BLUE}Looking for LibreOffice log files...${C_RESET}"
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

# File validation
if [ ! -f "$INPUT_LOG" ]; then
    echo -e "${C_RED}Error: File does not exist -> $INPUT_LOG${C_RESET}"
    exit 1
fi

if [ ! -r "$INPUT_LOG" ]; then
    echo -e "${C_RED}Error: Cannot read file${C_RESET}"
    exit 1
fi

# File details
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

# Keyword search
MATCH_TOTAL=$(grep -i "$SEARCH_TERM" "$INPUT_LOG" | wc -l)

echo ""
echo "┌─[ SEARCH SUMMARY ]──────────────────────────"
echo "│ Keyword Used : $SEARCH_TERM"
echo -e "│ Matches Found: ${C_GREEN}$MATCH_TOTAL${C_RESET}"
echo "└──────────────────────────────────────────────"

if [ "$MATCH_TOTAL" -gt 0 ]; then

    echo ""
    echo "┌─[ RECENT MATCHES ]──────────────────────────"
    grep -in "$SEARCH_TERM" "$INPUT_LOG" | tail -5 | while IFS=: read -r ln txt; do
        echo -e "│ ${C_YELLOW}[$ln]${C_RESET} $txt"
    done
    echo "└──────────────────────────────────────────────"

    echo ""
    echo "┌─[ INITIAL OCCURRENCE ]──────────────────────"
    FIRST_LINE=$(grep -in "$SEARCH_TERM" "$INPUT_LOG" | head -1)
    LINE_NO=$(echo "$FIRST_LINE" | cut -d: -f1)
    LINE_TXT=$(echo "$FIRST_LINE" | cut -d: -f2-)
    echo -e "│ ${C_YELLOW}[$LINE_NO]${C_RESET} $LINE_TXT"
    echo "└──────────────────────────────────────────────"

    echo ""
    echo "┌─[ ISSUE CATEGORIES ]────────────────────────"

    CRASHES=$(grep -ic "crash\|segfault\|abort\|assert" "$INPUT_LOG")
    PERMS=$(grep -ic "permission\|denied\|access" "$INPUT_LOG")
    NETWORK=$(grep -ic "network\|connection\|timeout\|socket" "$INPUT_LOG")

    [ "$CRASHES" -gt 0 ] && echo "│ Crash-related      : $CRASHES"
    [ "$PERMS" -gt 0 ] && echo "│ Permission-related : $PERMS"
    [ "$NETWORK" -gt 0 ] && echo "│ Network-related    : $NETWORK"

    echo "└──────────────────────────────────────────────"

    # Percentage stats
    if command -v bc >/dev/null 2>&1 && [ "$TOTAL_LINES" -gt 0 ]; then
        PERCENT=$(echo "scale=2; $MATCH_TOTAL*100/$TOTAL_LINES" | bc)

        echo ""
        echo "┌─[ ANALYTICS ]───────────────────────────────"
        echo "│ Occurrence Rate : $PERCENT %"
        echo "└──────────────────────────────────────────────"
    fi

else
    echo -e "\n${C_GREEN}✔ No matching entries detected${C_RESET}"
fi

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║             LOG ANALYSIS FINISHED            ║"
echo "╚══════════════════════════════════════════════╝"