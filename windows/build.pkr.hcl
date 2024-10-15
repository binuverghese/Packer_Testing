build {
    sources = [ "source.azure-arm.windowsimage" ]

 # Provisioner: Install IIS (as an example)
  provisioner "powershell" {
    inline = [
      "Install-WindowsFeature -name Web-Server -IncludeManagementTools",
      "$feature = Get-WindowsFeature -Name Web-Server",
      "if ($feature.Installed) { Write-Host 'IIS Installed Successfully.' } else { Write-Host 'IIS Installation Failed'; Exit 1 }"
    ]
  }

  # Provisioner: Run a simple script to create a text file (as an example)
  provisioner "powershell" {
    inline = [
      "New-Item -Path C:/ -Name 'testfile.txt' -ItemType 'file' -Value 'This is a test file.'"
    ]
  }

  # Provisioner: Restart Windows to apply the changes
  provisioner "windows-restart" {
    restart_timeout = "5m"
  }

   #   provisioner "powershell" {
   #   inline = [
   #     #"winrm quickconfig -force",

   #     #"New-NetFirewallRule -Name 'WinRM HTTP' -DisplayName 'WinRM HTTP' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 5985",

  #     "$ICMP = Get-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv4-In)'",
  #     "If ($ICMP -eq $null) {",
  #     "  write-host 'ICMP is not enabled'",
  #     "} elseif ($ICMP -ne $null) {",
  #     "  write-host 'ICMP is enabled, turning on now'",
  #     "  Set-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv4-In)' -enabled True",
  #     "}",

 #     "$ICMP = Get-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv6-In)'",
 #     "If ($ICMP -eq $null) {",
 #     "  write-host 'ICMP is not enabled'",
  #     "} elseif ($ICMP -ne $null) {",
 #     "  write-host 'ICMP is enabled, turning on now'",
 #      "  Set-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv6-In)' -enabled True",
 #     "}"
 #   ]
 # }

} 


