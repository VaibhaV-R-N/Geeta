#!/bin/sh
chapter () {
    chap=$1
    result1=$(curl https://vedabase.io/en/library/bg/$chap/ | grep "<dd>.*</dd>" | sed 's_<dd>__g' | sed 's_</dd>__g')

    result2=$(curl https://vedabase.io/en/library/bg/$chap/ | grep "TEXT.*" |sed 's_<dt><a href=".*">__g' |sed 's_:</a></dt>__g'|sed 's_TEXT __g'|sed 's_TEXTS __g')

    echo "$result1" > /tmp/geetaIndex.txt
    echo "$result2" > /tmp/geetaIndexnum.txt
    echo -e "\n \n"
    
    while read -u 3 -r file1 && read -u 4 -r file2; do
    echo -e "$file1 ) $file2 \n \n \n"
    done 3</tmp/geetaIndexnum.txt 4</tmp/geetaIndex.txt
}

verse () {
    chapp=$1
    versee=$2
    r2=$(curl https://vedabase.io/en/library/bg/$chapp/$versee/ | grep ' <div id="bb.*" class="r r-lang-en r-verse-text" >.*</div>' | sed 's_ <div id="bb.*" class="r r-lang-en r-verse-text" >__g' | sed 's_</div>__g' | sed 's_<em>__g' | sed 's_</em>__g' | sed 's_<br />_\n\t\t\t    _g' | grep '\S')
    r1=$(curl https://vedabase.io/en/library/bg/$chapp/$versee/ | grep '<div id="bb.*" class="r r-devanagari">.*</div>' | sed 's_<div id="bb.*" class="r r-devanagari">__g' | sed 's_</div>__g' | sed 's_<br/>_\n\t\t\t    _g' | grep '\S')
    r3=$(curl https://vedabase.io/en/library/bg/$chapp/$versee/ | grep '<div id="bb.*" class="r r-lang-en r-paragraph" >.*</div>' | sed 's_<div id="bb.*.*" class="r r-lang-en r-paragraph" >__g' | sed 's_</div>__g' | sed 's_<em>__g' | sed 's_</em>__g' | sed 's_<p>__g' | sed 's_</p>__g' | sed 's_<a .*>__g'| sed 's_</a>__g')


    echo -e "$r1 \n \n \n \n $r2 \n \n \n \n$r3" > /tmp/verse.txt
    echo -e "\n \n"

    while IFS= read -r line;do
    echo "$line";
    done < /tmp/verse.txt
}

geeta_menu () {
    while [ 1 ];do
        printf "\n \n \n 1)Read chapter \n 2)Read a particular verse \n 3)Exit \n \n Enter your choice : "
        read choice
        if [ $choice -eq "1" ];then
            printf "Enter chapter : "
            read ch
            chapter "$ch"

        elif [ $choice -eq "2" ];then
            printf "Enter chapter :"
            read cha
            printf "Enter verse no. : "
            read vers
            verse "$cha" "$vers"
        
        elif [ $choice -eq "3" ];then
            exit 0

        else 
            printf "Inalid choice \n \n"

        fi
    done      


}

if [ $# -eq 1 ];then 
    chapter "$1"
    geeta_menu

elif [ $# -eq 0 ];then
    chapter "1"
    geeta_menu


elif [ $# -eq 2 ];then
    verse "$1" "$2"
    geeta_menu
fi
