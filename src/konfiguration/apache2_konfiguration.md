# Apache2 Konfiguration

Nach der Installation müssen für SOGo einige Module aktiviert werden.

```bash
a2enmod proxy proxy_http proxy_http2 headers rewrite
```

## Firewall öffnen

```bash
ufw allow 80
ufw allow 443
```

## index.html anpassen

Die default index.html sollte mit custom content überschrieben werden. Sieht einfach professioneller aus als die Default Debian "Wie konfiguriere ich Apache2?" Webseite.

```bash
echo "<a href=\"https://mail.zzeroo.org/SOGo\">mail.zzeroo.org</a>">/var/www/html/index.html
```


# Letsencrypt SSL 
## certbot SSL Installation

> Prüfe das der Rechner einen gültigen DNS A Record hat!

```bash
certbot --apache --agree-tos -m co@zzeroo.com \
    -d mail.zzeroo.org \
    -d sogo.zzeroo.org \
    -d imap.zzeroo.org \
    -d smtp.zzeroo.org \
    -d mx.zzeroo.org
```


## Automatische Erneuerung via systemd Unit/ Task

Die aktuelle `certbot` Installation installiert und aktiviert alle nötigen systemd Komponenten.

```bash
systemctl status certbot.service
```

```bash
systemctl status certbot.timer
```



# Links

* [Login Amazon EC2 Console][login-amazon]
* [Login 1und1][login-1und1]

[login-amazon]:https://eu-central-1.console.aws.amazon.com
[login-1und1]:https://account.1und1.de/
