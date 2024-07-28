<#
--- Part Two ---
Just as you're about to report your findings to the Elf, one of you realizes that the rules have actually been printed on the back of every card this whole time.

There's no such thing as "points". Instead, scratchcards only cause you to win more scratchcards equal to the number of winning numbers you have.

Specifically, you win copies of the scratchcards below the winning card equal to the number of matches.
So, if card 10 were to have 5 matching numbers, you would win one copy each of cards 11, 12, 13, 14, and 15.

Copies of scratchcards are scored like normal scratchcards and have the same card number as the card they copied.
So, if you win a copy of card 10 and it has 5 matching numbers, it would then win a copy of the same cards that the original card 10 won: cards 11, 12, 13, 14, and 15. 
This process repeats until none of the copies cause you to win any more cards. (Cards will never make you copy a card past the end of the table.)

This time, the above example goes differently:

Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
Card 1 has four matching numbers, so you win one copy each of the next four cards: cards 2, 3, 4, and 5.
Your original card 2 has two matching numbers, so you win one copy each of cards 3 and 4.
Your copy of card 2 also wins one copy each of cards 3 and 4.
Your four instances of card 3 (one original and three copies) have two matching numbers, so you win four copies each of cards 4 and 5.
Your eight instances of card 4 (one original and seven copies) have one matching number, so you win eight copies of card 5.
Your fourteen instances of card 5 (one original and thirteen copies) have no matching numbers and win no more cards.
Your one instance of card 6 (one original) has no matching numbers and wins no more cards.
Once all of the originals and copies have been processed, you end up with 1 instance of card 1, 2 instances of card 2, 4 instances of card 3, 8 instances of card 4, 14 instances of card 5, and 1 instance of card 6. 
In total, this example pile of scratchcards causes you to ultimately have 30 scratchcards!

Process all of the original and copied scratchcards until no more scratchcards are won. Including the original set of scratchcards, how many total scratchcards do you end up with?
#>


$inputFileContent = get-content -Path "$PSScriptRoot\day4_part2_test_input"
$regexPattern = '(\w+\s+\d+:)(.*\|)(.*)'
$hash = [ordered]@{}
$total = 0
$cardArray = @()


# Process the input file
foreach ($line in $inputFileContent)
{
    # Variable config
    $winningNumbersArray = @()
    $yourNumbersArray    = @()
    
    #Pattern match and formatting
    $line -match $regexPattern | Out-Null
    
    $cardNumber = $Matches.1 -replace ':',''
    
    $winningNumbers = ($Matches.2 -replace '\|','').Trim()
    $winningNumbers -split '\s+' | ForEach-Object {$winningNumbersArray += [int]$_}
    
    $yourNumbers = ($matches.3 -replace '\s+',' ').Trim()
    $yourNumbers -split '\s+' | ForEach-Object {$yourNumbersArray += [int]$_}
    
    #All cards in a single hash table
    #$hash += @{$cardNumber = @{'Winning Numbers' = $winningNumbersArray;'Your Numbers' = $yourNumbersArray}}
    
    $cardArray += [PSCustomObject] @{
        Name             = $cardNumber
        WinningNumbers   = $winningNumbersArray
        YourNumbers      = $yourNumbersArray
        DuplicationValue = 0
        Score            = 0
        MatchedNumbers   = @()
    }
}

$currentCardIndex = 0

foreach ($card in $cardArray)
{
    $loopCount =  0
    do {
        # calculate how far you are from the last card
        $distanceToEnd = $cardArray.Count - $currentCardIndex
        
        # Find matches
        $card.matchedNumbers += $card.YourNumbers | Where-Object {$card.WinningNumbers -contains $_}
        
        # Assign a score every time this card matches and dupe cards
        if ($card.MatchedNumbers.Count -gt 0)
        {
            $card.Score++
            $cardArray[($currentCardIndex + 1)..$card.MatchedNumbers.count] | foreach-object {$_.duplicationvalue++}
        
        }

        $loopCount++

    } until ($loopCount -ge $card.DuplicationValue)

    $currentCardIndex++
    # Duplicate subsequent cards


}

<#
# Find and process matches
:mainCardLoop for ($i = 0; $i -lt $cardArray.Count; $i++)
{
    # Variable config
    $matchedNumbers = @()

    # calculate how far you are from the last card
    $distanceToEnd = $cardArray.count - $i

    $loopCount = 0

    write-host "current card $($cardArray[$i].name)"

    # process each card based on the amount of instances it has
    do {
        #get the amount of matches
        $matchedNumbers += $cardArray[$i].YourNumbers | Where-Object {$cardArray[$i].WinningNumbers -contains $_}
        
        # Check if the amount of matches you have does not go past the end of the array
        if ($matchedNumbers.count -le $distanceToEnd -and $matchedNumbers.Count -ne 0)
        {
            #increment the subsquent entries
            $cardArray[($i+1)..$matchedNumbers.count] | ForEach-Object {$_.duplicationvalue++}
            $total += $matchedNumbers.count
            $loopCount++
        }

        # Checks if you're near the end
        elseif ($matchedNumbers.count -gt $distanceToEnd -and $matchedNumbers.Count -ne 0)
        {
            #increment the subsquent entries
            $cardArray[($i+1)..$distanceToEnd] | ForEach-Object {$_.duplicationvalue++}
            $total += $distanceToEnd
            $loopCount++
        }
    } 
    until ($cardArray[$i].DuplicationValue -eq $loopCount)
}

#>
Write-Host "Total: $total"