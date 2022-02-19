FROM mcr.microsoft.com/powershell:latest

RUN pwsh -c 'Install-Module Spotishell -force'

WORKDIR /app
COPY spotifybackup.ps1 .

ENV SPOTISHELL_STORE_PATH=/data

ENTRYPOINT ["pwsh", "spotifybackup.ps1"]
