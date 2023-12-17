#todo: figure out how to not add 0's
[System.Collections.ArrayList]$output_array = @()
$string = "two1nine"
$string_array = $string.ToCharArray()

#iterate for how long the given string is
#grow a new string by 1 char at at time
for ($i = 0; $i -lt $string_array.Count; $i++) 
{
    #Take the index of the array and increment it on each pass. then grow the new string
    $joined_string += $string_array[$i]
    
    #Regex to find number in string as it grows
    if ([regex]::Matches($joined_string, '\d+').Value) 
    {
        $output_array += [regex]::Matches($joined_string, '\d+').Value
        $joined_string = '' #clear out the grown string
    }
    
    #Check if there's the word in the growing string
    switch -Exact ($joined_string) 
    {
        "one" 
        {
            $output_array.Add(1) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "two" 
        {
            $output_array.Add(2) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "three" 
        {
            $output_array.Add(3) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "four" 
        {
            $output_array.Add(4) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "five" 
        {
            $output_array.Add(5) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "six" 
        {
            $output_array.Add(6) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "seven" 
        {
            $output_array.Add(7) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "eight" 
        {
            $output_array.Add(8) | Out-Null
            $joined_string = '' #clear out the grown string
        }
        "nine" 
        {
            $output_array.Add(9) | Out-Null
            $joined_string = '' #clear out the grown string
        }
    }
}
$output_array