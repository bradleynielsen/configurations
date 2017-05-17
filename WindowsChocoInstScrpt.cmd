@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco upgrade chocolatey
choco install googlechrome   -y
choco install windirstat  -y
choco install chocolatey-core.extension  -y
choco install curl  -y
choco install gimp  -y
choco install sublimetext3.packagecontrol  -y
choco install audacity  -y
choco install googledrive  -y
choco install qbittorrent  -y
choco install yarn -y
choco install slack -y
choco install cccp -y
choco install openoffice -y
choco install nvidia-display-driver -y
choco install microsoft-build-tools  -y
choco install googlechrome-allusers -y
choco install sublimetext3  -y
choco install atom   -y
choco install mongodb -y
choco install 7zip  -y
choco install nodejs -y
choco install cmder  -y
choco install git -y
choco install putty -y
choco install python -y
npm i -g nodemon webpack 
pip install httpie
