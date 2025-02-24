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
    ____       _                _   __          __         
   / __ \_____(_)________ ___  / | / /___  ____/ /__  _____
  / /_/ / ___/ / ___/ __ `__ \/  |/ / __ \/ __  / _ \/ ___/
 / ____/ /  / (__  ) / / / / / /|  / /_/ / /_/ /  __(__  ) 
/_/   /_/  /_/____/_/ /_/ /_/_/ |_/\____/\__,_/\___/____/  
EOF

echo -e "========================================================================================================"
#echo -e "${ORANGE} Happy Halloween everyone! Please don't hesitate to contact us on Discord if you have any issues at dsc.gg/hostingremade ${RESET_COLOR}"
echo -e "${LBLUE}Thankyou for choosing PrismNodes! Need help? Reach us on Discord: discord.gg/prismnodes ${RESET_COLOR}"
echo -e "========================================================================================================"
eval "${MODIFIED_STARTUP}"
