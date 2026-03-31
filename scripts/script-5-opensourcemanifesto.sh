#!/bin/bash

# ===== COLOR SETUP =====
# Define colors for styled terminal output
C_GREEN='\033[0;32m'     # Success messages
C_BLUE='\033[0;34m'      # Section headers
C_YELLOW='\033[1;33m'    # Prompts / input text
C_MAGENTA='\033[0;35m'   # Title banner
C_RESET='\033[0m'        # Reset color

# Clear terminal screen
clear

# ===== HEADER =====
echo -e "${C_MAGENTA}╔══════════════════════════════════════════════╗"
echo -e "║         OPEN SOURCE DECLARATION TOOL         ║"
echo -e "╚══════════════════════════════════════════════╝${C_RESET}"

# Intro message
echo ""
echo -e "${C_YELLOW}Provide a few inputs to generate your statement${C_RESET}"
echo ""
read -p "Press Enter to begin..."

# Clear screen before input phase
clear

# ===== USER INPUT SECTION =====

# Question 1: Tool used daily
echo -e "${C_BLUE}┌─[ INPUT 1 ]──────────────────────────────────┐${C_RESET}"
echo -e "${C_YELLOW}Name a tool you regularly use:${C_RESET}"
read -p "➜ " TOOL_NAME

echo ""

# Question 2: Definition of freedom
echo -e "${C_BLUE}┌─[ INPUT 2 ]──────────────────────────────────┐${C_RESET}"
echo -e "${C_YELLOW}Define 'freedom' in one word:${C_RESET}"
read -p "➜ " FREEDOM_WORD

echo ""

# Question 3: Idea to build
echo -e "${C_BLUE}┌─[ INPUT 3 ]──────────────────────────────────┐${C_RESET}"
echo -e "${C_YELLOW}What would you like to create?:${C_RESET}"
read -p "➜ " BUILD_IDEA

# ===== SYSTEM INFORMATION =====
# Collect system-related details
TODAY=$(date '+%d %B %Y')
USER_ID=$(whoami)
SYSTEM_HOST=$(hostname)

# Get OS information
if [ -f /etc/os-release ]; then
    OS_INFO=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
else
    OS_INFO=$(uname -s)
fi

# ===== OUTPUT FILE CREATION =====
# Define filename using username and date
OUTPUT_FILE="opensource_manifesto_${USER_ID}_$(date +%Y%m%d).txt"

# Generate manifesto content using user inputs and system info
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

# Clear screen before showing result
clear

# ===== OUTPUT DISPLAY =====
echo -e "${C_GREEN}✔ Your manifesto has been created successfully${C_RESET}"
echo ""
echo -e "${C_YELLOW}Saved as: $OUTPUT_FILE${C_RESET}"

# Preview generated file
echo ""
echo "┌─[ FILE PREVIEW ]────────────────────────────"
cat "$OUTPUT_FILE"
echo "└──────────────────────────────────────────────"

# Wait for user before exiting
echo ""
read -p "Press Enter to close..."
