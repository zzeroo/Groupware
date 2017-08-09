# letsencrypt SSL
## SSL Zertifikate via certbot beantragen.

> Prüfe das der Rechner einen gültigen DNS A Record hat!
>
> Das sollte schon [vor einigen Kapiteln](./ch01-01-Vorbereitungen-DNS.html) erledigt wurden sein. Aber dennoch muss jetzt ein `dig` auf die Domainnamen, die richtigen IP Adressen, für die A/AAAA Records, liefern. **Den folgenden Befehl bitte auf einem Rechner mit installiertem `dig` Programm ausführen!**
>
> ```bash
> dig \
>  mail.ra-gas.de \
>  sogo.ra-gas.de \
>  imap.ra-gas.de \
>  smtp.ra-gas.de \
>  ldap.ra-gas.de \
>  db.ra-gas.de   \
>  mx.ra-gas.de | grep ";; ANSWER SECTION:" -A1
> ```

Certbot verbindet sich über das ACME2 Protokoll zur letsencrypt CA und beantragt dort die SSL Zertifikate. Die CA prüft durch geziehlte Rückfragen an unseren Rechner ob wir der Besitzer der Domains sind.

```bash
certbot --apache --agree-tos -m co@zzeroo.com \
    -d mail.ra-gas.de \
    -d sogo.ra-gas.de \
    -d imap.ra-gas.de \
    -d smtp.ra-gas.de \
    -d ldap.ra-gas.de \
    -d db.ra-gas.de   \
    -d mx.ra-gas.de
```


## Automatische Erneuerung der Zertifikate via systemd Unit/ Task

Die aktuelle [`certbot`][certbot] Installation installiert und aktiviert alle nötigen systemd Komponenten, die so genannten Units. Mit den folgenden Befehlen kann geprüft werden das diese auch korrekt funktionieren.

```bash
systemctl status certbot.service
```

```bash
systemctl status certbot.timer
```

[letsencrypt]: https://letsencrypt.org
[letsencrypt-manual]: https://letsencrypt.org/getting-started/
[certbot]: https://certbot.eff.org/
