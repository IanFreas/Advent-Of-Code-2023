# TODO
# ok use something like [0-9]+ red with -match to pattern match a variable i create
# then do a value compare against the limit
# once done check if the game is possible then add that game number to a new array
# get the sum of that array for the answer


Set-Location "~\OneDrive\Documents\GitHub\Advent-Of-Code-2023"
$intputFile = (get-location).path + "\day2_input.txt"
$fileContents = Get-Content $intputFile
$myHash = @{}

$redLimit = 12
$blueLimit = 13
$greenLimit = 14

$limits = 12,13,14

# Main for loop
for ($i = 0; $i -lt $fileContents.Count; $i++)
{
    # split the game with number string out first     
    $gameInputSplit = $fileContents[$i] -split ':'
    $gameNumber = $gameInputSplit[0]

    # split the cubes from the line itself
    $gameOutputs = $gameInputSplit[1]
    
    # Some regex to grab the number of the cube rolls
    $cubeRolls = [regex]::Matches($gameOutputs, '\b\d+\b') | ForEach-Object {$_.Value}

    
    $cubeRolls | ForEach-Object {$a = [int]$_; $a.GetType()}
    #cast everything to an int
    #($array.split(",") | % {iex $_}) -ge 12
    foreach ($limit in $limits)
    {
        #$cubeRolls -ge $limit
    }
    #$myhash.add($gameNumber,$cubeRolls)
}


#make a red limit loop - break if hit
#make a blue limit loop - break if hit
#make a blue limit loop - break if hit


$myHash
