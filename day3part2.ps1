<#
The missing part wasn't the only issue - one of the gears in the engine is wrong.
A gear is any * symbol that is adjacent to exactly two part numbers. 
Its gear ratio is the result of multiplying those two numbers together.

This time, you need to find the gear ratio of every gear and add them all up
so that the engineer can figure out which gear needs to be replaced.

Consider the same engine schematic again:

467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
In this schematic, there are two gears. The first is in the top left; it has part numbers 467 and 35, so its gear ratio is 16345. 
The second gear is in the lower right; its gear ratio is 451490. 
(The * adjacent to 617 is not a gear because it is only adjacent to one part number.) Adding up all of the gear ratios produces 467835.

What is the sum of all of the gear ratios in your engine schematic?
#>

$filePath = 'C:\Users\Ianfr\OneDrive\Documents\GitHub\Advent-Of-Code-2023\day3_input.txt'
$testFilePath = 'C:\Users\Ianfr\OneDrive\Documents\GitHub\Advent-Of-Code-2023\day3_test_input.txt'
$fileInput = get-content $testFilePath

$specialCharacterRegexPattern = '\*'
$numberRegexPattern = '\d+'

$numbersTable = @{}
$specialCharactersTable = @{}

$sumOfPartNumbers = 0
$lineNumber = 0

# key = $linenumber, value = $numValue
$gearRatioPairs = [ordered]@{}


function FindMatches ($numbersTable, $specialCharactersTable, $lineNumString) 
{
    Write-Verbose "Match on $($lineNumString)"

    $numberMatches = $null
    $numberMatches = $fileInput[$i] | Select-String -Pattern $numberRegexPattern -AllMatches

    if ($null -eq $numberMatches)
    {
        $numbersTable.Add($lineNumString, @())
    } 
    else {
        $numbersTable.Add($lineNumString, $numberMatches)
    }

    $specialMatches = $null
    $specialMatches = $fileInput[$i] | Select-String -Pattern $specialCharacterRegexPattern -AllMatches

    if ($null -eq $specialMatches) 
    {
        $specialCharactersTable.Add($lineNumString, @())
    } 
    else {
        $specialCharactersTable.Add($lineNumString, $specialMatches)
    }
}

#Gather all of the matches first
for ($i = 0; $i -lt $fileInput.Count; $i++) 
{
    $lineNumberString = ("line $($i)")

    findMatches $numbersTable $specialCharactersTable $lineNumberString
}


#Then processes said matches
for ($i = 0; $i -lt $fileInput.Count; $i++) 
{
    $lineNumberString = ("line $($i)")

    $numberMatchInfo = $numbersTable[$lineNumberString]

    foreach ($item in $numberMatchInfo.matches) 
    {
        $isFirstPartNumber = $false

        # value, index, length
        # want to find the start and end SEARCH indices for specials
        $searchStart = $item.Index
        if ($searchStart -gt 0) # if the index of the number isn't at the start of the line
        {
            $searchStart = $searchStart - 1
        }

        $searchEnd = $item.Index + $item.Length - 1
        if ($searchEnd -lt ($fileInput[0].Length - 1)) # if the number does not reach the end of the line
        {
            $searchEnd = $searchEnd + 1
        }

        # Holds up to 3 lines at any given time 
        $matchInfosToSearch = @()
        if ($i -gt 0) # checks if you're on the first line
        {
            $matchInfosToSearch += $specialCharactersTable[("line $($i - 1)")]
        }

        # current line
        $matchInfosToSearch += $specialCharactersTable[$lineNumberString] 

        if ($i -lt ($fileInput.Length - 1)) # checks if you're on the last line
        {
            $matchInfosToSearch += $specialCharactersTable[("line $($i + 1)")]
        }

        # for each line in lines to search
        # check each of its match objects
        # and see if any of them have an index that is ge searchStart
        # or le $searchEnd
        foreach ($matchInfo in $matchInfosToSearch) 
        {
            foreach ($specialCharMatch in $matchInfo.matches) 
            {
                if (($specialCharMatch.Index -ge $searchStart) -and ($specialCharMatch.index -le $searchEnd)) 
                {
                    # the number is a part number
                    $isFirstPartNumber = $true
                }
            }
        }

        if ($isFirstPartNumber) 
        {
            $numValue = [int]($item.value)
            Write-Verbose "Found part number $($numValue) on line $($i)"

            $gearRatioPairs.Add($lineNumber,$numValue)
            # Before adding to gearRatioPairs check if $item is near the last entry
            # if there isn't an entry add it
            # if there is an entry but the new $item is farther away reset the old entry

            #$gearRatioPairs += $numValue
        }

        $j = 0
        if ($gearRatioPairs.Count -eq 2)
        {

            if (($gearRatioPairs[0] - $gearRatioPairs[1]) -le 3)
            {
                $sumOfPartNumbers += $gearRatioPairs[0] * $gearRatioPairs[1]
                Write-Verbose "Current total is $($sumOfPartNumbers)"
            }
            else {
                $gearRatioPairs.RemoveAt(0)
            }

            #$gearRatioPairs = @{}
        }

    }
    
    $lineNumber++
}

Write-Host $sumOfPartNumbers
