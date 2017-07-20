[Anleigung: "SOGo Nightly auf Debian Installieren"][sogo-nighly-on-debian]

## GPG Key importieren

```bash
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 0x810273C4
sudo apt-get update
```

## https Transport für Apt

```bash
sudo apt-get install apt-transport-https
```

## Apt Sources

```bash
echo "deb http://packages.inverse.ca/SOGo/nightly/3/debian/ jessie jessie" | sudo tee /etc/apt/sources.list.d/sogo.list
```

## SOGo installation

Nachdem nun alle Vorbereitungen erledigt sind, kann SOGo installiert werden.

```bash
sudo apt-get update
sudo apt-get install sogo
```

```bash
sudo apt-get install sope4.9-gdl1-postgresql
```

[sogo-nighly-on-debian]: https://sogo.nu/nc/support/faq/article/how-to-install-nightly-sogo-versions-on-debian.html
