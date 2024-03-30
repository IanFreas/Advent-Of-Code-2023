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

$fileInput = get-content 'C:\Users\Ianfr\OneDrive\Documents\GitHub\Advent-Of-Code-2023\day3_input.txt'

$specialChars = ('\*','\#','\+','\$')



