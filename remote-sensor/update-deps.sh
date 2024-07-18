#!/bin/bash

# Function to update a single dependency and check build status
update_dependency() {
    local dependency=$1
    jj commit -m "Updating $dependency..."
    echo "Updating $dependency..."

    # Update the dependency
    cargo upgrade $dependency

    # Try to build the project
    if cargo build; then
        echo "$dependency updated and build succeeded."
    else
        echo "Build failed after updating $dependency. Reverting..."
        # git checkout -- Cargo.toml Cargo.lock
        exit 1
    fi
}

# Ensure git is available to revert changes
# if ! command -v git &> /dev/null; then
#     echo "git command not found. Please install git to use this script."
#     exit 1
# fi

# Ensure the project is under version control (git)
# if [ ! -d ".git" ]; then
#     echo "This script requires the project to be under git version control."
#     exit 1
# fi

# Get the list of dependencies
dependencies=$(grep '^[a-zA-Z]' Cargo.toml | cut -d ' ' -f 1)

# Iterate through each dependency and update it
for dep in $dependencies; do
    update_dependency $dep
done

echo "All dependencies updated successfully."

