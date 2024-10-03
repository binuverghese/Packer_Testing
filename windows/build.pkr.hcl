build {
    sources = [ "source.azure-arm.windowsimage" ]

  provisioner "powershell" {
    inline = ["Set-ExecutionPolicy Bypass -Scope Process -Force", "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12", "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))", "choco install 7zip -y --force --force-dependencies", "choco install vscode -y --force --force-dependencies", "choco install firefox -y --force --force-dependencies", "choco install terraform -y --force --force-dependencies" ,"choco install packer -y --force --force-dependencies", "choco install azurecli -y --force --force-dependencies"]
  }
  provisioner "windows-restart" {

  }
  provisioner "powershell" {
    inline = ["while ((Get-Service RdAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "while ((Get-Service WindowsAzureGuestAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm", "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"]
  }
}

