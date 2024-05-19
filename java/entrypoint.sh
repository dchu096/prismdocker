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
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "STARTUP /home/container: ${MODIFIED_STARTUP}"

# Run the Server
# shellcheck disable=SC2086
echo "     __  __           __  _             ____                           __    "
echo "    / / / /___  _____/ /_(_)___  ____ _/ __ \___  ____ ___  ____ _____/ /__  "
echo "   / /_/ / __ \/ ___/ __/ / __ \/ __ `/ /_/ / _ \/ __ `__ \/ __ `/ __  / _ \ "
echo "  / __  / /_/ (__  ) /_/ / / / / /_/ / _, _/  __/ / / / / / /_/ / /_/ /  __/ "
echo " /_/ /_/\____/____/\__/_/_/ /_/\__, /_/ |_|\___/_/ /_/ /_/\__,_/\__,_/\___/  "
echo "                              /____/                                         "
echo -e "========================================================================================================"
echo -e "${CYAN}Welcome to Gravel Host! If you have any issues don't hesitate to contact us on discord at discord.gg/gravelhost ${RESET_COLOR}"
echo -e "========================================================================================================"
eval ${MODIFIED_STARTUP}




