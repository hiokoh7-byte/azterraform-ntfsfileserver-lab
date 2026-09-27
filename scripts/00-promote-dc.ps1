Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force  
Write-Host "Installing AD DS..." -ForegroundColor Yellow 
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Verbose:$false 
$safeModePassword = ConvertTo-SecureString 'SAFE_MODE_PASSWORD' -AsPlainText -Force 
Import-Module ADDSDeployment 
Install-ADDSForest `
    -DomainName                    "lab.local" `
    -DomainNetbiosName             "LAB" `
    -ForestMode                    "WinThreshold" `
    -DomainMode                    "WinThreshold" `
    -InstallDns:                   $true `
    -SafeModeAdministratorPassword $safeModePassword `
    -Force:                        $true `
    -NoRebootOnCompletion:         $true `
    -ErrorAction                   Stop
# -NoRebootOnCompletion means nothing restarts DC01 on its own, so schedule the restart here.
# The delay lets this Run Command return cleanly before the VM goes down.
Write-Host "Promotion complete. Restarting DC01 in 30 seconds..." -ForegroundColor Yellow
shutdown /r /t 30 /c "Completing AD DS promotion"