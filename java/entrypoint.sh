#!/bin/bash
cd /home/container || exit 1

# Configure colors
LBLUE='\033[38;5;39m'
RESET_COLOR='\033[0m'
LOG_PREFIX="[MALWARE SCAN]"

# Print Current Java Version
java -version

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "STARTUP /home/container: ${MODIFIED_STARTUP}"

# Download the latest MCAntiMalware.jar
echo -e "${LOG_PREFIX} Downloading the latest MCAntiMalware..."
curl -L -o ./MCAntiMalware.jar https://github.com/OpticFusion1/MCAntiMalware/releases/latest/download/MCAntiMalware.jar

if [ $? -eq 0 ]; then
    echo -e "${LOG_PREFIX} MCAntiMalware.jar downloaded successfully."
else
    echo -e "${LOG_PREFIX} Failed to download MCAntiMalware.jar. Exiting..."
    exit 1
fi

# Run Malware Scan
echo -e "${LOG_PREFIX} Scanning for malware... (This may take a while)"
java -jar /MCAntiMalware.jar --scanDirectory . --singleScan true --disableAutoUpdate true

if [ $? -eq 0 ]; then
    echo -e "${LOG_PREFIX} Malware scan has passed"
else
    echo -e "${LOG_PREFIX} Malware scan has failed"
    exit 1
fi

# Delete the MCAntiMalware.jar file
rm /MCAntiMalware.jar
echo -e "${LOG_PREFIX} MCAntiMalware.jar has been deleted."

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
echo -e "${LBLUE}Welcome to HR! If you have any issues don't hesitate to contact us on discord at dsc.gg/hostingremade ${RESET_COLOR}"
echo -e "========================================================================================================"
eval "${MODIFIED_STARTUP}"
