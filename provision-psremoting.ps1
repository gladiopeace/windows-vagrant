Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host
    Write-Host "ERROR: $_"
    Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
    Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
    Write-Host
    Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    Start-Sleep -Seconds (60*60)
    Exit 1
}

# enable PowerShell 5 remoting.
PowerShell -Command @'
Enable-PSRemoting -SkipNetworkProfileCheck
Get-PSSessionConfiguration
'@

# enable PowerShell 7 remoting.
&'C:\Program Files\PowerShell\7\pwsh.exe' -Command @'
Enable-PSRemoting -SkipNetworkProfileCheck
Get-PSSessionConfiguration
'@
