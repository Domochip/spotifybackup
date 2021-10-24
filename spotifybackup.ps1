Import-Module Spotishell

$VersionNumber = '0.0.1'

Write-Host "===== spotifybackup v$VersionNumber ====="

# Parse ENV
$BackupHour = $env:BACKUPHOUR
# $BackupRetention

while ($true) {

    Write-Host 'Working'

    # Wait 1 second
    Start-Sleep -Seconds 1
}