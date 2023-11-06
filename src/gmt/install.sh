#!/bin/bash

#set pipefail

# Check if Git is installed - which would be really funny if it isn't
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    sudo apt-get update
    sudo apt-get install -y git
fi

workspace_root="/workspaces"
destination_dir="/workspaces/green-metrics-tool"

if [ -d "$destination_dir" ]; then
    echo "The repository already exists in $destination_dir. Updating the repository..."

    cd "$destination_dir"
    git pull
    if [ $? -eq 0 ]; then
        echo "Repository updated successfully in $destination_dir."
    else
        echo "Failed to update the repository."
    fi
else
    # Clone the GitHub repository
    git clone https://github.com/green-coding-berlin/green-metrics-tool "$workspace_root"

    if [ $? -eq 0 ]; then
        echo "Repository cloned successfully to $destination_dir."
    else
        echo "Failed to clone the repository."
    fi

    cd "$destination_dir"
fi

# rename ./metric_providers/lm_sensors/Makefile to ./metric_providers/lm_sensors/Makefile.bak
mv ./metric_providers/lm_sensors/Makefile ./metric_providers/lm_sensors/Makefile.bak


./install_linux.sh
