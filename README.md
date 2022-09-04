Setup Spotify configuration (stored in volume)
`docker run -it --rm -v spotifybackup:/data --entrypoint pwsh spotifybackup:latest setup.ps1`

Run
`docker run -d --name spotifybackup -v spotifybackup:/data spotifybackup:latest`
