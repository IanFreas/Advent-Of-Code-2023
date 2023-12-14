<#
$input_file_path = "$env:USERPROFILE\onedrive\documents\programming\advent-of-code-2023\advent1_input.txt"
$input_file_contents = get-content $input_file_path
$line_total = @()

foreach ($string in $input_file_contents) {
    # pattern match to find pull out all numbers from the string
    $pre_numbers = [regex]::Matches($string, '\d+').Value -join ''
    
    # pattern match first for the string then convert THEN do the rest
    
    switch -Wildcard ($input_file_contents) {
        "*one*" {$_ + "found the number 1"}
        "*two*" {$_ + "found the number 2"}
        "*three*" {$_ + "found the number 3"}
        "*four*" {$_ + "found the number 4"}
        "*five*" {$_ + "found the number 5"}
        "*six*" {$_ + "found the number 6"}
        "*seven*" {$_ + "found the number 7"}
        "*eight*" {$_ + "found the number 8"}
        "*nine*" {$_ + "found the number 9"}
        #Default {}
    }
        
    # if there are more than 2 numbers in the string
    if ($pre_numbers.Length -gt 2) {
        $new_numbers = $pre_numbers[0] -join ''
        $new_numbers += $pre_numbers[-1] -join ''
        $line_total += [int]$new_numbers
    }
    # check if theres just 1 number
    elseif ($pre_numbers.Length -eq 1) {
        $new_numbers = $pre_numbers[0] -join ''
        $new_numbers += $pre_numbers[0] -join ''
        $line_total += [int]$new_numbers
    }
    else {
        $line_total += [int]$pre_numbers
    }
}

$line_total
Write-Host "total value:" ($line_total | measure-object -sum).sum




switch -wildcard ($input_file_contents) {
    "*1*" {$_}
}
#>

#todo: figure out how to not add 0's
$string = "two1nine"
$string_array = $string -split ''

#iterate for how long the given string is
for ($i = 0; $i -lt $string_array.Count; $i++) {
    $joined_string += $string_array[$i] -join ''
    #$joined_string
    [System.Collections.ArrayList]$output_array = @()
    
    # regex to find number
    #$output_array += [regex]::Matches($joined_string, '\d+').Value
    switch -regex ($joined_string) {
        '\d+' {if ($_ -ne '0'){
            $output_array.Add([int]$_)
            }
        $joined_string = ""
        }
        #Default {}
    }
    

    switch -Wildcard ($joined_string) {
        "*one*" {$_ + "found the number 1"}
        "*two*" {$output_array.Add(2)
            $joined_string = ""
        }
        "*three*" {$_ + "found the number 3"}
        "*four*" {$_ + "found the number 4"}
        "*five*" {$_ + "found the number 5"}
        "*six*" {$_ + "found the number 6"}
        "*seven*" {$_ + "found the number 7"}
        "*eight*" {$_ + "found the number 8"}
        "*nine*" {$output_array.Add(9)
            $joined_string = ""
        }
        #Default {}
    }
    $output_array
}
gv joined_string | rv