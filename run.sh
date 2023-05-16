#!/bin/bash

# Set default output directory relative to the current working directory
default_output_dir="$(pwd)/dist"

# Parse command-line options
while getopts ":o:e:" opt; do
  case $opt in
    o)
      output_dir=$OPTARG
      ;;
    e)
      variable=${OPTARG%=*}
      value=${OPTARG#*=}
      declare -A variables
      variables["$variable"]="$value"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Use default output directory if not specified
if [ -z "$output_dir" ]; then
  output_dir=$default_output_dir
fi

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Copy files from src directory to output directory, including hidden files
shopt -s dotglob
cp -R template/* "$output_dir"

# Perform variable interpolation on the contents of the output directory
for variable in "${!variables[@]}"; do
  value="${variables[$variable]}"
  echo "$variable = $value"
  for file in "$output_dir"/.* "$output_dir"/*; do
    if [ -f "$file" ]; then
      sed -i "s/{{$variable}}/$value/g" "$file"
    fi
  done
done

echo "Files copied from src to $output_dir with variable interpolation."
