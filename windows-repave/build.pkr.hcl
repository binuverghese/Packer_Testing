build {
    sources = [ "source.azure-arm.windowsimage-2019-repave" ]

# Apply Windows Updates and Cleanup
   provisioner "powershell" {
    inline = [
      "Write-Output 'Applying Windows Updates for repaved image...'",
      "Install-Module PSWindowsUpdate -Force -Confirm:`$false",
      "Import-Module PSWindowsUpdate",
      "Get-WindowsUpdate -AcceptAll -Install -AutoReboot"
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




