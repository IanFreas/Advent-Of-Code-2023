[System.Collections.ArrayList]$outputArray = @()
$strings = Get-Content -Path ".\advent1_input.txt"
[System.Collections.ArrayList]$combinedParsedOutput = @()


#outer loop going through the whole file
:mainLoop foreach ($string in $strings)
{
    #iterate for how long the given string is
    #grow a new string by 1 char at at time
    #perform 2 checks. Either if the growing string is an int or contains a word that spells a number
    $stringBrokenIntoArray = $string.ToCharArray()
    [System.Collections.ArrayList]$combinedParsedOutput = @()

    #Left to right parse. Output to combinedParsedOutput
    :parseLeftToRight for ($i = 0; $i -lt $stringBrokenIntoArray.Count; $i++) 
    {
        #Take the index of the array and increment it on each pass. then grow the new string
        $rebuiltString += $stringBrokenIntoArray[$i]
    
        #check 1: find if the joined string contains an integer
        #Regex to find number in string as it grows
        if ([regex]::Matches($rebuiltString, '\d+').Value) 
        {
            $combinedParsedOutput += ([regex]::Matches($rebuiltString, '\d+').Value)
            clear-variable -name rebuiltString #clear out the grown string
            break parseLeftToRight
        }  

        #check 2: check if the growing string turns into a word that spells a number
        switch -Wildcard ($rebuiltString) 
        {
            "*one" 
            {
                $combinedParsedOutput.Add(1) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*two" 
            {
                $combinedParsedOutput.Add(2) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*three" 
            {
                $combinedParsedOutput.Add(3) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*four" 
            {
                $combinedParsedOutput.Add(4) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*five" 
            {
                $combinedParsedOutput.Add(5) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*six" 
            {
                $combinedParsedOutput.Add(6) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*seven" 
            {
                $combinedParsedOutput.Add(7) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*eight" 
            {
                $combinedParsedOutput.Add(8) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
            "*nine" 
            {
                $combinedParsedOutput.Add(9) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseLeftToRight
            }
        }
    }
    
    #Right to left parse. Output to combinedParsedOutput
    :parseRightToLeft for ($i = 0; $i -lt $stringBrokenIntoArray.Count; $i++) 
    {
        #Take the index of the array and increment it on each pass. then grow the new string
        #rebuilding in reverse
        $rebuiltString += $stringBrokenIntoArray[-$i - 1]
    
        #check 1: find if the joined string contains an integer
        #Regex to find number in string as it grows
        if ([regex]::Matches($rebuiltString, '\d+').Value) 
        {
            $combinedParsedOutput += ([regex]::Matches($rebuiltString, '\d+').Value)
            clear-variable -name rebuiltString #clear out the grown string
            break parseRightToLeft
        }
        
        #check 2: check if the growing string turns into a word that spells a number
        #this time the word is reversed as it's built in reverse
        switch -Wildcard ($rebuiltString) 
        {
            "*eno" 
            {
                $combinedParsedOutput.Add(1) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*owt" 
            {
                $combinedParsedOutput.Add(2) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*eerht" 
            {
                $combinedParsedOutput.Add(3) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*ruof" 
            {
                $combinedParsedOutput.Add(4) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*evif" 
            {
                $combinedParsedOutput.Add(5) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*xis" 
            {
                $combinedParsedOutput.Add(6) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*neves" 
            {
                $combinedParsedOutput.Add(7) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*thgie" 
            {
                $combinedParsedOutput.Add(8) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
            "*enin" 
            {
                $combinedParsedOutput.Add(9) | Out-Null
                clear-variable -name rebuiltString #clear out the grown string
                break parseRightToLeft
            }
        }
    }
    
    #take the combined values of each line and add it to the final array
    $outputArray += [int]($combinedParsedOutput -join "")
}

#all values from each line and the total sum
$outputArray
write-host "total sum:" ($outputArray | Measure-Object -sum).Sum