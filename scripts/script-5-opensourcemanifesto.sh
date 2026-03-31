#!/bin/bash

# Color Setup
C_GREEN='\033[0;32m'
C_BLUE='\033[0;34m'
C_YELLOW='\033[1;33m'
C_MAGENTA='\033[0;35m'
C_RESET='\033[0m'

clear

echo -e "${C_MAGENTA}╔══════════════════════════════════════════════╗"
echo -e "║         OPEN SOURCE DECLARATION TOOL         ║"
echo -e "╚══════════════════════════════════════════════╝${C_RESET}"

echo ""
echo -e "${C_YELLOW}Provide a few inputs to generate your statement${C_RESET}"
echo ""
read -p "Press Enter to begin..."

clear

# Question 1
echo -e "${C_BLUE}┌─[ INPUT 1 ]──────────────────────────────────┐${C_RESET}"
echo -e "${C_YELLOW}Name a tool you regularly use:${C_RESET}"
read -p "➜ " TOOL_NAME

echo ""

# Question 2
echo -e "${C_BLUE}┌─[ INPUT 2 ]──────────────────────────────────┐${C_RESET}"
echo -e "${C_YELLOW}Define 'freedom' in one word:${C_RESET}"
read -p "➜ " FREEDOM_WORD

echo ""

# Question 3
echo -e "${C_BLUE}┌─[ INPUT 3 ]──────────────────────────────────┐${C_RESET}"
echo -e "${C_YELLOW}What would you like to create?:${C_RESET}"
read -p "➜ " BUILD_IDEA

# System Info
TODAY=$(date '+%d %B %Y')
USER_ID=$(whoami)
SYSTEM_HOST=$(hostname)

if [ -f /etc/os-release ]; then
    OS_INFO=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
else
    OS_INFO=$(uname -s)
fi

# Output file
OUTPUT_FILE="opensource_manifesto_${USER_ID}_$(date +%Y%m%d).txt"

# Generate Manifesto
cat > "$OUTPUT_FILE" <<EOF
╔══════════════════════════════════════════════════════════════╗
║                  OPEN SOURCE DECLARATION                     ║
╠══════════════════════════════════════════════════════════════╣
║ Date   : $TODAY
║ User   : $USER_ID@$SYSTEM_HOST
║ System : $OS_INFO
╚══════════════════════════════════════════════════════════════╝

I rely on $TOOL_NAME in my daily workflow. It reflects the strength of open collaboration.

To me, freedom stands for $FREEDOM_WORD — the ability to explore, modify, and share knowledge without restriction.

I aim to contribute by developing and sharing $BUILD_IDEA with the community.

I support open ecosystems, continuous learning, and collective innovation.

Signed,
$USER_ID
$TODAY
EOF

clear

echo -e "${C_GREEN}✔ Your manifesto has been created successfully${C_RESET}"
echo ""
echo -e "${C_YELLOW}Saved as: $OUTPUT_FILE${C_RESET}"

echo ""
echo "┌─[ FILE PREVIEW ]────────────────────────────"
cat "$OUTPUT_FILE"
echo "└──────────────────────────────────────────────"

echo ""
read -p "Press Enter to close..."