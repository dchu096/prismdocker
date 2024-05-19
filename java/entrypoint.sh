#!/bin/bash
cd /home/container || exit 1

# Configure colors
CYAN='\033[0;36m'
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
echo -e "${CYAN}Welcome to HR! If you have any issues don't hesitate to contact us on discord at discord.hostingremade.com ${RESET_COLOR}"
echo -e "========================================================================================================"
eval "${MODIFIED_STARTUP}"
