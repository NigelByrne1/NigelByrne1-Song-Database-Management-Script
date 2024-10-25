#!/bin/bash
# Author: Nigel Byrne 20058969
# Song Database Management Script
# This script is designed to manage a simple song database using bash scripting. 

#clear terminal
clear
echo -e "\nSong Database Management System"

#(!-f) searches for file song_database.txt and if there is not result then touch creates one
#bogus loading animation added for ux
echo -ne "Searching for existing Song Database"
for ((i = 0 ; i < 5 ; i++)); do
        sleep 0.2
        echo -ne "."
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
    clear
    echo -e "~~~~~~~~~~~~\n Add Song\n~~~~~~~~~~~~"
    #artist section with validation 
    while true; do
        read -p "Enter artist name: " artist
        if [ -z "$artist" ]; then
            echo "Artist name cannot be empty. Please enter a valid artist name."
        else
            break
        fi
    done
    #song title scection with validation
    while true; do
        read -p "Enter song title: " title
        if [ -z "$title" ]; then
            echo "Title name cannot be empty. Please enter a valid Title for song."
        else
            break
        fi
    done
    #genre section with multible choice menu using case $choice
    while true; do
        read -p "Choose an Genre: 1= Pop, 2=Dance, 3=Rock 4=Other: " choice
        case $choice in 
        1) genre="Pop";break;;
        2) genre="Dance";break;;
        3) genre="Rock";break;;
        4) genre="Other";break;;
        *) echo "Invalid option. Please choose a valid menu option";;
        esac
    done

    #bpm section with check for number/int
    #regex (=~) ensures that the input is one or more digits and nothing else
    #^ = beggening of string
    #[0-9] = numbers 1-9
    #+ = one of more occurences of number
    #$ = the end of string
    while true; do
        read -p "Enter the tracks BPM (beats per minute), must be a number: " bpm
        if [[ -z "$bpm" ]]; then
            echo "BPM must not be empty. Please enter a BPM"
        elif [[ "$bpm" =~ ^[0-9]+$ ]]; then 
            break
        else
            echo "invalid BPM please enter a number"
        fi
    done

    #key section must be valid camelot key for DJs
    while true; do
        read -p "Enter Key of Song (must be a camelot key 1A, 12B etc): " key
        if [[ "$key" == "1A" || "$key" == "1B" || "$key" == "2A" || "$key" == "2B" || "$key" == "3A" || "$key" == "3B" || "$key" == "4A" || "$key" == "4B" || "$key" == "5A" || "$key" == "5B" || "$key" == "6A" || "$key" == "6B" || "$key" == "7A" || "$key" == "7B" || "$key" == "8A" || "$key" == "8B" || "$key" == "9A" || "$key" == "9B" || "$key" == "10A" || "$key" == "10B" || "$key" == "11A" || "$key" == "11B" || "$key" == "12A" || "$key" == "12B" ]]; then
            break
        else
            echo "Invalid Camelot key. Please enter a valid key (e.g., 8A, 12B)."
        fi
    done

    #auto assign track id based on number of lines in db file eg id = "(number of lines in file +1)"
    track_id=$(( $(wc -l < "$song_db") + 1 ))

    #add song record comma delimiter >> song_db
    echo "$track_id,$artist,$title,$genre,$bpm,$key" >> "$song_db"
    clear
    echo "Song added successfully!"

    #read waits for the user to hit enter so by putting this at the end of functions it gives user chance to read output before screen is cleared 
    read -p "Press [Enter] to continue..."

}

search_song(){
    clear
    echo -e "~~~~~~~~~~~~\n Search Song\n~~~~~~~~~~~~"
    read -p "Enter search term (ID, artist, title, BPM, or key): " search_term
    #grep -i for case insensitivity 
    searchResult=$(grep -i "$search_term" "$song_db")

    if [ -z "$searchResult" ]; then
        #the \ before the " makes sure the quotes are printed in the echo and no seen as special characters
        echo -e "\nNo records for \"$search_term\" found. Please try again"
    else
        echo -e "\n~~~~~~~~~~~~~~~~ Results ~~~~~~~~~~~~~~~~"
        echo "Track ID, Artist, Title, Genre, BPM, Key"
        echo -e "$searchResult\n"
    fi

    #read waits for the user to hit enter so by putting this at the end of functions it gives user chance to read output before screen is cleared 
    read -p "Press [Enter] to continue..."
}

