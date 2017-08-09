# Vorbereitungen
## Debian Paketquellen vorbereiten (Apt sources.list)

Wir verwenden die `testing` Repos von [Debian][debian].

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
