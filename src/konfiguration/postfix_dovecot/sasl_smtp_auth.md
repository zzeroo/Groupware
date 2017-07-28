# SASL Installation für SMTP AUTH

Quelle dieser Anleitung: [https://www.theo-andreou.org/?p=1568#comment-10434](https://www.theo-andreou.org/?p=1568#comment-10434)

Im Fusion Directory muss im DSA Plugin ein Service Account "saslauthd" angelegt werden.

[![](./images/fd-dsa-saslauthd-01.png)](./images/fd-dsa-saslauthd-01.png)
[![](./images/fd-dsa-saslauthd-02.png)](./images/fd-dsa-saslauthd-02.png)
[![](./images/fd-dsa-saslauthd-03.png)](./images/fd-dsa-saslauthd-03.png)


```ini
# /etc/postfix/sasl/smtpd.conf

log_level: 3
pwcheck_method: saslauthd
mech_list: PLAIN LOGIN
```

Ersetze folgende Zeilen in `/etc/default/saslauthd`

```ini
# /etc/default/saslauthd

START=yes
MECHANISMS="ldap"
OPTIONS="-c -m /var/spool/postfix/var/run/saslauthd"
```

Erstelle die Datei `/etc/saslauthd.conf`.

```ini
# /etc/saslauthd.conf 

ldap_servers: ldap://mail.zzeroo.org:389
ldap_bind_dn: cn=saslauthd,ou=dsa,dc=zzeroo,dc=org
ldap_bind_pw: ***REMOVED***
ldap_timeout: 10
ldap_time_limit: 10
ldap_scope: sub
ldap_search_base: ou=users,dc=zzeroo,dc=org
ldap_auth_method: bind
ldap_filter: (&(uid=%u)(mail=*))
ldap_debug: 0
ldap_verbose: yes
ldap_ssl: yes
ldap_starttls: no
ldap_referrals: yes
```

Postfix User in die Gruppe `sasl` einfügen

```bash
usermod -aG sasl postfix
```

Folgende Attribute in die Datei `/etc/postfix/main.cf` einfügen

```ini
# /etc/postfix/main.cf

smtpd_sasl_auth_enable = yes
broken_sasl_auth_clients = yes
```

Die Dienste `sasld` und `postfix` neu starten und deren Status prüfen.

```bash
systemctl restart saslauthd postfix
systemctl status saslauthd postfix
```

## Test 

Zum Test wird das Tool `swaks` benötigt

```bash
apt install swaks
```

```bash
swaks --from noreply@zzeroo.org --to s.mueller@zzeroo.org --server 127.0.0.1:25 --tls --auth plain --auth-user=smueller
```




apt install mutt