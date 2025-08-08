#!/usr/bin/env bash

# Check if the folder argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <folder>"
    exit 1
fi

# Set the folder variable
FOLDER="$1"

# Check if the folder exists
if [ ! -d "$FOLDER" ]; then
    echo "Error: Directory '$FOLDER' does not exist."
    exit 1
fi

# Convert .flac files to .mp3 and delete the .flac files
for file in "$FOLDER"/*.flac; do
    if [ -e "$file" ]; then
        # Get the base name of the file without extension
        base_name=$(basename "$file" .flac)
        # Convert to mp3
        ffmpeg -i "$file" -codec:a libmp3lame "$FOLDER/$base_name.mp3"
        # Check if the conversion was successful
        if [ $? -eq 0 ]; then
            # Delete the original .flac file
            rm "$file"
        else
            echo "Error converting '$file'."
        fi
    else
        echo "No .flac files found in '$FOLDER'."
    fi
done

echo "Conversion completed for folder '$FOLDER'."
