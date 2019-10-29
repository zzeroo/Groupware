# OS, System und Tools
## Hostname setzen

Der Hostname des Systems muss gesetzt werden. Dieser Wert wird von vielen Konfig Tools ausgelesen.

```bash
echo "sogo.ra-gas.de" | tee /etc/hostname
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
