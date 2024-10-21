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

    #add song record >> comma delimiter
    echo "$track_id,$artist,$title,$genre,$bpm,$key" >> "$song_db"
    clear
    echo "Song added successfully!"
}

search_song(){
    echo "search for a song.."
    #todo write rest of function
    #search by id

    #search by title

    #search by artist

    #search by bpm range

    #search by key
}

remove_song(){
    echo "remove a song.."
    #todo write rest of function

    #list songs option?

    #remove by id
}

generate_report(){
    echo "generate a report.."
    #todo write rest of function

}

save_backup(){
    echo "placeholder"
    #save a backup file .bak - error handling "are you sure?? this will overwrite the existing backup"
}

load_backup(){
    echo "placeholder"
    #load a backup file - error handling "are you sure? this will overwrite current database with a backup"
}

main_menu(){
    while true; do 
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
                ;;
        esac
    done
}

main_menu