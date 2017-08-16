[Anleigung: "SOGo Nightly auf Debian Installieren"][sogo-nighly-on-debian]

## GPG Key importieren

```bash
apt-key adv --keyserver keys.gnupg.net --recv-key 0x810273C4
```

## https Transport für Apt

```bash
apt install apt-transport-https
```

## Apt Sources

```bash
echo "deb http://packages.inverse.ca/SOGo/nightly/3/debian/ stretch stretch" | tee /etc/apt/sources.list.d/sogo.list
```

```bash
apt update
```

## SOGo installation

Nachdem nun alle Vorbereitungen erledigt sind, kann SOGo installiert werden.

```bash
apt install sogo
```

```bash
apt install sope4.9-gdl1-postgresql
```

[sogo-nighly-on-debian]: https://sogo.nu/nc/support/faq/article/how-to-install-nightly-sogo-versions-on-debian.html
