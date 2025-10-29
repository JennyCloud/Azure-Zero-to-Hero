# Purpose: Install IIS and create test web pages

# Install IIS on the local VM
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create a simple test web page
$page = "C:\inetpub\wwwroot\index.html"
Set-Content -Path $page -Value "<h1>Hello from $(hostname)</h1><p>Load balancing test page.</p>"

# Optional: verify IIS is running
Get-Service -Name W3SVC
