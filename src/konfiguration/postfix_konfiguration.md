# Postfix Konfiguration

Die Postfix Konfigurationsdatei ist unter `/etc/postfix/main.cf` zu finden.

Man kann diese Datei einfach mit einem Editor öffnen, oder noch einfacher, das Postfix Tool `postconf` verwenden. `postconf` ändert die Zeilen wenn diese schon in der `/etc/postfix/main.cf` vorhanden sind, oder fügt neue Zeilen in `/etc/postfix/main.cf` ein wenn das nötig ist.

## Domain anlegen

```bash
postconf -e "mydomain = ra-gas.de"
postconf -e "myorigin = \$mydomain"
```

## Maildir konfigurieren

Da wir auch Dovecot einsetzen muss die Mailbox konfiguriert konfiguriert werden.

```bash
postconf -e "home_mailbox = Maildir/"
postconf -e "mailbox_command ="
```

## SASL Parameter

```bash
postconf -e "smtpd_sasl_type = dovecot"
postconf -e "smtpd_sasl_path = private/auth"
postconf -e "smtpd_sasl_auth_enable = yes"
```

## TLS Parameter

```bash
postconf -e "smtpd_tls_auth_only = no"
postconf -e "smtpd_use_tls = yes"
postconf -e "smtp_use_tls = yes"
postconf -e "smtp_tls_note_starttls_offer = yes"
postconf -e "smtpd_tls_key_file = /etc/letsencrypt/live/mail.ra-gas.de/privkey.pem"
postconf -e "smtpd_tls_cert_file = /etc/letsencrypt/live/mail.ra-gas.de/cert.pem"
postconf -e "smtpd_tls_loglevel = 1"
postconf -e "smtpd_tls_received_header = yes"
postconf -e "smtpd_tls_session_cache_timeout = 3600s"
```

Dies sollte eine funktionierende Konfiguration ergeben. Getestet wird dies indem der postfix Server neu gestartet wird und anschließend sein Status geprüft wird.

```bash
systemctl restart postfix
systemctl status postfix
```

Meine komplette `/etc/postfix/main.cf` sieht nun so aus:

```ini
# cat /etc/postfix/main.cf | egrep -v "(^#.*|^\$)"
smtpd_banner = $myhostname ESMTP $mail_name (Debian/GNU)
biff = no
append_dot_mydomain = no
readme_directory = no
compatibility_level = 2
smtpd_tls_cert_file = /etc/letsencrypt/live/mail.ra-gas.de/cert.pem
smtpd_tls_key_file = /etc/letsencrypt/live/mail.ra-gas.de/privkey.pem
smtpd_use_tls = yes
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
myhostname = ra-gas.de
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
myorigin = $mydomain
mydestination = $myhostname, mail.ra-gas.de, ra-gas.de, localhost.gaswarnanlagen.lan, localhost
relayhost = 
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
mailbox_command = 
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = all
mydomain = ra-gas.de
home_mailbox = Maildir/
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
smtpd_tls_auth_only = no
smtp_use_tls = yes
smtp_tls_note_starttls_offer = yes
smtpd_tls_loglevel = 1
smtpd_tls_received_header = yes
smtpd_tls_session_cache_timeout = 3600s
```

# Dovecot Konfiguration

## SSL Parameter

```ini
# /etc/dovecot/conf.d/10-ssl.conf 
ssl = required

ssl_cert = </etc/letsencrypt/live/mail.ra-gas.de/cert.pem
ssl_key = </etc/letsencrypt/live/mail.ra-gas.de/privkey.pem
```

## Authentication 

Die Zeile `disable_plaintext_auth = yes` aktivieren

```ini
# /etc/dovecot/conf.d/10-auth.conf
disable_plaintext_auth = yes
```

## Postfix aktivieren

Den Abschnitt `unix_listener` finden, aktivieren und um `user` und `group` ergänzen.

```ini
# /etc/dovecot/conf.d/10-master.conf

  # Postfix smtp-auth
  unix_listener /var/spool/postfix/private/auth {
    mode = 0666
    user = postfix
    group = postfix
  }
```

## Maildir konfigurieren

In der Datei `/etc/dovecot/conf.d/10-mail.conf` muss die `mail_location` geändert werden.

```ini
# /etc/dovecot/conf.d/10-mail.conf
#mail_location = mbox:~/mail:INBOX=/var/mail/%u
mail_location = maildir:~/Maildir
```

Außerdem muss noch die `mail_privileged_group` nach `mail` geändert werden, um Zugriff auf `/var/mail` zu erhalten.

```ini
# /etc/dovecot/conf.d/10-mail.conf
mail_privileged_group = mail
```

Dies sollte nun wieder eine funktionierende Konfiguration ergeben. Getestet wird dies indem der dovecot Server neu gestartet wird und anschließend sein Status geprüft wird.

```bash
systemctl restart dovecot
systemctl status dovecot
```

