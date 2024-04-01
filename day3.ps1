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
#>

$filepath = 'C:\Users\Ianfr\OneDrive\Documents\GitHub\Advent-Of-Code-2023\day3_input.txt'
$fileInput = get-content $filepath

$specialCharsTestInput = '\$|\*|\#|\+'
$specialChars = '\-|\@|\*|\/|\&|\#|\%|\+|\=|\$'
$numRegex = '\d+'

#$numberMatches = @()
#$specialMatches = @()
$numbersTable = @{}
$specialTable = @{}

$lineNumber = 0

function findNumberMatches ($numbersTable, $lineNumString) {
    Write-Verbose "Number Match $($lineNumString)"
    $numberMatches = $null
    $numberMatches = $fileInput[$i] | Select-String -Pattern $numRegex -AllMatches
    if ($numberMatches.count -ge 1)
    {
        $numbersTable.Add($lineNumString, $numberMatches)
    }
    elseif ($numberMatches.count -eq 0) 
    {
        $numbersTable.Add($lineNumString, 'no matches')
    }
}

function findSpecialMatches ($specialTable, $lineNumString) {
    Write-Verbose "Special Match $($lineNumString)"
    $specialMatches = $null
    $specialMatches = $fileInput[$i] | Select-String -Pattern $specialCharsTestInput -AllMatches
    if ($specialMatches.count -ge 1)
    {
        $specialTable.Add($lineNumString, $specialMatches)
    }
    elseif ($specialMatches.count -eq 0) 
    {
        $specialTable.Add($lineNumString, 'no matches')
    }
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
    
}

#Gather all of the matches first
for ($i = 0; $i -lt $fileInput.Count; $i++) {

    $lineNumberString = ("line $($lineNumber)")

    findNumberMatches $numbersTable $lineNumberString

    findSpecialMatches $specialTable $lineNumberString
    
    $lineNumber++
}

$lineNumber = 0

#Then processes said matches
for ($i = 0; $i -lt $fileInput.Count; $i++) {

    $lineNumberString = ("line $($lineNumber)")

    $foundIndexWithLength = (findNumberAndLength $numbersTable $specialTable $lineNumberString)

    #If at the first line only check the current and next

    #If at the last line only check the current and last
    
    $lineNumber++
    
}

#working example 
#(($specialTable["line $($lineNumber + 1)"].matches.index) - 1) -in $foundIndexWithLength
<#

put all the number matches in a hash as 'line number' = matches

make a function to get the length of the value and then offset that from the index of where it is as an index of each int
 
compare each index of the total value of the match to the previous, current, and next line

during the check see if the first line and last line are true for the start and end of the file

#>