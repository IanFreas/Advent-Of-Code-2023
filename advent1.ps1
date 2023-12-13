$input_file_path = "$env:USERPROFILE\onedrive\documents\programming\advent-of-code-2023\advent1_input.txt"
$input_file_contents = get-content $input_file_path
$split_array = @()

<#
for ($i = 0; $i -lt $input_file_contents.Count; $i++) {
    $input_file_contents[$i] -split ""
}
#>

<#
foreach ($line in $input_file_contents){
    $line -split ""
    #$split_array += $line -split "" 
}
#>