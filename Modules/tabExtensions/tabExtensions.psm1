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
    $rememberFilePath = "$([Environment]::GetFolderPath('LocalApplicationData'))\Go\rememberLast.txt"
    $textContent = Get-Content $textFilePath
    $rememberContent = Get-Content $rememberFilePath
    $inputKeys = $filter.Split(' ')
    $matchingKey = $inputKeys[$inputKeys.length - 1]

    if($rememberContent -and $matchingKey -eq "")
    {
        $lastSelected = ""

        $rememberContent | ForEach {
            $lastSelected = $_.Split("|")[0]
        }        

        $lastSelected | sort
    }
    else
    {
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
}