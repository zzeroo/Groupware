![certbot-logo](./images/certbot-logo-1A.svg)

# Installation letsencrypt Certbot

Die SSL Zertifikate werden von [letsencrypt][letsencrypt] bezogen. Deren ACME Client nennt sich [`certbot`][certbot], folgender Befehl installiert `certbot`.

> Nähere Informationen zur Installation des `certbot` gibt es [hier][certbot-installation].

```bash
apt install certbot python-certbot-apache
```

[certbot]: https://certbot.eff.org
[certbot-installation]: https://certbot.eff.org/lets-encrypt/debianbuster-apache
[letsencrypt]: https://letsencrypt.org/
