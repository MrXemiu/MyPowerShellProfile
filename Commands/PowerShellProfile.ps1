# Profile setup for the console host shell
# Will not be loaded by other hosts (e.g. VS11 Package Manager)

$Shell = $Host.UI.RawUI
$Shell.BackgroundColor="Black"
$Shell.ForegroundColor="Green"
$size = $Shell.BufferSize
$size.width=140
$size.height=5000
$Shell.BufferSize = $size
$size = $Shell.WindowSize
$size.width=140
$size.height=40
$Shell.WindowSize = $size

#Get if OS is 32 or 64 bit
$os=Get-WMIObject win32_operatingsystem
cls
#Set the default version of Visual Studio to use
$global:DefaultVisualStudio = "2012"
write-host "Default Visual Studio is $DefaultVisualStudio" -foregroundcolor yellow 

#setup the location of the users my document folder
$global:documentPath = [environment]::GetFolderPath([environment+SpecialFolder]::MyDocuments) 

# Helper functions for user/computer session management
function Invoke-Shutdown { &"$env:SystemRoot\System32\shutdown.exe" -s }
function Invoke-Reboot { &"$env:SystemRoot\System32\shutdown.exe" -r }
function Invoke-Logoff { &"$env:SystemRoot\System32\shutdown.exe" -l }
function Invoke-Standby { &"$env:SystemRoot\System32\rundll32.exe" powrprof.dll,SetSuspendState Standby }
function Invoke-Hibernate { &"$env:SystemRoot\System32\rundll32.exe" powrprof.dll,SetSuspendState Hibernate }
function invoke-terminalLock { &"$env:SystemRoot\System32\rundll32.exe" User32.dll,LockWorkStation }

function Test-Administrator{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

function Set-TitleBar{
	$userTest = Test-Administrator

	if ($userTest -eq "True"){	
		$Admin = " -- Administrator"
	}else{
		$Admin = ""
	}
	$Shell.WindowTitle="$env:username 's Profile : PowerShell Version : " + $PSVersionTable.PSVersion + $Admin + " : " + $os.OSArchitecture
}

function Set-HomeLocation{
	#write-host "Home directory: $homedir"
	Set-Location $homedir
}

function Invoke-pscx{
	$scripts = resolve-path "$homedir\MyPowerShellProfile\"
	$pscxUserPreference = "$scripts\modules\Pscx\"

	# Modules are stored here
	$env:PSModulePath = join-path $scripts modules

	# Load in support modules
	write-Host "Loading Pscx Extensions"
	Import-Module "Pscx" -Arg (join-path $pscxUserPreference Pscx.UserPreferences.ps1)
	write-host "PowerShell Community Extensions $($Pscx:Version) is Loaded" -foregroundcolor yellow 
}

#Set the windows title
Set-TitleBar
Invoke-pscx
Set-HomeLocation

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

Pop-Location


# Load posh-git example profile

#todo add a check to see if git is even installed
$poshgitProfile = "$homedir\MyPowerShellProfile\modules\posh-git\profile.example.ps1"
#write-host $poshgitProfile
if (Test-Path $poshgitProfile)
{
	write-host "Loading Posh-git and Locations" -foregroundcolor blue 
	Import-Module $poshgitProfile 	
}
else
{
	write-host "could not find Posh-git folder"
}

$commandsFolder = "$homedir\MyPowerShellProfile\Commands"
if (Test-Path $commandsFolder)
{
	Import-Module "$commandsFolder\CleanUpDocuments.ps1"
	Import-Module "$commandsFolder\MyCommands.ps1"
	Import-Module "$commandsFolder\MyCommandsGit.ps1"
	Import-Module "$commandsFolder\MyCommandsTfs.ps1"
	Import-Module "$commandsFolder\path.ps1"
	Import-Module "$commandsFolder\setAlias.ps1"
	Import-Module "$commandsFolder\setLocations.ps1"
	Import-Module "$commandsFolder\startApplication.ps1"
	
}
else
{
	write-host "could not find command folder"
}

#Set Alias
Set-Alias home Set-HomeLocation

#cls