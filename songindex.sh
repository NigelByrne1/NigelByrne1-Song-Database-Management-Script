#!/bin/bash
# Author: Nigel Byrne 20058969
# Song Database Management Script
# Description:
# This script is designed to manage a simple song database using bash scripting. The database allows users to:
# 1. Add new song records (including artist name, song title, genre, BPM, and Camelot key).
# 2. Search for songs by various attributes (artist, title, genre).
# 3. Remove songs from the database by specifying the title.
# 4. Generate reports to view all songs or filter by genre.
# 5. Provide a user-friendly menu to interact with these features.
# The script uses a text file to store the data, ensuring it is lightweight and easy to use for a basic cataloging system.

#clear terminal
clear
echo -e "\nSong Database Management System"

#(!-f) searches for file song_database.txt and if there is not result then touch creates one
echo -ne "Searching for existing Song Database"
for ((i = 0 ; i < 5 ; i++)); do
    echo -ne "."
    sleep 0.5
done
echo ""
if [ ! -f "song_database.txt" ]; then  
    echo "Database file not found. Creating a new song database file"
    touch "song_database.txt"
else 
    echo "Database file found"
fi
sleep 1

clear
echo -e "Song Database Management System"

#create a variable to hold the filename for textfile
song_db="song_database.txt"

add_song(){
    echo "add a new song.."
    #todo write rest of function
}

search_song(){
    echo "search for a song.."
    #todo write rest of function
}

remove_song(){
    echo "remove a song.."
    #todo write rest of function
}

generate_report(){
    echo "generate a report.."
    #todo write rest of function
}

main_menu(){
    while true; do 
        echo -e "\nMain Menu"
        echo "1. Add a new song"
        echo "2. Search for a song"
        echo "3. Remove a song"
        echo "4. Generate a report"
        echo "5. Exit"
        read -p "Choose an option: " choice

        case $choice in 
            1) add_song ;;
            2) search_song ;;
            3) remove_song ;;
            4) generate_report ;;
            5) 
                echo "Exiting the App..."
                break
                ;;
            *)
                echo "Invalid option. Please choose a valid menu option"
                ;;
        esac
    done
}

main_menu