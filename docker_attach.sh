#!/usr/bin/env bash

set -euo pipefail

# Retrieve running containers (ID and Names) into an array
mapfile -t containers < <(docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}")

# Check if any containers are running
if [ ${#containers[@]} -eq 0 ]; then
    echo "No running Docker containers found."
    exit 0
fi

echo "=========================================="
echo "      Select a Running Container          "
echo "=========================================="

# Display containers with a 1-based index
for i in "${!containers[@]}"; do
    num=$((i + 1))
    # Parse container info
    c_id=$(echo "${containers[$i]}" | cut -f1)
    c_name=$(echo "${containers[$i]}" | cut -f2)
    c_image=$(echo "${containers[$i]}" | cut -f3)

    printf "[%2d]  %-20s  (ID: %s, Image: %s)\n" "$num" "$c_name" "$c_id"
done

echo "=========================================="

# Prompt user for selection
read -rp "Enter container number [1-${#containers[@]}]: " selection

# Validate input (must be an integer within range)
if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "${#containers[@]}" ]; then
    echo "Error: Invalid selection." >&2
    exit 1
fi

# Get chosen container ID and Name
chosen_index=$((selection - 1))
chosen_id=$(echo "${containers[$chosen_index]}" | cut -f1)
chosen_name=$(echo "${containers[$chosen_index]}" | cut -f2)

echo "Attaching to '$chosen_name' ($chosen_id)..."

# Try opening /bin/bash, fall back to /bin/sh if bash isn't available
#docker exec -it $chosen_name /bin/bash
docker attach $chosen_name
