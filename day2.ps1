# TODO
# figure out regex matching 
# ok use something like [0-9]+ red with -match to pattern match a variable i create
# then do a value compare against the limit
# once done check if the game is possible then add that game number to a new array
# get the sum of that array for the answer



$intputFile = (get-location).path + "\day2_input.txt"
$fileContents = Get-Content $intputFile
#$fileContents[0]
$myHash = @{}

$redLimit = 12
$blueLimit = 13
$greenLimit = 14

$cubeLimits = @(
    "12 red",
    "13 green",
    "14 blue"
)

for ($i = 0; $i -lt $fileContents.Count; $i++){
    # split the game with number string out first     
    $splitLines = $fileContents[$i] -split ':'
    $gameNumber = $splitLines[0]
    $gameContents = $splitLines[1]
    #$gameContents -split ';' 
    #$gameNumber
    #$gameContents
    $myhash.add($gameNumber,$gameContents)
}

$myHash
