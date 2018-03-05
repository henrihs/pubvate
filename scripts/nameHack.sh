#!/bin/bash

# Usage: _replace_filenames rootPath old1 separator old2 newString
_replace_filenames()
{
    old1=$2
    separator=$3
    old2=$4
    new=$5
    echo "Replacing $old1$separator$old2 -> $new in file/folder names"
    find $1 -depth -not -path '*/\.*' -name "*$old1$separator$old2*" -execdir bash -c "rename 's/$old1$separator$old2/$new/' *" -- {} +
}

# Usage: _replace_filenames rootPath old1 separator old2 newString
_replace_filecontent()
{
    old1=$2
    separator=$3
    old2=$4
    new=$5
    echo "Replacing $old1$separator$old2 -> $new in file content"
    find $1 -not -path '*/\.*' -type f -exec sed -i "s/$old1$separator$old2/$new/g" {} +
}

# Usage: _lowercase "STRING"
_lowercase()
{ 
    echo "$1" | tr '[:upper:]' '[:lower:]'; 
}

# Usage: _replace_combinations rootPath "Pattern.ToFind" "Pattern.ToReplace"
_replace_combinations()
{
    rootPath=$1;
    oldPattern=(${2//./ });
    newPattern=(${3//./ });

    delimiters="\.;\-; " # separated by ';'
    IFS=';' read -ra ADDR <<< "$delimiters"
    for i in "${ADDR[@]}"; do
        _replace_filenames $rootPath ${oldPattern[0]} "$i" ${oldPattern[1]} "${newPattern[0]}$i${newPattern[1]}";
        _replace_filecontent $rootPath ${oldPattern[0]} "$i" ${oldPattern[1]} "${newPattern[0]}$i${newPattern[1]}";
    done
}

if [ $# -eq 3 ]
  then
    _replace_combinations $1 $2 $3
    _replace_combinations $1 `_lowercase $2` `_lowercase $3`
  else
    echo "Usage: nameHack.sh <RootPath> <Pattern.ToFind> <Pattern.ToReplace>"
    echo "  Replaces in both folder names, file names as well as file content"
    echo "  Delimiter '.' is wildcard for .-<space>"
    echo "  Lowercase version of patterns is automatically run."
fi