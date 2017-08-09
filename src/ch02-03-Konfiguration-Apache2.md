# Konfiguration Apache2

Nach der Installation müssen für SOGo einige Module aktiviert werden.

```bash
a2enmod proxy proxy_http proxy_http2 headers rewrite
```


## index.html anpassen

Die default index.html sollte mit eigenem Inhalt überschrieben werden. Das sieht einfach professioneller aus als die Default Debian "Wie konfiguriere ich Apache2?" Webseite.

```bash
echo "<a href=\"https://mail.ra-gas.de/SOGo\">mail.ra-gas.de</a>">/var/www/html/index.html
```
