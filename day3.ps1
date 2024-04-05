<#
Part 1
The engine schematic (your puzzle input) consists of a visual representation of the engine.
There are lots of numbers and symbols you don't really understand, but apparently any number adjacent to a symbol, 
even diagonally, is a "part number" and should be included in your sum. 
(Periods (.) do not count as a symbol.)
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
In this schematic, 
two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58 (middle right).
Every other number is adjacent to a symbol and so is a part number; their sum is 4361.
#>

$filePath = 'C:\Users\Ianfr\OneDrive\Documents\GitHub\Advent-Of-Code-2023\day3_input.txt'
$fileInput = get-content $filePath

$specialCharacterRegexPattern = '[^\d\.]'
$numberRegexPattern = '\d+'

$numbersTable = @{}
$specialCharactersTable = @{}

$sumOfPartNumbers = 0


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
        $isPartNumber = $false

        # value, index, length
        # want to find the start and end SEARCH indices for specials
        $searchStart = $item.Index
        if ($searchStart -gt 0) 
        {
            $searchStart = $searchStart - 1
        }

        $searchEnd = $item.Index + $item.Length - 1
        if ($searchEnd -lt ($fileInput[0].Length - 1)) 
        {
            $searchEnd = $searchEnd + 1
        }

        $matchInfosToSearch = @()
        if ($i -gt 0) 
        {
            $matchInfosToSearch += $specialCharactersTable[("line $($i - 1)")]
        }

        $matchInfosToSearch += $specialCharactersTable[$lineNumberString]
        if ($i -lt ($fileInput.Length - 1)) 
        {
            $matchInfosToSearch += $specialCharactersTable[("line $($i + 1)")]
        }

        # for each line in lines to search
        # check each of its match objects
        # and see if any of them have an index that is gte searchStart
        # or lte $searchEnd
        foreach ($matchInfo in $matchInfosToSearch) 
        {
            foreach ($specialCharMatch in $matchInfo.matches) 
            {
                if (($specialCharMatch.Index -ge $searchStart) -and ($specialCharMatch.index -le $searchEnd)) 
                {
                    # the number is a part number
                    $isPartNumber = $true
                }
            }
        }

        if ($isPartNumber) 
        {
            $numValue = [int]($item.value)
            Write-Verbose "Found part number $($numValue) on line $($i)"
            $sumOfPartNumbers += $numValue
        }

    }
    
}

Write-Host $sumOfPartNumbers
