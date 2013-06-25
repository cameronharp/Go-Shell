#Go-Shell#

Allows PowerShell users to navigate to a specific directory in a quick and easy way using bookmarks.

##Installation##

If you have [PsGet](http://psget.net/) installed you can simply execute the following in PowerShell v3:

	Install-Module Go

If you have [PsGet](http://psget.net/) installed you can simply execute the following in PowerShell v2:

	Install-Module Go -AddToProfile 

Or you can use the following alternative:

####Manually####

1. Copy `Go.psm1` to your modules folder (e.g. `$Env:PSModulePath\Go\`)
2. Execute `Import-Module Go` (or add this command to your profile)
3. Bookmark away!

##How to Use Go##

<pre>Usage:
    go label
    go label -delete or -d
    go label -show or -s
    go label -add or -a
    go label C:\SomePath -add or -a
    go -showAll or -sa
    go -clear or -c
    go -last or -l

Switches:
    -add or -a             Adds the current directory.
    -delete or -d          Remove the given key from the directory.
    -showAll or -sa        Show all the keys and values in the directory.
    -show or -s            Show the specific key and value.
    -clear or -c           Clears all the keys and values in the directory.
    -last or -l            Goes to the last used go key.
    -help or -h            Displays this screen.

Tips:
    - Pressing the tab button after a few letters will auto fill the rest of the bookmark keyword.