build {
    sources = [ "source.azure-arm.windowsimage" ]

  provisioner "powershell" {
    inline = ["Set-ExecutionPolicy Bypass -Scope Process -Force", "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12", "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))", "choco install 7zip -y --force --force-dependencies", "choco install vscode -y --force --force-dependencies", "choco install firefox -y --force --force-dependencies", "choco install terraform -y --force --force-dependencies" ,"choco install packer -y --force --force-dependencies", "choco install azurecli -y --force --force-dependencies"]
    timeout = "15m"
  }
  
  provisioner "windows-restart" {
    restart_timeout = "5m"
  }


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
      # Enable File and Printer Sharing (ICMPv4-In)
      "New-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv4-In)' -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -Action Allow -Enabled True -Profile Any -Description 'Allow ICMPv4 Echo Requests'"
      
    ]
  }

   

 provisioner "powershell" {    
   inline = [      
   # Enable File and Printer Sharing (ICMPv6-In)     
   "New-NetFirewallRule -DisplayName 'File and Printer Sharing (Echo Request - ICMPv6-In)' -Direction Inbound -Protocol ICMPv6 -IcmpType 128 -Action Allow -Enabled True -Profile Any -Description 'Allow ICMPv6 Echo Requests'"    
    ]  
 }

  provisioner "powershell" {
    inline = ["while ((Get-Service RdAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "while ((Get-Service WindowsAzureGuestAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm", "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"]
  }
}

