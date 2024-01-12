# TODO
# ok use something like [0-9]+ red with -match to pattern match a variable i create
# then do a value compare against the limit
# once done check if the game is possible then add that game number to a new array
# get the sum of that array for the answer

$intputFile = (get-location).path + "\day2_input.txt"
$fileContents = Get-Content $intputFile
$myHash = @{}

$redLimit = 12
$blueLimit = 13
$greenLimit = 14

$limits = 12,13,14

# Main for loop
for ($i = 0; $i -lt $fileContents.Count; $i++){
    # split the game with number string out first     
    $gameInputSplit = $fileContents[$i] -split ':'
    $gameNumber = $gameInputSplit[0]

    # split the cubes from the line itself
    $gameOutputs = $gameInputSplit[1]
    
    # Some regex to grab the number of the cube rolls
    $cubeRolls = [regex]::Matches($gameOutputs, '\b\d+\b') | ForEach-Object {$_.Value}

    foreach ($limit in $limits){
	foreach ($roll in $cubeRolls){
            if ($roll -ge $limit){
                write-host "$roll and $limit"
            }
	}
    }
    #$myhash.add($gameNumber,$cubeRolls)
}

#make a red limit loop - break if hit
#make a blue limit loop - break if hit
#make a blue limit loop - break if hit


$myHash
