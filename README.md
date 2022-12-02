# cgi
CGI D365fo Developer toolset for Azure VMs

To install the scripts, Open PowerShell in Admin mode and run following command:

`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; invoke-expression((New-Object System.Net.WebClient).DownloadString('https://github.com/madsenkg/cgi/raw/main/install.ps1'))`
