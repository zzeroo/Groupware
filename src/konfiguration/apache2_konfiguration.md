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
certbot --apache -d mail.zzeroo.org -d sogo.zzeroo.org -d imap.zzeroo.org -d smtp.zzeroo.org -d mx.zzeroo.org
```

## certbot Renew Tasks via systemd

* [https://wiki.archlinux.org/index.php/Let%E2%80%99s_Encrypt#systemd](https://wiki.archlinux.org/index.php/Let%E2%80%99s_Encrypt#systemd)

### systemd certbot Update Service

```ini
# /etc/systemd/system/certbot.service
[Unit]
Description=Let's Encrypt renewal

[Service]
Type=oneshot
ExecStart=/usr/bin/certbot renew --quiet --agree-tos
ExecStartPost=/bin/systemctl reload apache2.service
```

### systemd certbot Update Timer

```ini
# /etc/systemd/system/certbot.timer
[Unit]
Description=Twice daily renewal of Let's Encrypt's certificates

[Timer]
OnCalendar=0/12:00:00
RandomizedDelaySec=1h
Persistent=true

[Install]
WantedBy=timers.target
```

### Teste den Update Service

```bash
systemctl restart certbot.service
systemctl status certbot.service
```

### Aktiviere und starte den Update Timer

```bash
systemctl enable certbot.timer
systemctl start certbot.timer
systemctl status certbot.timer
```


# Links

* [Login Amazon EC2 Console][login-amazon]
* [Login 1und1][login-1und1]

[login-amazon]:https://eu-central-1.console.aws.amazon.com
[login-1und1]:https://account.1und1.de/
