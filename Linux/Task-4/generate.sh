#!/bin/bash

output_file="random_data.csv"

echo "id,name,place,job" > "$output_file"

generate_random_data() {
    local names=("Alice" "Bob" "Charlie" "David" "Eve" "Frank" "Grace" "Heidi" "Ivy" "Jack")
    local places=("New York" "London" "Paris" "Berlin" "Tokyo" "Sydney" "Cairo" "Rome" "Toronto" "Dubai")
    local jobs=("Engineer" "Doctor" "Artist" "Teacher" "Lawyer" "Nurse" "Architect" "Scientist" "Chef" "Designer")

    local id=$1
    local name=${names[$RANDOM % ${#names[@]}]}
    local place=${places[$RANDOM % ${#places[@]}]}
    local job=${jobs[$RANDOM % ${#jobs[@]}]}


    echo "$id,$name,$place,$job"
}

for i in {1..10}; do
    generate_random_data "$i" >> "$output_file"
done

echo "CSV file '$output_file' has been created with random data."

