function go([string]$key, [string]$selectedPath = "", [switch]$help, [switch]$h, [switch]$add, [switch]$a, [switch]$delete, [switch]$d, [switch]$clear, [switch]$c, [switch]$show, [switch]$s, [switch]$showAll, [switch]$sa, [switch]$last, [switch]$l)
{
    #------------------------------------Help------------------------------------
    if($help -or $h)
    {
        Write-Host
        Write-Host "Go Directory Help"
        Write-Host "-----------------"
        Write-Host "Usage:"
        Write-Host "    go label"
        Write-Host "    go label -delete or -d"
        Write-Host "    go label -show or -s"
        Write-Host "    go label -add or -a"
        Write-Host "    go label C:\SomePath -add or -a"
        Write-Host "    go -showAll or -sa"
        Write-Host "    go -clear or -c"
        Write-Host
        Write-Host "Switches:"
        Write-Host "    -add or -a             Adds the current directory."
        Write-Host "    -delete or -d          Remove the given key from the directory."
        Write-Host "    -showAll or -sa        Show all the keys and values in the directory."
        Write-Host "    -show or -s            Show the specific key and value."
        Write-Host "    -clear or -c           Clears all the keys and values in the directory."
        Write-Host "    -help or -h            Displays this screen."
        Write-Host
        Write-Host "Tips:"
        Write-Host "    - Pressing the tab button after a few letters will auto fill the rest of the keyword."
        Write-Host "    - Pressing the tab button with no letters will select your last selected keyword." 
        Write-Host

        return
    }

    #------------------------------------Go Last------------------------------------    
    if($last -or $l)
    {
        $rememberFilePath = "$([Environment]::GetFolderPath('LocalApplicationData'))\Go\rememberLast.txt"
        $rememberContent = Get-Content $rememberFilePath
        
        $lastSelected = ""

        $rememberContent | ForEach {
            $lastSelected = $_
        }
        
        if($lastSelected)
        {
            Push-Location $lastSelected
        }
    
        return
    }

    #------------------------------------Check Setup------------------------------------
    $directoryBasePath = "$([Environment]::GetFolderPath('LocalApplicationData'))\Go"
    $directoryPath = $directoryBasePath  + "\go.txt"
    $directoryLastBookmark = $directoryBasePath + "\rememberLast.txt";
    $hasdirectory = Test-Path $directoryBasePath

    if(!$hasdirectory)
    {
        $doNothing = New-Item -ItemType directory -Path $directoryBasePath
        $doNothing = New-item $directoryPath -type file
        $doNothing = New-Item $directoryLastBookmark -type file
    }
    else
    {
        $hasfile = Test-Path $directoryPath

        if(!$hasfile)
        {
            $doNothing = New-item $directoryPath -type file
        }
    }

    #------------------------------------Show all keys------------------------------------
    if($showAll -or $sa)
    {
        $directoryContent = Get-Content $directoryPath

        if($directoryContent)
        {
            $longestCount = 0
            $directoryArray = @{}

            foreach($item in $directoryContent)
            {
                $keys = $item.Split("|")
                $keyLength = $keys[0].Length

                if($longestCount -eq 0)
                {
                    $longestCount = $keyLength
                }
            
                if($keyLength -gt $longestCount)
                {
                    $longestCount = $keyLength
                }
            }

            if($longestCount -gt 0)
            {
                $lineBreak = ""
                $dashLine = ""

                for($index = 0; $index-lt $longestCount; $index++)
                {
                    $lineBreak += " ";
                    $dashLine += "-"
                }

                Write-Host
                Write-Host "Key" $lineBreak "Value"
                Write-Host $dashLine "    ------------------" -ForegroundColor Yellow

                foreach($item in $directoryContent)
                {
                    $keys = $item.Split("|")
                    $subCount = $longestCount - $keys[0].Length
                    $middleBreak = "   "

                    for($index = 0; $index -lt $subCount; $index++)
                    {
                        $middleBreak += " "
                    }   
                
                    Write-Host $keys[0] $middleBreak $keys[1]
                }

                Write-Host
            }
        }
    }

    #------------------------------------Show key------------------------------------
    if($show -or $s)
    {
        if($key)
        {
            $directoryContent = Get-Content $directoryPath

            if($directoryContent)
            {
                $specificValue = @{}

                foreach($item in $directoryContent)
                {
                    $keys = $item.Split("|")

                    if($keys[0] -eq $key.ToLower())
                    {
                        $specificValue = $keys

                        break
                    }
                }

                if($specificValue.Count -ne 0)
                {
                    $dashLine = ""
                    $lineBreak = ""

                    for($index = 0; $index-lt $specificValue[0].Length; $index++)
                    {
                        $lineBreak += " ";
                        $dashLine += "-"
                    }

                    Write-Host
                    Write-Host "Key" $lineBreak "Value"
                    Write-Host $dashLine "    ------------------" -ForegroundColor Yellow
                    Write-Host $specificValue[0] "    " $specificValue[1]
                    Write-Host
                }
            }
        }

        return
    }

    #------------------------------------Clear all keys------------------------------------
    if($clear -or $c)
    {
        $response = Read-Host "Are you sure you want to clear? [Y] or [N]"

        Write-Host $val

        if($response -and $response.ToLower() -eq "y")
        {
            Clear-Content $directoryPath
        }

        return
    }

    #------------------------------------Delete Key------------------------------------
    if($delete -or $d)
    {
        if($key)
        {
            $directoryContent = Get-Content $directoryPath

            if($directoryContent)
            {
                $keyToDelete = ""

                foreach($item in $directoryContent)
                {
                    $keys = $item.Split("|")

                    if($keys[0] -eq $key.ToLower())
                    {
                        $keyToDelete = $item

                        break
                    }
                }

                if($keyToDelete -ne "")
                {
                    $directoryContent = $directoryContent |? {$_ -ne $keyToDelete}

                    Clear-Content $directoryPath
                
                    Add-Content -Value $directoryContent -Path $directoryPath
                }
            }
        }

        return
    }

    #------------------------------------Add key------------------------------------

    if($add -or $a)
    {
        if($key)
        {
            $directoryContent = Get-Content $directoryPath
            $isDuplicate = $false
        
            if($directoryPath)
            {
                foreach($item in $directoryContent)
                {
                    $keys = $item.Split('|')

                    if($keys[0] -eq $key.ToLower())
                    {
                        $isDuplicate = $true;

                        break;
                    }
                }
            }

            if(!$isDuplicate)
            {
                $compositeKey = $key.ToLower() + "|"

                if($selectedPath)
                {
                    $compositeKey += $selectedPath
                }
                else
                {
                    $compositeKey += $pwd
                }

                Add-Content -value $compositeKey -Path $directoryPath
            }
        }

        return
    }

    #------------------------------------Push key------------------------------------
    if($key)
    {
        $directoryContent = Get-Content $directoryPath
        $bookmark = ""

        if($directoryContent)
        {
            foreach($item in $directoryContent)
            {
                $keys = $item.Split("|")

                if($keys[0] -eq $key.ToLower())
                {
                    $bookmark = $keys[1]

                    break
                }
            }

            if($bookmark)
            {
                $previous = Test-Path $directoryLastBookmark

                if(!$previous)
                {
                    $doNothing = New-Item $directoryLastBookmark -type file
                }
            
                Clear-Content $directoryLastBookmark
                Add-Content -Value $bookmark -Path $directoryLastBookmark
                Push-Location $bookmark
            }
        }
    }
}

#------------------------------Tab Expansion------------------------------
function TabExpansion($line, $lastWord) {
  $LineBlocks = [regex]::Split($line, '[|;]')
  $lastBlock = $LineBlocks[-1] 
 
  switch -regex ($lastBlock) {
    'go (.*)' { goTabExpansion($lastBlock) }
  }
}

function goTabExpansion($filter) {
    $textFilePath = "$([Environment]::GetFolderPath('LocalApplicationData'))\Go\go.txt"
    $textContent = Get-Content $textFilePath
    $inputKeys = $filter.Split(' ')
    $matchingKey = $inputKeys[$inputKeys.length - 1]

    if($textContent)
    {
        $fileHash = @{}

        $textContent | ForEach-Object {
            $keys = $_.Split("|")

            if($keys[0] -ne $matchingKey)
            {
                $fileHash.Add($keys[0], $keys[1])
            }
        }

        if($fileHash.Count -gt 0)
        {
            $fileHash.Keys | ForEach-Object {
                if($_.StartsWith($matchingKey))
                {
                    #this will output the auto filled key to the screen.
                    $_ | sort
                }
            }
        }
    }
}