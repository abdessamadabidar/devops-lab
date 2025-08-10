#!/bin/sh

out_dir="$HOME/devops-lab/log-archive/archives"

check_given_dir() {
    # Check whether the given path exists
    if [ ! -d "$1" ]; then
        echo "The given logs directory not found!"
        exit 1
    fi
}

main() {
    src_dir="$1"

    if [ -z "$src_dir" ]; then
        echo "No directory provided!"
        exit 1
    fi

    check_given_dir "$src_dir"

    # Create the out directory if not exist
    mkdir -p "$out_dir"

    # Loop through subdirectories in the source directory
    for dir in "$src_dir"/*; do
        if [ -d "$dir" ]; then
            dir_name=$(basename "$dir")
            archive_file="logs_archive_$(date +%Y%m%d_%H%M%S).tar.gz"

            # Compress logs subdirectory
             tar -czvf "$out_dir/$archive_file" "$dir"

            # Check whether the compression was successful
            if [ $? -eq 0 ]; then
                echo "$dir was compressed successfully to $archive_file"

                # Delete the compressed directory
                rm -rf "$dir"

		echo "$dir was deleted successfully"
            else
                echo "An error occurred when compressing $dir"
            fi

            sleep 1
        fi
    done
}

# Check if argument provided and call main
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

main "$1"

