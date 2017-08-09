# OS, System und Tools
# Vorbereitungen

Wir verwenden die `testing` Repos von Debian.

Dazu muss die Datei `sources.list` mit folgendem Inhalt überschrieben werden.

```bash
echo "deb http://cdn-aws.deb.debian.org/debian testing main contrib non-free" | tee /etc/apt/sources.list
```

Danach wird Apt und danach das System aktualisiert.

```bash
apt update
apt dist-upgrade
apt autoremove
```

# Hostname setzen

Der Hostname des Systems muss gesetzt werden. Dieser Wert wird von vielen Konfig Tools ausgelesen.

```bash
echo "mail.ra-gas.de" | tee /etc/hostname
```

# Zeit
## NTP Installation

```bash
apt install ntp
```

## Zeitzone konfigurieren

```bash
dpkg-reconfigure tzdata
```

# Installation Tools
## Tmux

```bash
apt install tmux
```

## Fish Shell

Ich bevorzuge die fish Shell da diese in der default Konfiguration sehr sinnvolle Features besitzt.

```bash
apt install fish
```

```bash
chsh -s /usr/bin/fish
fish
```

## Vim mit spf13 Addons

```bash
apt install vim-scripts curl git
```

```bash
curl http://j.mp/spf13-vim3 -L -o - | sh
```

## Rust und Tools

Rust ist meine Standardwaffe und darf auf keinen Server mehr fehlen.

```bash
apt install build-essential
```

```bash
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y
```

```bash
echo "set PATH "\$HOME/.cargo/bin" \$PATH;" >>.config/fish/config.fish
source .config/fish/config.fish
```

Zudem bringt Rust coole Tools hervor. Hier installieren wir 2 von diesen. Sie ersetzen `grep` und `find`.

```bash
# `grep` Erstaz
cargo install ripgrep
# `find` Ersatz
cargo install --git https://github.com/sharkdp/fd
```

## Fail2ban

Server sichern, siehe [https://www.thomas-krenn.com/de/wiki/SSH_Login_unter_Debian_mit_fail2ban_absichern](https://www.thomas-krenn.com/de/wiki/SSH_Login_unter_Debian_mit_fail2ban_absichern)

```bash
apt install fail2ban
```

```bash
systemctl restart fail2ban
systemctl status fail2ban
```

# Firewall konfiguration

Folgende Ports sollen von außen erreichbar sein

|Protokoll|Port|Name
|---|---:|---|
|TCP|22|ssh|
|TCP|25|smtp|
|TCP|587|smtps|
|TCP|465|smtps.old|
|TCP|80|http|
|TCP|443|https|
|TCP|110|pop3|
|TCP|995|pops|
|TCP|143|imap|
|TCP|636|ldaps|
|TCP|993|imap TLS|


# Neustart
Nach dieser Basis Konfiguration wird das System einmal neu gestartet.

```bash
reboot
```
