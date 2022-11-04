cls
$documentFolder = [Environment]::GetFolderPath("MyDocuments")
#$downloadFolder = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$scriptFolder = join-path  $documentFolder "scripts"

#Check if Script folder is in place


#"Test to see if folder [$Folder]  exists"
if (Test-Path -Path $scriptFolder) {
    "Path exists!"
    Remove-Item -Path $scriptFolder -Filter *.ps1 -Force -Verbose
} else {
    "Path doesn't exist."
    New-Item -Path $scriptFolder -ItemType "Directory" -Force -Verbose
}

#Download the Zip files

#Unzip the The DevAdmin Files and copy the files to Script folder
Expand-Archive .\vmdevadmin-main.zip -DestinationPath . -Force -Verbose
Copy-Item .\vmdevadmin-main -Destination $scriptFolder -Force -Verbose


#Unzip the vm setup file to the downlod folder




# Remove the Zip file



# Remove this file