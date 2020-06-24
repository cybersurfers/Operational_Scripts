Write-Host "Select Enumberation Method: "
Write-Host ""
Write-Host "  1: Single Remote Computer "
Write-Host "  2: List of Computers "
Write-Host "  3: Local Computer"
Write-Host ""
$choice = Read-Host -Prompt 'Selection'

if ($choice -eq 1){
    $CN = Read-Host -Prompt 'Input computer name'
    $cred = Get-Credential
    Invoke-command -cn $CN -Credential $cred -Scriptblock {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize} > C:\$CN.txt
    Invoke-command -cn $CN -Credential $cred -Scriptblock {Get-ItemProperty HKLM:\Software\\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize} >> C:\"$CN.txt"

}elseif ($choice -eq 2) {
    $Path = Read-Host -Prompt 'Enter file location'
    $cred = Get-Credential
    Invoke-command -cn (Get-Content $Path) -Credential $cred -Scriptblock {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize} > C:\listsoftware.txt
    Invoke-command -cn (Get-Content $Path) -Credential $cred -Scriptblock {Get-ItemProperty HKLM:\Software\\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize} >> C:\listsoftware.txt

}elseif ($choice -eq 3) {
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize > C:\localsoftware.txt
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize >> C:\localsoftware.txt
}else {
    Write-host("Error: Number is not valid selection. Exiting.....")
}