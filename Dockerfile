FROM mcr.microsoft.com/powershell:alpine-3.14

RUN pwsh -c 'Install-Module Spotishell -force'

WORKDIR /app
COPY spotifybackup.ps1 .

ENV SPOTISHELL_STORE_PATH=/data
ENV BACKUP_STORE_PATH=/data

ENTRYPOINT ["pwsh", "spotifybackup.ps1"]