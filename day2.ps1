$intputFile = (get-location).path + "\day2_input.txt"
$fileContents = Get-Content $intputFile
$fileContents[0]

$cubeLimits = @(
    "12 red",
    "13 green",
    "14 blue"
)

foreach ($item in $fileContents) {

