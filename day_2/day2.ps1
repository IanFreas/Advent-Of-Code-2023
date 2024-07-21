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

# Main for loop iterating through the input file
for ($i = 0; $i -lt $fileContents.Count; $i++)
{
    # split the game with number string out first     
    $gameInputSplit = $fileContents[$i] -split ':'
    $gameNumber = $gameInputSplit[0]
    $gameContents = $gameInputSplit[1].TrimStart()

    #$gameNumber
    $number = [int]([regex]::Matches($gameNumber, '\d+').value)
    $array = [regex]::matches($gameContents, '\d+').value

    #breakout each color into an array of each
    $reds = [regex]::matches($gameContents, '\d+\sred+').value
    $redNumbers = @()
    $reds | % {$redNumbers += ([int]([regex]::Matches($_, '\d+').value))}

    $greens = [regex]::matches($gameContents, '\d+\sgreen+').value
    $greenNumbers = @()
    $greens | % {$greenNumbers += ([int]([regex]::Matches($_, '\d+').value))}
    
    $blues = [regex]::matches($gameContents, '\d+\sblue+').value
    $blueNumbers = @()
    $blues | % {$blueNumbers += ([int]([regex]::Matches($_, '\d+').value))}

    $sortedArray = $array | ForEach-Object {[int]$_} | Sort-Object -Descending
     
    $gameContentsAgain = (($gameContents -split ',').Trim() -split ';').trim()

    if ($sortedArray[0] -le 12)
    {
        $total += $number
        "$gameNumber is possible"
    }

    $gameContentsAgain | ForEach-Object {
        if ($_ -match 'red')
        {
            $red = [int]([regex]::matches($_, '\d+').value)
            if ($red -gt $redLimit)
            {
                continue
            }
        }
        elseif ($_ -match 'green')
        {
            $green = [int]([regex]::matches($_, '\d+').value)
            if ($green -gt $greenLimit)
            {
                continue
            }            
        }
        elseif ($_ -match 'blue')
        {
            $blue = [int]([regex]::matches($_, '\d+').value)
            if ($blue -gt $blueLimit)
            {
                continue
            }
#            elseif ($blue -) {
 #               $total += $number
  #              "$gameNumber is possible"
   #         }
        }
        else {
            $total += $number
            "$gameNumber is possible"
        }
        
    }


<#


    else {
        :innerLoop for ($j = 0; $j -lt $sortedArray.Count; $j++)
        {
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
    #>
    $total
    
}
