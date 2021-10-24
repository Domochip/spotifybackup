FROM mcr.microsoft.com/powershell:latest

# temporary install from github
RUN pwsh -c 'Install-Module InstallModuleFromGitHub -force'
RUN pwsh -c 'Install-ModuleFromGitHub -GitHubRepo wardbox/Spotishell'
RUN mv /root/.local/share/powershell/Modules/Spotishell/1.0.1/Spotishell/* /root/.local/share/powershell/Modules/Spotishell/1.0.1

# RUN pwsh -c 'Install-Module Spotishell -force'

WORKDIR /app
COPY spotifybackup.ps1 .

ENV SPOTISHELL_STORE_PATH=/data

ENTRYPOINT ["pwsh", "spotifybackup.ps1"]
