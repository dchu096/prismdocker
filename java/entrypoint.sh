#!/bin/bash
cd /home/container || exit 1

# Configure colors
LBLUE='\033[38;5;39m'
ORANGE='\033[38;5;214m'
RESET_COLOR='\033[0m'

# Print Current Java Version
java -version

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "STARTUP /home/container: ${MODIFIED_STARTUP}"

# Run the Server
# shellcheck disable=SC2086
cat << 'EOF'
    __  __           __  _             ____                           __   
   / / / /___  _____/ /_(_)___  ____ _/ __ \___  ____ ___  ____ _____/ /__ 
  / /_/ / __ \/ ___/ __/ / __ \/ __ `/ /_/ / _ \/ __ `__ \/ __ `/ __  / _ \
 / __  / /_/ (__  ) /_/ / / / / /_/ / _, _/  __/ / / / / / /_/ / /_/ /  __/
/_/ /_/\____/____/\__/_/_/ /_/\__, /_/ |_|\___/_/ /_/ /_/\__,_/\__,_/\___/ 
                             /____/                                         
EOF

echo -e "========================================================================================================"
#echo -e "${ORANGE} Happy Halloween everyone! Please don't hesitate to contact us on Discord if you have any issues at dsc.gg/hostingremade ${RESET_COLOR}"
echo -e "${LBLUE}Hey! Welcome to ${ORANGE}HostingRemade${LBLUE}! Need help? Reach us on Discord: dsc.gg/hostingremade ${RESET_COLOR}"
echo -e "========================================================================================================"
eval "${MODIFIED_STARTUP}"
