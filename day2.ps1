$intputFile = (get-location).path + "\day2_input.txt"
$fileContents = Get-Content $intputFile
#$fileContents[0]
$myHash = @{}

$cubeLimits = @(
    "12 red",
    "13 green",
    "14 blue"
)

for ($i = 0; $i -lt $fileContents.Count; $i++){
    $splitLines = $fileContents[$i] -split ':'
    $gameNumber = $splitLines[0]
    $gameContents = $splitLines[1]
    #$gameNumber
    #$gameContents
    $myhash.add($gameNumber,$gameContents)
}

$myHash
