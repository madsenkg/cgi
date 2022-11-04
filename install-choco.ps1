Invoke-Expression (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
$env:Path += ';%ALLUSERSPROFILE%\chocolatey\bin'
choco install googlechrome -y -v
choco install microsoft-edge -y -v
choco install microsoftazurestorageexplorer -y -v
choco install sql-server-management-studio -y -v
choco install vscode -y -v
choco install notepadplusplus -y -v 
choco install windirstat -y -v
choco install postman -y -v