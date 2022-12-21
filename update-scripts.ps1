#Execute this script from any vm using following command:
#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; invoke-expression((New-Object System.Net.WebClient).DownloadString('https://github.com/madsenkg/cgi/raw/main/update-scripts.ps1'))

#Requires -RunAsAdministrator
Clear-Host
Set-Location $env:TEMP

#Start log
Start-Transcript -Append -Path (join-path $env:TEMP ("update_cgiscripts\{0}_{1}.log" -f $env:COMPUTERNAME,(Get-Date -format yyyyMMdd))) 

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
Invoke-WebRequest -Uri https://github.com/madsenkg/cgi/raw/main/cgidevadmin-main.zip -OutFile .\cgidevadmin-main.zip
Expand-Archive .\cgidevadmin-main.zip -DestinationPath .\ -Force 
Copy-Item .\cgidevadmin-main\*.* -Destination $scriptFolder -Force
Remove-Item .\cgidevadmin-main -Force -Recurse

#Cleaning up
#Remove install files
Remove-Item .\update-scripts.ps1 -Force -Confirm:$false 

Stop-Transcript

#Clear-Host
Write-Output "Done..."