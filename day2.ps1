# TODO
# ok use something like [0-9]+ red with -match to pattern match a variable i create
# then do a value compare against the limit
# once done check if the game is possible then add that game number to a new array
# get the sum of that array for the answer

Set-Location "~\OneDrive\Documents\GitHub\Advent-Of-Code-2023"
$intputFile = (get-location).path + "\day2_input.txt"
$fileContents = Get-Content $intputFile

$total = 0

$redLimit = 12
$greenLimit = 13
$blueLimit = 14

# Main for loop
for ($i = 0; $i -lt $fileContents.Count; $i++)
{
    # split the game with number string out first     
    $gameInputSplit = $fileContents[$i] -split ':'
    $gameNumber = $gameInputSplit[0]
    $gameContents = $gameInputSplit[1].TrimStart()

    $gameNumber
    $number = [int]([regex]::Matches($gameNumber, '\d+').value)
    $array = [regex]::matches($gameContents, '\d+').value
    $sortedArray = $array | ForEach-Object {[int]$_} | Sort-Object -Descending
     

    if ($sortedArray[0] -le 12) {
        $total += $number
        write-host "$gameNumber is possible"
    }
    else {
        :innerLoop for ($j = 0; $j -lt $sortedArray.Count; $j++)
        {
            <# Action that will repeat until the condition is met #>
            if (($sortedArray[$j]) -le $redLimit) 
            {
                $total += $number
                write-host "$gameNumber is possible"
                break innerLoop
            }
            elseif (($sortedArray[$j]) -le $blueLimit) 
            {
                $total += $number
                write-host "$gameNumber is possible"
                break innerLoop
            }
            elseif (($sortedArray[$j]) -le $greenLimit) 
            {
                $total += $number
                write-host "$gameNumber is possible"
                break innerLoop
            }
            else {
                break innerLoop
            }  
        }
    }
    $total
}
