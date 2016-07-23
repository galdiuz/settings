wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo add-apt-repository -y ppa:ne0sight/chrome-gnome-shell
sudo apt-get update
sudo apt-get install -y google-chrome-stable chrome-gnome-shell
