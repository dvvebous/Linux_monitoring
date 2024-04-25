#!/usr/bin/env bats

source ./check.sh

#Недостаточное количество аргументов
@test "Check with insufficient arguments" {
    run Check
    [ "$status" -eq 0 ]
    [ "$output" = "Not enough or too many arguments" ]
}

# Тест для случая, когда путь не существует
@test "Check with non-existing path" {
    run Check /nonexistentpath 5 ABC 10 filename.txt 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "Not correct path: /nonexistentpath" ]
}

@test "Check with non-numeric subfolders count" {
    run Check ./ abc ABC 10 filename.txt 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "The number of subfolders must be a number. Your input: abc" ]
}

@test "Check with subfolders count exceeding 7 characters" {
    run Check ./ 12345678 ABCDEFGH 10 az.az 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "The parameter must consist of a list of letters of the English alphabet and no more than 7 characters. Your input: ABCDEFGH" ]
}

@test "Check with non-numeric files count" {
    run Check ./ 5 az abc az.az 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "The number of files in each created folder must be a number. Your input: abc" ]
}

@test "Check with extension longer than 3 characters " {
    run Check ./ 5 az 10 abc.txt1 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "the list must consist of letters of the English alphabet used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). Your input: abc.txt1" ]
}

@test "Check with filename longer than 7 characters" {
    run Check ./ 5 az 10 abccccccc.txt 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "the list must consist of letters of the English alphabet used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). Your input: abccccccc.txt" ]
}

@test "Check with invalid file size format" {
    run Check ./ 5 az 10 az.az 1000kb
    [ "$status" -eq 0 ]
    [ "$output" = "File size (in kilobytes, but not more than 100). Your input: 1000kb" ]
}

@test "Check with invalid file size format(size = 0)" {
    run Check ./ 5 az 10 az.az 0kb
    [ "$status" -eq 0 ]
    [ "$output" = "File size (in kilobytes, but not more than 100). Your input: 0kb" ]
}

@test "Check with invalid file size format(size = 100)" {
    run Check ./ 5 az 10 az.az 100kb
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
}
@test "Check with valid arguments-0" {
    run Check /. 5 ABC 10 az.az 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
}

@test "Check with valid arguments-1" {
    run Check /. 5 az 10 az.az 10kb
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
}
