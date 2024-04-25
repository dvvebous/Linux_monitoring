#!/usr/bin/env bats

source ./check.sh

#Недостаточное количество аргументов
@test "Check with insufficient arguments" {
    run Check
    [ "$status" -eq 0 ]
    [ "$output" = "Not enough or too many arguments" ]
}

@test "Check with extension longer than 3 characters " {
    run Check ABC az.azcr 10Mb
    [ "$status" -eq 0 ]
    [ "$output" = "the list must consist of letters of the English alphabet used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). Your input: az.azcr" ]
}

@test "Check with filename longer than 7 characters" {
    run Check az abccccccc.txt 10Mb
    [ "$status" -eq 0 ]
    [ "$output" = "the list must consist of letters of the English alphabet used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). Your input: abccccccc.txt" ]
}

@test "Check with invalid file size format" {
    run Check az az.az 1000Mb
    [ "$status" -eq 0 ]
    [ "$output" = "The file size must be less than 100 Mb. Your input: 1000Mb" ]
}

@test "Check with invalid file size format(size = 0)" {
    run Check az az.az 0Mb
    [ "$status" -eq 0 ]
    [ "$output" = "The file size must be less than 100 Mb. Your input: 0Mb" ]
}

@test "Check with file size format(size = 100)" {
    run Check az az.az 100Mb
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
}
@test "Check with valid arguments-0" {
    run Check ABC az.az 10Mb
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
}

@test "Check with valid arguments-1" {
    run Check az az.az 10Mb
    [ "$status" -eq 0 ]
    [ "$output" = "1" ]
}
