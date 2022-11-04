Clear-Host

#Init
$Script:ScriptDir = Split-Path -Parent $PSCommandPath;
Set-Location $Script:ScriptDir;

$documentFolder = [Environment]::GetFolderPath("MyDocuments")
#$downloadFolder = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
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

#Download and Install Chocolately programs
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/install-choco.ps1 -OutFile .\install-choco.ps1; .\install-choco.ps1

#Download and Unzip the vm setup file and run the script
#Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/cloudhostedvm-main.zip -OutFile .\cloudhostedvm-main.zip
#Expand-Archive .\cloudhostedvm-main.zip -DestinationPath .\ -Force -Verbose


#Remove-Item .\cloudhostedvm-main -Force -Recurse -Verbose

# Remove the Zip file
#Remove-Item .\*.zip -Force -Recurse -Verbose

# Remove this file
#Remove-Item .\install.ps1 -Force -Recurse -Verbose
#Remove-Item .\install-choco.ps1 -Force -Recurse -Verbose