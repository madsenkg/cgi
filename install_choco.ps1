@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Set-LocalUser -SID (([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value) -PasswordNeverExpires $true"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
choco install googlechrome -y -v
choco install microsoft-edge -y -v
choco install microsoftazurestorageexplorer -y -v
choco install sql-server-management-studio -y -v
choco install vscode -y -v
choco install notepadplusplus -y -v 
choco install windirstat -y -v
choco install postman -y -v