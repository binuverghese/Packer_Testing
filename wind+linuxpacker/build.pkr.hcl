build {
    sources = [ "source.azure-arm.windowsimage-2019", "source.azure-arm.windowsimage-2022","source.azure-arm.rhel_image"]

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

         provisioner "powershell" {
         inline = [
           "winrm quickconfig -force",
    
           "New-NetFirewallRule -Name 'WinRM HTTP' -DisplayName 'WinRM HTTP' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 5985",
    
          "$ICMP = Get-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv4-In)'",
          "If ($ICMP -eq $null) {",
          "  write-host 'ICMP is not enabled'",
          "} elseif ($ICMP -ne $null) {",
          "  write-host 'ICMP is enabled, turning on now'",
          "  Set-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv4-In)' -enabled True",
          "}",
    
         "$ICMP = Get-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv6-In)'",
         "If ($ICMP -eq $null) {",
         "  write-host 'ICMP is not enabled'",
          "} elseif ($ICMP -ne $null) {",
         "  write-host 'ICMP is enabled, turning on now'",
          "  Set-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv6-In)' -enabled True",
         "}"
       ]
     }
   
 

 provisioner "powershell" {
    inline = ["while ((Get-Service RdAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "while ((Get-Service WindowsAzureGuestAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm", "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"]
  }

  ####Linux Build provisioniners
 provisioner "shell" {
  only = ["azure-arm.rhel_image"]
    inline = [
      "echo 'Starting system update...'",
      "sudo yum update -y",
      "echo 'Installing httpd...'",
      "sudo yum install -y httpd",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "echo 'Sleeping for 5 seconds to ensure httpd service starts properly...'",
      "sleep 15",
      "echo 'Build provisioning complete!'"
    ]
  }

  provisioner "shell" {
    only = ["azure-arm.rhel_image"]
    inline = [
      "echo 'Starting sleep...'",
      "sleep 60",
      "echo 'Sleep completed.'"
    ]
  }
} 


