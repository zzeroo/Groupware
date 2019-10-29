# OS, System und Tools
## Betriebssystem; Debian 10

Wir verwenden die [Debian][debian] `stable` Version, zur Zeit (2019-1024) ist diese
Version Debian 10 '[buster]'

Die `sources.list` des SOGo Servers sollte wie folgt aussehen.

```bash
# /etc/apt/sources.list
deb http://deb.debian.org/debian stable contrib main non-free
```

[debian]: https://debian.org
[buster]: https://wiki.debian.org/DebianBuster

## Hostname setzen

Der Hostname des Systems muss gesetzt werden. Dieser Wert wird von vielen Konfig Tools ausgelesen.

```bash
echo "sogo.ra-gas.de" | tee /etc/hostname
```

## Locale

<https://wiki.debian.org/Locale>

### interaktive Erstellung der Locales
```bash
dpkg-reconfigure locales
```

### Scriptgesteuerte Erstellung der Locales
```bash
cat <<-EOF > /etc/locale.gen
de_DE.UTF-8
en_US.UTF-8
EOF
```

Anschließend müssen die locales generiert werden.

```bash
locale-gen
```

Nun können die locales verwendet werden.
```bash
cat <<-EOF > /etc/default/locale
LANG=en_US.UTF-8
EOF
```

```bash
update-locale
```


## Zeit
### NTP Installation

```bash
apt install ntp
```

### Zeitzone konfigurieren

```bash
dpkg-reconfigure tzdata
```


# Installation Tools
## Tmux

```bash
apt install tmux
```

## [optional] Fish Shell

Ich bevorzuge die fish Shell da diese in der default Konfiguration sehr sinnvolle Features besitzt.

```bash
apt install fish
```

```bash
chsh -s /usr/bin/fish
fish
```
