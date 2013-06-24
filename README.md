Go-Shell
========

Allows powershell users to navigate to specific directory paths in a quick and easy way.

Install Steps
=============

**Using the installer**

1. Run the Go-Shell.exe

**Manual installation**

1. Navigate to **>** C:\Users\{user}\Documents\WindowsPowerShell
2. Copy the Modules forlder into this location.
3. If using PowerShell v2
	- Open a PowerShell window
	- Run **>** Import-Module go
	- Run **>** Import-Module tabExtensions
4. If using PowerShell v3 the modules should be loaded automatically into PowerShell. If the tabbing or go functions are not working run step 3 commands.

Help File
=========

**Usage:**

	go label

	go label -delete or -d

	go label -show or -s

	go label -showAll or -sa

	go label -add or -a

	go label C:\SomePath -add

	go -clear or -c

**Switches:**

	-add or -a,        Adds the current directory.

	-delete or -d      Remove the given key from the directory.

	-showAll or -sa    Show all the keys and values in the directory.

	-show or -s        Show the specific key and value.

	-clear or -c       Clears all the keys and values in the directory.

	-help or -h        Displays this screen.

**Tips:**

	- Pressing the tab button after a few letters will auto fill the rest of the keyword.
	- Pressing the tab button with no letters will select your last selected keyword.
