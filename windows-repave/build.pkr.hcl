build {
    sources = [ "source.azure-arm.windowsimage-2019-repave" ]

# Apply Windows Updates and Cleanup
    provisioner "powershell" {
    inline = [
    "Write-Output 'Ensuring Temp Directory Exists...'",
    "New-Item -Path 'C:\\Windows\\Temp' -ItemType Directory -Force",

    "Write-Output 'Installing NuGet Provider if not present...'",
    "$nuget = Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue",
    "if (-not $nuget) { Install-PackageProvider -Name NuGet -Force }",

    "Write-Output 'Setting Execution Policy...'",
    "Set-ExecutionPolicy RemoteSigned -Scope Process -Force",

    "Write-Output 'Installing PSWindowsUpdate Module...'",
    "Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck -AllowClobber",

    "Write-Output 'Importing PSWindowsUpdate Module...'",
    "Import-Module PSWindowsUpdate",

    "Write-Output 'Checking for Windows Updates...'",
    "$Updates = Get-WUList",
    "if ($Updates) {",
    "    Write-Output 'Installing Windows Updates...'",
    "    Get-WUInstall -AcceptAll -IgnoreReboot | Out-File C:\\Windows\\Temp\\WindowsUpdate.log",
    "    Write-Output 'Updates installed successfully.'",
    "} else {",
    "    Write-Output 'No updates available.'",
    "}"
    ]
    
 }




  # Additional Cleanup (Optional)
  provisioner "powershell" {
    inline = [
      "Write-Output 'Cleaning up temporary files...'",
      "Remove-Item -Path C:\\Temp\\* -Force -Recurse",
      "Write-Output 'Defragmenting and optimizing drives...'",
      "Optimize-Volume -DriveLetter C -ReTrim -Verbose"
    ]
  }
}




