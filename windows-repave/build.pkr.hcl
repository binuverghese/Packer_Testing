build {
    sources = [ "source.azure-arm.windowsimage-2019-repave" ]

# Apply Windows Updates and Cleanup
  provisioner "powershell" {
  inline = [
    "Write-Output 'Starting Windows Update...'",
    "New-Item -Path 'C:\\Windows\\Temp' -ItemType Directory -Force",
    "Import-Module WindowsUpdateProvider -ErrorAction SilentlyContinue",
    "$Updates = Get-WindowsUpdate",
    "if ($Updates) {",
    "    Write-Output 'Installing Windows Updates...'",
    "    Install-WindowsUpdate -AcceptAll -AutoReboot | Out-File C:\\Windows\\Temp\\WindowsUpdate.log",
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




