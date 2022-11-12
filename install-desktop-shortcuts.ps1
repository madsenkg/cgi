#Requires -RunAsAdministrator
#Start log
Start-Transcript -Append -Path (join-path $env:TEMP ("cgiscripts\{0}_{1}.log" -f $env:COMPUTERNAME,(Get-Date -format yyyyMMdd))) 

$TargetPath = (join-path $env:USERPROFILE "Desktop")
$SourcePath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

$Script:ScriptDir = Split-Path -Parent $PSCommandPath;
Set-Location $Script:ScriptDir;

Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice' -Name ProgId -Value 'ChromeHTML'
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice' -Name ProgId -Value 'ChromeHTML'

$WshShell = New-Object -ComObject WScript.Shell

#Copy Task Mananger and Event Viewer
Copy-Item (join-path $SourcePath "System Tools\Task Manager.lnk") $TargetPath
Copy-Item (join-path $SourcePath "Administrative Tools\Event Viewer.lnk") $TargetPath

#Create Shortcut link to Dynamics LCS
$Shortcut  = $WshShell.CreateShortcut($env:USERPROFILE + "\Desktop\LCS.url")
$Shortcut.TargetPath = "https://lcs.dynamics.com/v2"
$Shortcut.Save()

#Create ShortCut link to Azure Portal
$Shortcut = $WshShell.CreateShortcut($env:USERPROFILE + "\Desktop\Azure portal.url")
$Shortcut.TargetPath = "https://portal.azure.com"
$Shortcut.Save()

#Create ShortCut to CGI D365 Scripts
$Shortcut = $WshShell.CreateShortcut($env:USERPROFILE + "\Desktop\CGI Scripts.lnk")
$Shortcut.TargetPath   = $env:USERPROFILE + "\documents\scripts"
$Shortcut.Save()

#Create ShortCut to D365 Developer Menu
$Shortcut = $WshShell.CreateShortcut($env:USERPROFILE + "\Desktop\D365 Developer Admin Menu.lnk") 
$Shortcut.TargetPath = ("{0}\system32\WindowsPowerShell\v1.0\powershell.exe" -f $env:SystemRoot)
$Shortcut.WorkingDirectory = $env:USERPROFILE + "\documents\scripts"
$Shortcut.Arguments = "-noexit -command & ""$env:USERPROFILE\Documents\Scripts\D356fo_Developer_Administration.ps1"""
$Shortcut.Description = "Windows PowerShell"
$Shortcut.IconLocation = "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe"
$Shortcut.Save()

# Make the ShortCut runas Administrator
$bytes = [System.IO.File]::ReadAllBytes($Shortcut.FullName)
$bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON 
[System.IO.File]::WriteAllBytes($Shortcut.FullName, $bytes)

#Source: https://stackoverflow.com/questions/50057555/create-shortcut-to-run-with-powershell-with-powershell

Stop-Transcript
