#Requires -RunAsAdministrator

#Clear-Host;
#Script version
$Script:Version = '1.0.1';

try {
   
   Get-ChildItem -Path $env:USERPROFILE -Filter 'Documents\Visual Studio*' -Directory | ForEach {

        $ProjectPath = $_.FullName
        $ProjectPath = (join-path $ProjectPath "Projects")
        If(!(test-path $ProjectPath))
        {
            New-Item -ItemType Directory -Force -Path $ProjectPath -Verbose
        }
    }
}

catch {
    Write-Output "Something went wrong ! "
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Write-Warning ("{0} - {1}" -f $FailedItem, $ErrorMessage)
    exit
}

