#!/bin/bash

# Directory where the script is run from
current_directory=$(dirname "$0")

# Directory where the template files are located
template_directory="/template"

# Function for variable interpolation
interpolate_variables() {
    local content="$1"
    while [[ $content =~ (\$\{([a-zA-Z_][a-zA-Z_0-9]*)\}) ]]; do
        variable_name="${BASH_REMATCH[2]}"
        variable_value="${!variable_name}"
        content="${content//${BASH_REMATCH[1]}/${variable_value}}"
    done
    echo "$content"
}

# Copy files from template directory to current directory
copy_files() {
    local file
    for file in "$template_directory"/*; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")
            content=$(<"$file")
            interpolated_content=$(interpolate_variables "$content")
            echo "$interpolated_content" > "$current_directory/$filename"
            echo "Copied $filename"
        fi
    done
}

# Call the function to copy files
copy_files
