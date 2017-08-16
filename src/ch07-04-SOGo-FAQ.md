# SOGo FAQ

Hier folgt eine Liste mit einigen Fehler die wärend der Installation/ Konfiguration von SOGo gemeldet wurden.

## Fehler: `ERROR: Conf SOGo does not exist!`

Dieser Fehler tritt bei debian 9 (buster) Installationen, via `apt install sogo` auf. Die Ursache ist das die SOGo Apache2 Konfiguraion nicht unter `/etc/apache2/conf-available/SOGo.conf` erstellt wurde, sie ist vielmehr unter `/etc/apache2/conf.d/SOGo.conf` zu finden.

## Lösung: `ERROR: Conf SOGo does not exist!`

```bash
mv /etc/apache2/conf.d/SOGo.conf /etc/apache2/conf-available/SOGo.conf
```

Anschließend kann diese Konfiguration aktiviert werden. Apache2 muss mit dem `reload` Befehl mitgeteilt werden das er die Konfiguration neu lesen soll.

```conf
a2enconf SOGo
systemctl reload apache2
```


## Fehler: SOGo Website nicht erreichbar

Unter der SOGo Url war keine Webseite erreichbar.

## Lösung: SOGo Website nicht erreichbar

Auf einer Debian Jessie Installation musste die Apache2 SOGo Konfig von Hand aktiviert werden.

```bash
a2enconf SOGo
systemctl reload apache2
```

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
