Set-Location -Path 'C:\Users\Ianfr\OneDrive\Documents\GitHub\Advent-Of-Code-2023'
$fileInput = Get-Content -path '.\day2_input.txt'


function ProcessLine ($line) {
    $myhash = @{
    'red' = 0
    'blue' = 0
    'green' = 0
    } 

    $data = ($line | Select-String '\d+ (red|blue|green)' -AllMatches | ForEach-Object {$PSItem.Matches}).Value
    foreach ($keyvalue in $data) {
        $num = [int](($keyvalue -split ' ')[0])
        $color = ($keyvalue -split ' ')[1]
        if ($myhash[$color] -eq 0) {
            $myhash[$color] = $num
        } else {
            $myhash[$color] = [system.math]::max($myhash[$color],$num)
        }
    }
    write-host $myhash
    $prod = 1
    $myhash.Values | ForEach-Object {
        $prod = $prod * $_
    }
    return $prod
}

#ProcessLine $fileInput


$sum = 0
foreach ($line in $fileInput){
    $sum = $sum + (ProcessLine($line))
} 
$sum
