#Requires -RunAsAdministrator
#Source : https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/16cb4ca1-9339-4d0c-a68d-bf1d6cc0f943?redirectedfrom=MSDN
#       : https://stackoverflow.com/questions/28997799/how-to-create-a-run-as-administrator-shortcut-using-powershell
#Start log
Start-Transcript -Append -Path (join-path $env:TEMP ("cgiscripts\{0}_{1}.log" -f $env:COMPUTERNAME,(Get-Date -format yyyyMMdd))) 

$SourcePath = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" -Name "Common Programs" 

#region - Setting RunAsAdmin
#Visual Studio 2017
if (test-path ((join-path $SourcePath.'Common Programs' "Visual Studio 2017.lnk"))) {
    $Shortcut = Get-ChildItem (join-path $SourcePath.'Common Programs' "Visual Studio 2017.lnk") -ErrorAction Ignore -WarningAction Ignore
    If($Shortcut) {
        $bytes = [System.IO.File]::ReadAllBytes($Shortcut.FullName)
        $bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON 
        [System.IO.File]::WriteAllBytes($Shortcut.FullName, $bytes)
    }
}

#Visual Studio 2019
if (test-path (join-path $SourcePath.'Common Programs' "Visual Studio 2019.lnk"))  {
    $Shortcut = Get-ChildItem (join-path $SourcePath.'Common Programs' "Visual Studio 2019.lnk")
    If($Shortcut) {
        $bytes = [System.IO.File]::ReadAllBytes($Shortcut.FullName)
        $bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON 
        [System.IO.File]::WriteAllBytes($Shortcut.FullName, $bytes)
    }
}

#PowerShell
if (test-path ((join-path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk")))  {
    $Shortcut = Get-ChildItem (join-path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk")
    If($Shortcut) {
        $bytes = [System.IO.File]::ReadAllBytes($Shortcut.FullName)
        $bytes[0x15] = $bytes[0x15] -bor 0x20 #set byte 21 (0x15) bit 6 (0x20) ON 
        [System.IO.File]::WriteAllBytes($Shortcut.FullName, $bytes)
    }
}
#endregion

Stop-Transcript
