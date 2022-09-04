Import-Module Spotishell

Write-Host "===== spotifybackup SETUP ====="

$SpotifyClientId = Read-Host -Prompt 'Please provide Spotify Client ID'
$SpotifyClientSecret = Read-Host -Prompt 'Please provide Spotify Client Secret'

try {
    $spotApp = Get-SpotifyApplication
}
catch {}

if ($null -eq $spotApp) {
    New-SpotifyApplication -ClientId $SpotifyClientId -ClientSecret $SpotifyClientSecret
}
elseif ($spotApp.ClientId -ne $SpotifyClientId -or $spotApp.ClientSecret -ne $SpotifyClientSecret) {
    Set-SpotifyApplication -ClientId $SpotifyClientId -ClientSecret $SpotifyClientSecret
}
Write-Host 'Initialize Spotify Application'
Initialize-SpotifyApplication

Write-Host 'Now you can run spotifybackup container'