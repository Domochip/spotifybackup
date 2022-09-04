# spotifybackup

This Docker  image allows you to automate a full backup of your Spotify Library every day using [Spotishell PS module](https://github.com/wardbox/spotishell).  
This full backup can be used to be restored over your account or another one.  

# Prerequisites

You first need to create a Spotify Application.

**Step1**: Go to the [Spotify for Developers](https://developer.spotify.com/dashboard/applications) Dashboard  
![step1.png](https://github.com/Domochip/spotifybackup/raw/master/img/step1.png)  
**Step2**: Log in and create an app  
![step2.png](https://github.com/Domochip/spotifybackup/raw/master/img/step2.png)  
**Step3**: Edit settings of the app and add 'http://localhost:8080/spotishell' to Redirect URIs  
![step3.png](https://github.com/Domochip/spotifybackup/raw/master/img/step3.png) ![step3.1.png](https://github.com/Domochip/spotifybackup/raw/master/img/step3.1.png) ![step3.2.png](https://github.com/Domochip/spotifybackup/raw/master/img/step3.2.png) ![step3.3.png](https://github.com/Domochip/spotifybackup/raw/master/img/step3.3.png)  
**Step4**: Collect Client ID and Secret  
![step4.1.png](https://github.com/Domochip/spotifybackup/raw/master/img/step4.1.png) ![step4.2.png](https://github.com/Domochip/spotifybackup/raw/master/img/step4.2.png)  

# Setup connection to Spotify

To setup Spotify connection, you need to run the image in "setup mode" using this commandline and follow instruction: 
`docker run -it --rm -v spotifybackup:/data --entrypoint pwsh spotifybackup:latest setup.ps1`

E.g:  
![setup1.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup1.png)  
![setup2.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup2.png) ![setup3.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup3.png) ![setup4.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup4.png)  
![setup5.png](https://github.com/Domochip/spotifybackup/raw/master/img/setup5.png) 

# Run spotifybackup

Run
`docker run -d --name spotifybackup -v spotifybackup:/data spotifybackup:latest`
