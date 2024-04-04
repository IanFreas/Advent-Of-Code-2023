<#
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

$filepath = 'C:\Users\Ianfr\OneDrive\Documents\GitHub\Advent-Of-Code-2023\day3_input.txt'
$fileInput = get-content $filepath


$regexPattern = '[^\d\.]'
$numRegex = '\d+'

$numbersTable = @{}
$specialTable = @{}

$lineNumber = 0

function findNumberMatches ($numbersTable, $lineNumString) {
    Write-Verbose "Number Match $($lineNumString)"
    $numberMatches = $null
    $numberMatches = $fileInput[$i] | Select-String -Pattern $numRegex -AllMatches
    #if ($numberMatches.count -ge 1)
    #{
    if ($null -eq $numberMatches) {
        $numbersTable.Add($lineNumString, @())
    } else {
        $numbersTable.Add($lineNumString, $numberMatches)
    }
    #}
    #elseif ($numberMatches.count -eq 0) 
    #{
    #    $numbersTable.Add($lineNumString, 'no matches')
    #}
}

function findSpecialMatches ($specialTable, $lineNumString) {
    Write-Verbose "Special Match $($lineNumString)"
    $specialMatches = $null
    $specialMatches = $fileInput[$i] | Select-String -Pattern $regexPattern -AllMatches
    #if ($specialMatches.count -ge 1)
    #{
    if ($null -eq $specialMatches) {
        $specialTable.Add($lineNumString, @())
    } else {
        $specialTable.Add($lineNumString, $specialMatches)
    }
    #}
    #elseif ($specialMatches.count -eq 0) 
    #{
    #    $specialTable.Add($lineNumString, 'no matches')
    #}
}

function findNumberAndLength ($numTable, $specTable, $lineNumString) {
    if ($numTable[$lineNumString] -ne 'no matches') 
    {
        #Find the location of the match with how long it is
        foreach ($match in ($numTable[$lineNumString].matches))
        {
            $foundNumber = $match.value
            $foundNumberIndex = $match.index
            $foundNumberLocation = @()
            for ($i = $foundNumberIndex; $i -lt $foundNumber.Length; $i++) {
                $foundNumberLocation += $i 
            }
            return $foundNumberLocation


        }
    }
}

function checkIfNumIsAdjacent () {
    # do check if the first line or the last line is empty

    
}

#Gather all of the matches first
for ($i = 0; $i -lt $fileInput.Count; $i++) {

    $lineNumberString = ("line $($lineNumber)")

    findNumberMatches $numbersTable $lineNumberString

    findSpecialMatches $specialTable $lineNumberString
    
    $lineNumber++
}

#reset line number
$lineNumber = 0
$sumOfPartNumbers = 0
#Then processes said matches
for ($i = 0; $i -lt $fileInput.Count; $i++) {

    $lineNumberString = ("line $($lineNumber)")

    #$numberMatches = @()
    $numberMatchInfo = $numbersTable[$lineNumberString]
    foreach ($item in $numberMatchInfo.matches) {
        $isPartNumber = $false
        # value, index, length
        # want to find the start and end SEARCH indices for specials
        $searchStart = $item.Index
        if ($searchStart -gt 0) {
            $searchStart = $searchStart - 1
        }
        $searchEnd = $item.Index + $item.Length - 1
        if ($searchEnd -lt ($fileInput[0].Length - 1)) {
            $searchEnd = $searchEnd + 1
        }

        $matchInfosToSearch = @()
        if ($i -gt 0) {
            $matchInfosToSearch += $specialTable[("line $($i - 1)")]
        }
        $matchInfosToSearch += $specialTable[$lineNumberString]
        if ($i -lt ($fileInput.Length - 1)) {
            $matchInfosToSearch += $specialTable[("line $($i + 1)")]
        }

        # for each line in lines to search
        # check each of its match objects
        # and see if any of them have an index that is gte searchStart
        # or lte $searchEnd
        foreach ($matchInfo in $matchInfosToSearch) {
            foreach ($specialCharMatch in $matchInfo.matches) {
                if (($specialCharMatch.Index -ge $searchStart) -and ($specialCharMatch.index -le $searchEnd)) {
                    # the number is a part number
                    $isPartNumber = $true
                }
            }
        }

        if ($isPartNumber) {
            $numValue = [int]($item.value)
            Write-Verbose "Found part number $($numValue) on line $($i)"
            $sumOfPartNumbers += $numValue
        }

    }

    #$foundIndexWithLength = (findNumberAndLength $numbersTable $specialTable $lineNumberString)

    #If at the first line only check the current and next

    #If at the last line only check the current and last
    
    $lineNumber++
    
}

Write-Host $sumOfPartNumbers

#working example 
#(($specialTable["line $($lineNumber + 1)"].matches.index) - 1) -in $foundIndexWithLength
<#

put all the number matches in a hash as 'line number' = matches

make a function to get the length of the value and then offset that from the index of where it is as an index of each int
 
compare each index of the total value of the match to the previous, current, and next line

during the check see if the first line and last line are true for the start and end of the file

#>