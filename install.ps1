Clear-Host

#Init
$documentFolder = [Environment]::GetFolderPath("MyDocuments")
$scriptFolder = join-path  $documentFolder "scripts"

#Check if Script folder is in place
if (Test-Path -Path $scriptFolder) {
    "Path exists!"
    Remove-Item $scriptFolder -Include *.ps1 -Force -Verbose
} else {
    "Path doesn't exist."
    New-Item -Path $scriptFolder -ItemType "Directory" -Force -Verbose
}

#Download and Unzip the The DevAdmin Files and copy the files to Script folder
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/vmdevadmin-main.zip -OutFile .\vmdevadmin-main.zip
Expand-Archive .\vmdevadmin-main.zip -DestinationPath .\ -Force -Verbose
Copy-Item .\vmdevadmin-main\*.* -Destination $scriptFolder -Force -Verbose
Remove-Item .\vmdevadmin-main -Force -Recurse -Verbose

#Download scripts and execute them
#Download and Install Chocolately programs
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-choco.ps1 -OutFile .\install-choco.ps1; .\install-choco.ps1
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-folders.ps1 -OutFile .\install-folders.ps1; .\install-folders.ps1
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-desktop-shortcuts.ps1 -OutFile .\install-desktop-shortcuts.ps1; .\install-desktop-shortcuts.ps1
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-taskbar-shortcuts.ps1 -OutFile .\install-taskbar-shortcuts.ps1; .\install-taskbar-shortcuts.ps1
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-setrunasadmin-shortcuts.ps1 -OutFile .\install-setrunasadmin-shortcuts.ps1; .\install-setrunasadmin-shortcuts.ps1

# Remove the Zip file
Remove-Item .\*.zip -Force -Recurse

#Remove install files
Remove-Item .\install.ps1 -Force -Recurse
Remove-Item .\install-choco.ps1 -Force -Recurse

#Set Administrator password never to expire
Set-LocalUser -SID (([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value) -PasswordNeverExpires $true

Clear-Host
Write-Output "Done..."