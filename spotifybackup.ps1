Import-Module Spotishell

$VersionNumber = '0.9.9'

function Write-Log {
    param (
        $Message
    )
    Write-Host "$(Get-Date -UFormat '%F-%T') : $Message"
}

Write-Log "===== spotifybackup v$VersionNumber ====="

# Parse ENV
$BackupHour = $env:BACKUPHOUR ?? 2
$BackupRetention = $env:BACKUPRETENTION ?? 30
$BackupPrefix = $env:BACKUPPREFIX ?? 'SpotifyBackup'


# Verify Spotify Application
try {
    Get-SpotifyApplication | Out-Null
}
catch {
    Write-Log 'Spotify Application is not set. Please run this configuration command line first : '
    Write-Log '    docker run -it --rm -v spotifybackup:/data --entrypoint pwsh spotifybackup:latest setup.ps1'
    Write-Log 'Exiting...'
    Exit
}

Initialize-SpotifyApplication

$nextBackupTime = (Get-Date).Date.AddHours($BackupHour)
if ($nextBackupTime -le (Get-Date)) { $nextBackupTime = $nextBackupTime.AddDays(1) }
Write-Log ('Now waiting for the next backup time => ' + ($nextBackupTime | Get-Date -UFormat '%F %T'))

$lastBackupTime = Get-Date

while ($true) {

    $now = Get-Date
    $todayBackupTime = (Get-Date).Date.AddHours($BackupHour)

    # if today backup time is between $lastBackupTime and $now, then backup

    if ($lastBackupTime -lt $todayBackupTime -and $todayBackupTime -le $now) {

        Write-Log 'Backup Time'
        $backupFileName = "$BackupPrefix-$(Get-Date -AsUTC -UFormat '%F-%H-%M').json"
        Backup-Library -Path "$env:BACKUP_STORE_PATH/$backupFileName"
        Write-Log "Library backed up to file '$backupFileName'"

        Write-Log 'Cleanup'
        $backupFiles = Get-ChildItem -Path $env:BACKUP_STORE_PATH -Filter "$BackupPrefix-*" | Sort-Object -Property Name
        if ($backupFiles.Count -gt $BackupRetention) {
            foreach ($file in $backupFiles[0..$($backupFiles.Count - $BackupRetention - 1)]) {
                Remove-Item $file
                Write-Log "$($file.Name) removed"
            }
        }
        else { Write-Log 'No backup file over retention to remove' }

        # Update last backup time
        $lastBackupTime = $todayBackupTime

        Write-Log 'Backup process finished'
    }

    # Wait 1 second
    Start-Sleep -Seconds 1
}