Set-Location "~\OneDrive\Documents\GitHub\Advent-Of-Code-2023"
$intputFile = (get-location).path + "\day2_input.txt"
$fileContents = Get-Content $intputFile

$redLimit = 12
$greenLimit = 13
$blueLimit = 14

$total = 0

$fileContents | ForEach-Object {
    $CurrentGameNumber = [int]([regex]::Matches(($_ -split ':')[0], '\d+').value)
    #"game $currentgamenumber"

    $CubeRollsPreTrimmed = ($_ -split ':')[1] -split ";"
    $CubeRolls = $CubeRollsPreTrimmed.Trim()
    :innerLoop ForEach($Roll in $CubeRolls) {
    
        #Red Check
        $RedValue = [int]([regex]::matches(([regex]::matches($Roll, '\d+\sred+').value), '\d+').value)

        #Green Check
        $GreenValue = [int]([regex]::matches(([regex]::matches($Roll, '\d+\sgreen+').value), '\d+').value)
        
        #Blue Check
        $BlueValue = [int]([regex]::matches(([regex]::matches($Roll, '\d+\sblue+').value), '\d+').value)

        if ($RedValue -gt $redLimit) {
            Write-Host "Game $CurrentGameNumber can't work cause of Red $RedValue"
            break innerLoop
        }
        elseif ($GreenValue -gt $greenLimit) {
            Write-Host "Game $CurrentGameNumber can't work cause of Green $GreenValue"
            break innerLoop
        }
        elseif ($BlueValue -gt $BlueLimit) {
            Write-Host "Game $CurrentGameNumber can't work cause of Blue $BlueValue"
            break innerLoop
        }
        else {
            Write-Host "Game $CurrentGameNumber can work"
            $total += $CurrentGameNumber
            break innerLoop
        }

    }

}

$total
<#
#reds 
$reds = [regex]::matches(($_ -split ':')[1], '\d+\sred+').value
$reds | ForEach-Object {
    $redNumberStrings = [regex]::Matches($_, '\d+').value
    $redNumberStrings
}
#>