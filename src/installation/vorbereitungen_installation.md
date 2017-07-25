# Vorbereitungen Installation

Als Erstes muss apt aktualisiert werden.

```bash
apt update
apt upgrade
```

# Hostname setzen

```bash
# /etc/hostname
mail.zzeroo.org
```

```bash
# /etc/hosts
127.0.0.1   mail.zzeroo.org   mail
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
# RELOGIN
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
echo "set -gx PATH "$HOME/.cargo/bin" $PATH;" >>.config/fish/config.fish
source .config/fish/config.fish
```

Zudem bringt Rust coole Tools hervor. Hier installieren wir 2 von diesen. Sie ersetzen `grep` und `find`.

```bash
# `grep` Erstaz
cargo install ripgrep
# `find` Ersatz
cargo install --git https://github.com/sharkdp/fd
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


## Firewall konfiguration

Folgende Ports sollen von außen erreichbar sein

|Protokoll|Port|Name
|---|---:|---|
|TCP|22|ssh|
|TCP|25|smtp|
|TCP|465|smtps|
|TCP|80|http|
|TCP|443|https|
|TCP|110|pop3|
|TCP|995|pops|
|TCP|143|imap|
|TCP|993|imaps|
|TCP|587|ldaps|


