Import-Module Spotishell

$VersionNumber = '0.9.0'

function Write-Log {
    param (
        $Message
    )
    Write-Host "$(Get-Date -AsUTC -UFormat '%F-%T') : $Message"
}

Write-Log "===== spotifybackup v$VersionNumber ====="

# Parse ENV
$BackupHour = $env:BACKUPHOUR ?? 2
$BackupRetention = $env:BACKUPRETENTION ?? 30
$BackupPrefix = $env:BACKUPPREFIX ?? 'SpotifyBackup'
$SpotifyClientId = $env:SPOTIFY_CLIENTID
$SpotifyClientSecret = $env:SPOTIFY_CLIENTSECRET

if (-not $SpotifyClientId -or -not $SpotifyClientSecret) {
    Write-Log 'You need to provide SPOTIFY_CLIENTID and SPOTIFY_CLIENTSECRET environnement variables'
    Write-Log 'Exiting...'
    Exit
}

# Initialize Spotify Application
$spotApp = Get-SpotifyApplication
if ($null -eq $spotApp) {
    New-SpotifyApplication -ClientId $SpotifyClientId -ClientSecret $SpotifyClientSecret
}
elseif ($spotApp.ClientId -ne $SpotifyClientId -or $spotApp.ClientSecret -ne $SpotifyClientSecret) {
    Set-SpotifyApplication -ClientId $SpotifyClientId -ClientSecret $SpotifyClientSecret
}
Initialize-SpotifyApplication


while ($true) {

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

    Write-Log 'Backup process finished'

    # Wait 60 second
    Start-Sleep -Seconds 60
}