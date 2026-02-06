#!/bin/bash
# Simulated crew-code output for demo GIF recording
# This prints representative output — not a live session

PURPLE='\033[38;5;141m'
GREEN='\033[38;5;78m'
BLUE='\033[38;5;75m'
YELLOW='\033[38;5;220m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'
WHITE='\033[97m'

sleep 0.8

# Routing banner
echo ""
printf "${PURPLE}${BOLD}╭──────────────────────────────────────────────────╮${RESET}\n"
sleep 0.1
printf "${PURPLE}${BOLD}│${RESET}  ${WHITE}${BOLD}CREW CODE${RESET} ${DIM}→${RESET} Routing to: ${GREEN}${BOLD}CODEX${RESET}                 ${PURPLE}${BOLD}│${RESET}\n"
sleep 0.1
printf "${PURPLE}${BOLD}│${RESET}  ${DIM}Signals: backend API, Express.js project${RESET}        ${PURPLE}${BOLD}│${RESET}\n"
sleep 0.1
printf "${PURPLE}${BOLD}│${RESET}  ${DIM}Reason: Backend API task → Codex${RESET}                ${PURPLE}${BOLD}│${RESET}\n"
sleep 0.1
printf "${PURPLE}${BOLD}╰──────────────────────────────────────────────────╯${RESET}\n"
echo ""
sleep 0.6

# Phase: gathering context
printf "${YELLOW}${BOLD}⏳ GATHERING CONTEXT${RESET}\n"
sleep 0.3
printf "   ${DIM}Reading CLAUDE.md + project structure...${RESET}\n"
sleep 0.8
printf "   ${DIM}Found: Express.js, TypeScript, 12 source files${RESET}\n"
sleep 0.5
printf "   ${GREEN}✓${RESET} Context ready\n"
echo ""
sleep 0.4

# Phase: plan mode
printf "${YELLOW}${BOLD}⏳ PLAN MODE${RESET}\n"
sleep 0.3
printf "   ${DIM}Codex planning in read-only sandbox...${RESET}\n"
sleep 1.2
printf "   ${DIM}Reviewing plan against project guidelines...${RESET}\n"
sleep 0.8
printf "   ${GREEN}✓${RESET} Plan approved ${DIM}(iteration 1/3)${RESET}\n"
echo ""
sleep 0.4

# Phase: coding mode
printf "${YELLOW}${BOLD}⏳ CODING MODE${RESET}\n"
sleep 0.3
printf "   ${DIM}Codex executing approved plan (full-auto)...${RESET}\n"
sleep 1.5
printf "   ${GREEN}✓${RESET} Code generated\n"
echo ""
sleep 0.6

# Final report
printf "${PURPLE}${BOLD}## Crew Code Report${RESET}\n"
echo ""
printf "${WHITE}${BOLD}### Routing${RESET}\n"
printf "  Backend: ${GREEN}Codex${RESET}\n"
printf "  Signals: backend API, Express.js, no UI components\n"
printf "  Reason: Backend API implementation → Codex\n"
echo ""
printf "${WHITE}${BOLD}### Plan-Review Summary${RESET}\n"
printf "  Iterations: 1/3 — plan approved on first pass\n"
echo ""
printf "${WHITE}${BOLD}### Changes Made${RESET}\n"
printf "  ${GREEN}+${RESET} src/routes/users.ts    ${DIM}GET/POST /users endpoints${RESET}\n"
printf "  ${GREEN}+${RESET} src/models/user.ts     ${DIM}User model with validation${RESET}\n"
printf "  ${GREEN}+${RESET} src/middleware/auth.ts  ${DIM}Auth middleware for /users${RESET}\n"
echo ""
sleep 2
