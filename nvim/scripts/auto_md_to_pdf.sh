#!/bin/bash

MARKDOWN_FILE="$1"
PDF_FILE="${MARKDOWN_FILE%.*}.pdf"
LOCK_FILE="/tmp/md_pdf_convert.lock"
LOG_FILE="/tmp/auto_md_to_pdf.log"

# Function to open Zathura
open_zathura() {
    if [ -f "$PDF_FILE" ]; then
        if ! pgrep -f "zathura $PDF_FILE" > /dev/null; then
            zathura "$PDF_FILE" &
            sleep 1  # Give Zathura time to open

            # Get the Neovim window ID
            NVIM_WINDOW=$(hyprctl activewindow -j | jq .address)

            # Move Zathura to the right
            hyprctl dispatch movewindow r

            # Focus back on Neovim
            hyprctl dispatch focuswindow address:$NVIM_WINDOW

            # Adjust the layout
            hyprctl dispatch splitratio 0.5
        fi
    else
        echo "Error: PDF file not found" >> "$LOG_FILE"
    fi
}

# Function to convert Markdown to PDF
convert_to_pdf() {
    echo "Converting $MARKDOWN_FILE to PDF..." >> "$LOG_FILE"
    pandoc "$MARKDOWN_FILE" -o "$PDF_FILE" \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        -V papersize=a4 \
        --wrap=auto \
        --columns=72 \
        -V block-headings \
        2>> "$LOG_FILE"
    if [ $? -eq 0 ]; then
        echo "Conversion successful" >> "$LOG_FILE"
    else
        echo "Conversion failed" >> "$LOG_FILE"
    fi
}

# Initial conversion and Zathura opening
convert_to_pdf
open_zathura

# Use a while loop to continuously watch for file changes
while true; do
    inotifywait -e close_write "$MARKDOWN_FILE"
    (
        flock -n 9 || exit 1
        echo "File changed, converting to PDF..." >> "$LOG_FILE"
        convert_to_pdf
    ) 9>"$LOCK_FILE"
done
