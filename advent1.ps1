[System.Collections.ArrayList]$output_array = @()
#$string = "two1nine"
#$string_array = $string.ToCharArray()
$strings = Get-Content -Path ".\advent1_input.txt"
$number_mapping = @{

    "one"   = 1
    "two"   = 2
    "three" = 3
    "four"  = 4
    "five"  = 5
    "six"   = 6
    "seven" = 7
    "eight" = 8
    "nine"  = 9
}
function Left_To_Right 
{
    #iterate for how long the given string is
    #grow a new string by 1 char at at time
    #perform 2 checks. Either if the growing string is an int or contains a word that spells a number
    $test_array = $output_array

    for ($i = 0; $i -lt $string_array.Count; $i++) 
    {
        #Take the index of the array and increment it on each pass. then grow the new string
        $joined_string += $string_array[$i]
    
        #check 1: find if the joined string contains an integer
        #Regex to find number in string as it grows
        if ([regex]::Matches($joined_string, '\d+').Value) 
        {
            $output_array += [regex]::Matches($joined_string, '\d+').Value
            $joined_string = '' #clear out the grown string
            #break?
        }
        
        #check 2: check if the growing string turns into a word that spells a number
        elseif ($number_mapping.ContainsKey($joined_string)) {
            $output_array.Add($number_mapping[$joined_string]) | Out-Null
            $joined_string = '' # clear out the grown string
            #exit
        }

        elseif ($test_array.Count -lt $output_array.Count) {
            break
        }
    }
}

#outer loop going through the whole file
foreach ($string in $strings)
{
    #Left to right check
    Left_To_Right

    #Right to left check

}

$output_array