remove_song(){
    clear
    echo -e "~~~~~~~~~~~~\n Remove Song\n~~~~~~~~~~~~"

    read -p "Would you like to list all songs before removing? (y/n): " list_choice
    if [[ "$list_choice" == "y" || "$list_choice" == "Y" ]]; then
        echo "----------------------------------------------"
        echo "Track ID, Artist, Title, Genre, BPM, Key"
        echo "----------------------------------------------"
        cat "$song_db"
        echo "----------------------------------------------"
    fi

    while true; do
        read -p "Enter the Track ID of the song to remove: " track_id
        #Check if the Track ID exists in the database using grep same as search -q means it runs without printing result
        if grep -q "^$track_id," "$song_db"; then
            #Confirm deletion
            read -p "Are you sure you want to remove the song with Track ID $track_id? (y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                #Remove the line containing the specified Track ID
                #sed -i deletes directly within the file song_db
                #locater: ^ caret begginning of line, track_id variable eg 3, "," comma delimeter so only first part of line is searched/matched, d delete using sed
                sed -i "/^$track_id,/d" "$song_db"
                echo -e "\nSong with Track ID $track_id removed successfully!"
                break
            else
                echo "Removal canceled. No song was removed."
                break
            fi
        else
            echo -e "\nTrack ID $track_id not found. Please enter a valid Track ID."
        fi
    done

    #read waits for the user to hit enter so by putting this at the end of functions it gives user chance to read output before screen is cleared 
    read -p "Press [Enter] to continue..."
}

generate_report(){
    clear
    echo -e "~~~~~~~~~~~~\n Generate Report\n~~~~~~~~~~~~"

    # Check if the database is empty
    if [ ! -s "$song_db" ]; then
        echo -e "\nThe song database is empty. Please add some songs first."
    else

    
    #read waits for the user to hit enter so by putting this at the end of functions it gives user chance to read output before screen is cleared 
    read -p "Press [Enter] to continue..."
}

save_backup(){
    clear
    echo -e "~~~~~~~~~~~~\n Save Backup\n~~~~~~~~~~~~"
    read -p "Are you sure you want to overwrite the existing backup? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        cp "$song_db" "${song_db}.bak"
        echo "Backup saved successfully!"
    else
        echo "Backup operation canceled."
    fi
    #read waits for the user to hit enter so by putting this at the end of functions it gives user chance to read output before screen is cleared 
    read -p "Press [Enter] to continue..."
}

load_backup(){
    clear
    echo -e "~~~~~~~~~~~~\n Load Backup\n~~~~~~~~~~~~"
    read -p "Are you sure you want to load the backup? This will overwrite the current database. (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        if [ -f "${song_db}.bak" ]; then
            cp "${song_db}.bak" "$song_db"
            echo "Backup loaded successfully!"
        else
            echo "No backup file found."
        fi
    else
        echo "Load backup operation canceled."
    fi
    #read waits for the user to hit enter so by putting this at the end of functions it gives user chance to read output before screen is cleared 
    read -p "Press [Enter] to continue..."
}

main_menu(){
    
    while true; do 
        clear
        echo -e "~~~~~~~~~~~~\n Main Menu\n~~~~~~~~~~~~"
        echo "1. Add a new song"
        echo "2. Search for a song"
        echo "3. Remove a song"
        echo "4. Generate a report"
        echo "5. Save a backup of database. (.bak)"
        echo "6. Load backup of database"
        echo "7. Exit"
        read -p "Choose an option: " choice

        case $choice in 
            1) add_song ;;
            2) search_song ;;
            3) remove_song ;;
            4) generate_report ;;
            5) save_backup ;;
            6) load_backup ;;
            7) 
                echo "Exiting the App..."
                sleep 1
                clear
                break
                ;;
            *)
                echo "Invalid option. Please choose a valid menu option"
                #read waits for the user to hit enter so by putting this at the end of functions it gives user chance to read output before screen is cleared 
                read -p "Press [Enter] to continue..."
                ;;
        esac
    done
}

main_menu