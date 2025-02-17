build {
    sources = [ "source.azure-arm.windowsimage-2019-repave" ]

# Apply Windows Updates and Cleanup
   provisioner "powershell" {
  inline = [
    "Write-Output 'Setting PSGallery repository to Trusted...'",
    "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted",
    "Write-Output 'Installing PSWindowsUpdate module...'",
    "Install-Module PSWindowsUpdate -Force -Scope CurrentUser",
    "Write-Output 'Importing PSWindowsUpdate module...'",
    "Import-Module PSWindowsUpdate",
    "Write-Output 'Listing available Windows updates...'",
    "Get-WindowsUpdate -Verbose",
    "Write-Output 'Installing Windows updates...'",
    "Install-WindowsUpdate -AcceptAll -Install -AutoReboot"
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




