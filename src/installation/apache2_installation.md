# Apache2 Installation

Die Apache2 Installation ist sehr einfach.

```bash
apt install apache2
```

## Letsencrypt Certbot

Die SSL Zertifikate werden von [letsencrypt][letsencrypt] bezogen. Deren ACME Client nennt sich [`certbot`][certbot], folgender Befehl installiert dieses.

Nähere Informationen zur Installation des `certbot` gibt es [hier][certbot-installation]


```bash
apt install python-certbot-apache 
```

----

# FAQ

## Fehler: `python-certbot-apache` lässt sich nicht installieren

[https://community.letsencrypt.org/t/installing-certbot-on-debian-8-os-package-manager-not-installing-certbot/31194/17][https://community.letsencrypt.org/t/installing-certbot-on-debian-8-os-package-manager-not-installing-certbot/31194/17]

## Lösung: `python-certbot-apache` lässt sich nicht installieren

```bash
apt install python-certbot-apache -t jessie-backports
```


[letsencrypt]: https://letsencrypt.org/
[certbot]: https://certbot.eff.org
[certbot-installation]: https://certbot.eff.org/#debiantesting-apache