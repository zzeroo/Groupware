# Konfiguration Apache2

Nach der Installation müssen für SOGo einige Module aktiviert werden.

```bash
a2enmod proxy proxy_http proxy_http2 headers rewrite
```

Anschließend kann der `apache2` neu gestartet werden.

```bash
systemctl restart apache2
```


## index.html anpassen

Die default index.html sollte mit eigenem Inhalt überschrieben werden.

```bash
echo "<a href=\"https://mail.ra-gas.de/SOGo\">mail.ra-gas.de</a>">/var/www/html/index.html
```
