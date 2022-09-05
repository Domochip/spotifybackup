# spotifybackup

This Docker  image allows you to automate a full backup of your Spotify Library every day using [Spotishell PS module](https://github.com/wardbox/spotishell).  
This full backup can be used to be restored over your account or another one.  

# Prerequisites

You first need to create a Spotify Application.

**Step1**: Go to the [Spotify for Developers](https://developer.spotify.com/dashboard/applications) Dashboard, log in and create an app  
![step1.1.png](https://github.com/Domochip/spotifybackup/raw/master/img/step1.1.png) ![step1.2.png](https://github.com/Domochip/spotifybackup/raw/master/img/step1.2.png)  
**Step2**: Edit settings of the app and add `http://localhost:8080/spotishell` to Redirect URIs  
![step2.1.png](https://github.com/Domochip/spotifybackup/raw/master/img/step2.1.png) ![step2.2.png](https://github.com/Domochip/spotifybackup/raw/master/img/step2.2.png)  
**Step3**: Collect Client ID and Secret  
![step3.png](https://github.com/Domochip/spotifybackup/raw/master/img/step3.png)  

# Setup connection to Spotify

To setup Spotify connection, you need to run the image in "setup mode" using this commandline and follow instruction:  
`docker run -it --rm -v spotifybackup:/data --entrypoint pwsh domochip/spotifybackup setup.ps1`

### E.g:  
Provide Client ID and Client Secret then copy authorization URL:  
![setup1.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup1.png)  
Paste authorization URL in your browser, read then accept:  
![setup2.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup2.png)  
Copy the redirected url from the address bar:  
![setup3.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup3.png)  
Paste it into the setup container window (you should then receive a green result):  
![setup4.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup4.png) 

**Resulting connection information are then stored into the `spotifybackup` docker volume**

# Run spotifybackup

Docker Quick-Run  
```bash
docker run \
    -d \
    --name spotifybackup \
    -e BACKUPHOUR=2 \
    -e BACKUPRETENTION=30 \
    -e BACKUPPREFIX=SpotifyBackup \
    -v spotifybackup:/data \
    domochip/spotifybackup
```

Docker-Compose Quick-Run  
```yaml
version: '3'
volumes:
  spotifybackup:
services:
  spotifybackup:
    container_name: spotifybackup
    image: domochip/spotifybackup
    volumes:
      - spotifybackup:/data
    environment:
      - BACKUPHOUR=2
      - BACKUPRETENTION=30
      - BACKUPPREFIX=SpotifyBackup
```
(Backup your library everyday at 2:00PM)

#### Environment variables
* `BACKUPHOUR`: **Optional**, (Integer: 0 to 23) hour of publish everyday
* `BACKUPRETENTION`: **Optional**, (Positive Integer) Number of backup files to retain. Older files over this number are deleted
* `BACKUPPREFIX`: **Optional**, (String) First part of the backup file names


### E.g.

Container creation:  
![run1.png](https://github.com/Domochip/spotifybackup/raw/master/img/run1.png)  

Check container log:  
![run2.png](https://github.com/Domochip/spotifybackup/raw/master/img/run2.png)  

# Restore a backup

TODO