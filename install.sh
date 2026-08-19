#!/usr/bin/env bash
set -e

sudo install -m 0644 symbols/fuskey /usr/share/X11/xkb/symbols/fuskey

for file in /usr/share/X11/xkb/rules/base.xml /usr/share/X11/xkb/rules/evdev.xml; do
    if ! grep -q "<name>fuskey</name>" "$file"; then
        sudo sed -i "/<\/layoutList>/i\    <layout><configItem><name>fuskey</name><shortDescription>FusKey</shortDescription><description>FusKey Multilingual QWERTY</description></configItem></layout>" "$file"
    fi
done

gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fuskey'), ('xkb', 'eu'), ('xkb', 'us'), ('xkb', 'es'), ('xkb', 'es+cat')]"

mkdir -p ~/.config/autostart
printf "[Desktop Entry]\nType=Application\nName=FusKey Layout\nExec=/usr/bin/setxkbmap -layout fuskey\nX-GNOME-Autostart-enabled=true\nNoDisplay=true\n" > ~/.config/autostart/fuskey.desktop

setxkbmap -layout fuskey
echo "FusKey installed."
