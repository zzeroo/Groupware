# Dovecot Konfiguration

Quelle dieser Anleitung: [https://www.theo-andreou.org/?p=1568#comment-10434](https://www.theo-andreou.org/?p=1568#comment-10434)

Im Fusion Directory muss im DSA Plugin ein Service Account "dovecot" angelegt werden.

[![](./images/fd-dsa-dovecot-01.png)](./images/fd-dsa-dovecot-01.png)
[![](./images/fd-dsa-dovecot-02.png)](./images/fd-dsa-dovecot-02.png)
[![](./images/fd-dsa-dovecot-03.png)](./images/fd-dsa-dovecot-03.png)

## SSL Parameter

```ini
# /etc/dovecot/conf.d/10-ssl.conf 
ssl = required

ssl_cert = </etc/letsencrypt/live/mail.zzeroo.org/cert.pem
ssl_key = </etc/letsencrypt/live/mail.zzeroo.org/privkey.pem
```

## Authentication 

```ini
# /etc/dovecot/conf.d/10-auth.conf

disable_plaintext_auth = yes
auth_mechanisms = plain login
!include auth-ldap.conf.ext
```

## LDAP

```ini
# /etc/dovecot/dovecot-ldap.conf.ext

uris = ldap://mail.zzeroo.org
dn = cn=dovecot,ou=dsa,dc=zzeroo,dc=org
dnpass = $PASSWORD
tls = yes
tls_ca_cert_file = /etc/letsencrypt/live/mail.zzeroo.org/fullchain.pem
tls_require_cert = demand
ldap_version = 3
base = ou=users,dc=zzeroo,dc=org
user_attrs = =mail=maildir:/srv/vmail/%{ldap:mail}/Maildir
user_filter = (&(objectClass=gosaMailAccount)(uid=%n))
pass_attrs = uid=user,userPassword=password
pass_filter = (&(objectClass=gosaMailAccount)(uid=%n))
default_pass_scheme = SSHA
```

## Logging

```ini
# /etc/dovecot/conf.d/10-logging.conf

log_path = syslog
syslog_facility = mail
auth_verbose = yes
auth_verbose_passwords = no
auth_debug = no
auth_debug_passwords = no
mail_debug = no
verbose_ssl = no
```

## Maildir konfigurieren

Folgende Zeilen eintragen. Der User (vmail) mit der UserID 5000 wird gleich erstellt.

```ini
# /etc/dovecot/conf.d/10-mail.conf

mail_uid = 5000
mail_uid = 5000
``

## Dienste Konfigurieren

```ini
# /etc/dovecot/conf.d/10-master.conf

service imap-login {
  inet_listener imap {
    port = 143
  }
  inet_listener imaps {
    port = 993
    ssl = yes
  }
}


service pop3-login {
  inet_listener pop3 {
    port = 110
  }
  inet_listener pop3s {
    port = 995
    ssl = yes
  }
}


service auth {
  unix_listener auth-userdb {
    mode = 0777
    user = dovecot
    group = dovecot
  }
}
```

## `vmail` Benutzer anlegen

```bash
addgroup --system --gid 5000 vmail
adduser --system --home /srv/vmail --uid 5000 --gid 5000 --disabled-password --disabled-login vmail
```

## Finish

Dies sollte nun wieder eine funktionierende Konfiguration ergeben. Getestet wird dies indem der dovecot Server neu gestartet wird und anschließend sein Status geprüft wird.

```bash
systemctl restart dovecot
systemctl status dovecot
```


### Ports checken

```bash
netstat -lnptu | grep dovecot
```

sollte in Etwa so aussehen:

```bash
tcp        0      0 0.0.0.0:993             0.0.0.0:*               LISTEN      32439/dovecot   
tcp        0      0 0.0.0.0:995             0.0.0.0:*               LISTEN      32439/dovecot   
tcp        0      0 0.0.0.0:110             0.0.0.0:*               LISTEN      32439/dovecot   
tcp        0      0 0.0.0.0:143             0.0.0.0:*               LISTEN      32439/dovecot   
tcp6       0      0 :::993                  :::*                    LISTEN      32439/dovecot   
tcp6       0      0 :::995                  :::*                    LISTEN      32439/dovecot   
tcp6       0      0 :::110                  :::*                    LISTEN      32439/dovecot   
tcp6       0      0 :::143                  :::*                    LISTEN      32439/dovecot 
```

### Login checken

```bash
openssl s_client -connect localhost:993
```

## Postfix -> Dovecot Konfiguration

Postfix muss nun mitgeteilt werden das er dovecot verwenden soll.

Am Ende der Datei `/etc/postfix/master.cf` folgenden Eintrag einfügen

```ini
# /etc/postfix/master.cf

dovecot   unix  -       n       n       -       -       pipe
  flags=ODRhu user=vmail:vmail argv=/usr/lib/dovecot/deliver -e -f ${sender} -d ${recipient}
```

Außerdem muss die `/etc/postfix/main.cf` um folgende Attribute ergänzt werden:

```ini
# /etc/postfix/main.cf

virtual_transport = dovecot
dovecot_destination_recipient_limit = 1
```



```bash
systemctl restart dovecot
systemctl status dovecot
```
