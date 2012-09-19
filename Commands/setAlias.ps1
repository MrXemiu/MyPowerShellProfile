#Set Alias
Set-Alias Neo-APvX Set-APvX
Set-Alias Neo-APvXService Set-APvX_Service
Set-Alias Neo-APvXShare Set-APvX_Shared
Set-Alias Neo-APvX_Db Set-APvX_Db
Set-Alias Neo-BarcodeServices Set-BarcodeServices
Set-Alias Neo-NeoLabels Set-NeoLabels
Set-Alias Neo-NeoLabelsCommon Set-NeoLabelsCommon
Set-Alias Neo-NeoRootTFS Set-NeoProjectTFS
Set-Alias Neo-BarcodeRootTFS Set-NeoBarcodeRootTFS

Set-Alias ChlodnyWebApi Set-ChlodnyWebApi
Set-Alias Dropbox Set-Dropbox
Set-Alias SkyDrive Set-SkyDrive

#Reference from https://github.com/PProvost/dotfiles/blob/master/powershell/Aliases.ps1
# Global command aliases
# Because of how powershell works, some of thes are actually functions. :)

set-alias count measure-object
set-alias lsd get-childcontainers
set-alias lsf get-childfiles
set-alias rmd remove-allChildItems
if (test-path alias:\set) { remove-item alias:\set -force }
set-alias set set-variableEx -force
set-alias sudo Invoke-Elevated
set-alias unset remove-variable
set-alias whence get-commandInfoEx

set-alias logout invoke-userLogout
set-alias shutdown invoke-systemShutdown
set-alias restart invoke-systemReboot
if (test-path alias:\sleep) { remove-item alias:\sleep -force }
set-alias sleep invoke-systemSleep -force
set-alias lock invoke-terminalLock