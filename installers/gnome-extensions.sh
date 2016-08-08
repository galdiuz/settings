sudo wget -O /usr/local/sbin/gnomeshell-extension-manage https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage
sudo chmod +x /usr/local/sbin/gnomeshell-extension-manage

# Pixel saver
gnomeshell-extension-manage --install --extension-id 723 --version 3.18
# Activities configurator
gnomeshell-extension-manage --install --extension-id 358 --version 3.18

gnome-shell --replace > /dev/null 2>&1 &

sudo cp ~/.local/share/gnome-shell/extensions/*/schemas/org.gnome.shell.extensions.*.gschema.xml /usr/share/glib-2.0/schemas
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

# Settings
gsettings set org.gnome.shell.extensions.activities-config activities-config-button-removed true
gsettings set org.gnome.shell.extensions.activities-config activities-config-hot-corner true
gsettings set org.gnome.shell.extensions.activities-config panel-hide-rounded-corners true
gsettings set org.gnome.shell.extensions.activities-config transparent-panel 20
gsettings set org.gnome.shell.extensions.activities-config panel-background-color-hex-rgb '#111111'
