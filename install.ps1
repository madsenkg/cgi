#Execute this script from any vm using following command:
#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; invoke-expression((New-Object System.Net.WebClient).DownloadString('https://github.com/madsenkg/cgi/raw/main/install.ps1'))

#Requires -RunAsAdministrator
#Clear-Host
Set-Location $env:TEMP

#Init
$documentFolder = [Environment]::GetFolderPath("MyDocuments")
$scriptFolder = join-path  $documentFolder "scripts"

#Check if Script folder is in place or not 
if (Test-Path -Path $scriptFolder) {
    "Path exists!"
    #Remove all old files
    Remove-Item $scriptFolder -Include *.ps1 -Force
} else {
    "Path doesn't exist. Creating folder..."
    New-Item -Path $scriptFolder -ItemType "Directory" -Force
}

#Download and Unzip the The DevAdmin Files and copy the files to Script folder
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/vmdevadmin-main.zip -OutFile .\vmdevadmin-main.zip
Expand-Archive .\vmdevadmin-main.zip -DestinationPath .\ -Force 
Copy-Item .\vmdevadmin-main\*.* -Destination $scriptFolder -Force
Remove-Item .\vmdevadmin-main -Force -Recurse

#Download scripts and execute them
#Download and Install Chocolately programs
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-choco.ps1 -OutFile .\install-choco.ps1; .\install-choco.ps1
#Download script to create other folders
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-folders.ps1 -OutFile .\install-folders.ps1; .\install-folders.ps1
#Download script to create shortcuts on the desktop
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-desktop-shortcuts.ps1 -OutFile .\install-desktop-shortcuts.ps1; .\install-desktop-shortcuts.ps1
#Download script to create shortcuts to the taskbar
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-taskbar-shortcuts.ps1 -OutFile .\install-taskbar-shortcuts.ps1; .\install-taskbar-shortcuts.ps1
#Download script to alter shortcuts to RunAsAdmin
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-setrunasadmin-shortcuts.ps1 -OutFile .\install-setrunasadmin-shortcuts.ps1; .\install-setrunasadmin-shortcuts.ps1

#Set Administrator password never to expire
Set-LocalUser -SID (([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value) -PasswordNeverExpires $true

#Cleaning up
#Remove install files
Remove-Item .\install*.ps1 -Force -Confirm:$false 

#Clear-Host
Write-Output "Done..."