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

$numberMatches = @()
$specialMatches = @()

foreach ($line in $fileInput)
{
    $numberMatches += $line | Select-String -Pattern $numRegex -AllMatches
    $specialMatches += $line | Select-String -Pattern $specialCharsTestInput -AllMatches
}


# check in 12 spots around the numbers to see if a special character is there. If yes then add it to the total. otherwise ignore




<#
$foundMatches = @{}

function processLine ($line, $foundMatches, $lineNumber) {
    $foundCharacters = $line | select-string -Pattern $specialCharsTestInput -AllMatches
    if ($true -eq $foundCharacters) {

        $matchIndex = $foundCharacters.Matches.Index
        
        #get all adjacent lines
        $previousLine = $fileinput[($lineNumber - 1) ]
        $currentLine = $fileinput[$lineNumber]
        $nextLine = $fileinput[($lineNumber + 1)]

        #pull out matches
        $previousLineMatches = $previousLine | Select-String -Pattern '\d+' -AllMatches
        $currentLineMatches = $currentLine | Select-String -Pattern '\d+' -AllMatches
        $nextLineMatches = $nextLine | Select-String -Pattern '\d+' -AllMatches

        $previousMatchIndex = $previousLineMatches.Matches.index
        $currentMatchIndex = $currentLineMatches.Matches.index
        $nextMatchIndex = $nextLineMatches.Matches.index

        if ($previousLineMatches) 
        {
            foreach ($match in ($previousMatchIndex))
            {
                switch ($match) { # need to add the count to the index  
                    {$match -eq ($matchIndex - 1) } {'found -1 match'}
                    {$match -eq ($matchIndex) } {'found equals match'}
                    {$match -eq ($matchIndex + 1) } {'found +1 match'}
                    Default {}
                }
            }
        }


    }
    #reset
    $foundCharacters = $null
}

for ($i = 0; $i -lt $fileInput.Count; $i++) {
    processLine $fileInput[$i] $foundMatches $i
}

<#
foreach ($line in $fileInput){
    processLine $line
}
#>

#>