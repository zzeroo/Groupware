[Anleigung: "SOGo Nightly auf Debian Installieren"][sogo-nighly-on-debian]

## GPG Key importieren

```bash
apt install dirmngr
apt-key adv --keyserver keys.gnupg.net --recv-key 0x810273C4
apt update
```

## https Transport für Apt

```bash
apt install apt-transport-https
```

## Apt Sources

```bash
echo "deb http://packages.inverse.ca/SOGo/nightly/3/debian/ jessie jessie" | sudo tee /etc/apt/sources.list.d/sogo.list
```

## SOGo installation

Nachdem nun alle Vorbereitungen erledigt sind, kann SOGo installiert werden.

```bash
apt update
apt install sogo
```

```bash
apt install sope4.9-gdl1-postgresql
```

[sogo-nighly-on-debian]: https://sogo.nu/nc/support/faq/article/how-to-install-nightly-sogo-versions-on-debian.html


# FAQ

# Fehler `gpg: keyserver receive failed: No dirmngr`

Beim Befehl `/var/src/SogoInstallation/src/installation/sogo_installation.md` auf einer Amazon AWS Debian 9 Instanz, erschien folgender Fehler:

```bash
# apt-key adv --keyserver keys.gnupg.net --recv-key 0x810273C4
Executing: /tmp/apt-key-gpghome.dzxlGfM8pF/gpg.1.sh --keyserver keys.gnupg.net --recv-key 0x810273C4
gpg: failed to start the dirmngr '/usr/bin/dirmngr': No such file or directory
gpg: connecting dirmngr at '/tmp/apt-key-gpghome.dzxlGfM8pF/S.dirmngr' failed: No such file or directory
gpg: keyserver receive failed: No dirmngr
```

# Lösung `gpg: keyserver receive failed: No dirmngr`

Einfach `dirmngr` nachinstallieren.

```bash
apt install dirmngr
```