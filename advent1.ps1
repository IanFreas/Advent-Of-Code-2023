[System.Collections.ArrayList]$outputArray = @()
#$string = "two1nine"
#$stringBrokenIntoArray = $string.ToCharArray()
$strings = Get-Content -Path ".\advent1_input.txt"
$numberMatches = @{

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
$expectedOutput = @(
    2,
    8,
    1,
    2,
    4,
    1,
    7
)

#outer loop going through the whole file
foreach ($string in $strings)
{
    #Left to right check
    #iterate for how long the given string is
    #grow a new string by 1 char at at time
    #perform 2 checks. Either if the growing string is an int or contains a word that spells a number
    $originalArrayLength = $outputArray
    $stringBrokenIntoArray = $string.ToCharArray()
    
    for ($i = 0; $i -lt $stringBrokenIntoArray.Count; $i++) 
    {
        #Take the index of the array and increment it on each pass. then grow the new string
        $rebuiltString += $stringBrokenIntoArray[$i]
    

        
        #check 1: find if the joined string contains an integer
        #Regex to find number in string as it grows
        if ([regex]::Matches($rebuiltString, '\d+').Value) 
        {
            $outputArray += [regex]::Matches($rebuiltString, '\d+').Value
            $rebuiltString = '' #clear out the grown string
            break
        }
        

        #gotta check for wildcards here
        #check 2: check if the growing string turns into a word that spells a number
        elseif ($rebuiltString) {
            foreach ($pattern in $numberMatches.Keys) {
                if ($rebuiltString -like $pattern) {
                    $outputArray.Add($numberMatches[$pattern]) | Out-Null
                    $rebuiltString = '' # clear out the grown string
                    break
                }
            }
        }
    
        elseif ($originalArrayLength.Count -lt $outputArray.Count) 
        {
            break
        }
    }

    #Right to left check

}

$outputArray


if ($testArray -eq $expectedOutput) 
{
    write-host "they match"
}

elseif ($testArray -ne $expectedOutput)
{
    write-host "dont match"
}