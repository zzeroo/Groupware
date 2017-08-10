# Postfix/ Dovecot Konfiguration

Im Fusion Directory muss im DSA Plugin ein DSA (Domain Service Account) "postfix" angelegt werden.

[![](./images/fd-dsa-postfix-01.png)](./images/fd-dsa-postfix-01.png)
[![](./images/fd-dsa-postfix-02.png)](./images/fd-dsa-postfix-02.png)
[![](./images/fd-dsa-postfix-03.png)](./images/fd-dsa-postfix-03.png)

Die Postfix Konfigurationsdatei ist unter `/etc/postfix/main.cf` zu finden.

Man kann diese Datei einfach mit einem Editor öffnen, oder noch einfacher, das Postfix Tool `postconf` verwenden. `postconf` ändert die Zeilen wenn diese schon in der `/etc/postfix/main.cf` vorhanden sind, oder fügt neue Zeilen in `/etc/postfix/main.cf` ein wenn das nötig ist.

Da wir die Komplette Konfig überschreiben beginnen wir mit einer kompletten `main.cf`.

```bash
# /etc/postfix/main.cf

smtpd_banner = $myhostname ESMTP $mail_name
biff = no
append_dot_mydomain = no
readme_directory = no
smtpd_tls_cert_file=/etc/letsencrypt/live/mail.ra-gas.de/cert.pem
smtpd_tls_key_file=/etc/letsencrypt/live/mail.ra-gas.de/privkey.pem
smtpd_use_tls=yes
smtpd_tls_security_level = may
smtpd_tls_auth_only = yes
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache
smtpd_tls_dh512_param_file = ${config_directory}/certs/dh_512.pem
smtpd_tls_dh1024_param_file = ${config_directory}/certs/dh_1024.pem
tls_random_source = dev:/dev/urandom
smtpd_tls_loglevel = 0
smtpd_client_new_tls_session_rate_limit = 10
smtpd_tls_exclude_ciphers =
    EXP
    EDH-RSA-DES-CBC-SHA
    ADH-DES-CBC-SHA
    DES-CBC-SHA
    SEED-SHA
    aNULL
    eNULL
    EXPORT
    DES
    RC4
    MD5
    PSK
    aECDH
    EDH-DSS-DES-CBC3-SHA
    KRB5-DES-CBC3-SHA
myhostname = mail.ra-gas.de
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
myorigin = /etc/mailname
mydestination = localhost.localdomain, localhost
relayhost =
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = all
local_transport = local
postscreen_greet_action = enforce
smtpd_recipient_restrictions =
    permit_mynetworks
    permit_sasl_authenticated
    warn_if_reject reject_non_fqdn_hostname
    warn_if_reject reject_non_fqdn_sender
    reject_invalid_hostname
    reject_unknown_sender_domain
    reject_unverified_recipient
    reject_unauth_destination
    reject_non_fqdn_sender
    reject_non_fqdn_recipient
    reject_non_fqdn_helo_hostname
    check_sender_ns_access cidr:/etc/postfix/drop.cidr
    check_sender_mx_access cidr:/etc/postfix/drop.cidr
    reject_rbl_client bl.spamcop.net,
    reject_rbl_client cbl.abuseat.org
    reject
smtpd_data_restrictions = reject_multi_recipient_bounce
smtpd_sender_restrictions =
    reject_non_fqdn_sender
    reject_unknown_sender_domain
smtpd_helo_restrictions =
    permit_mynetworks
    check_helo_access pcre:/etc/postfix/identitycheck.pcre
    reject_invalid_helo_hostname
disable_vrfy_command = yes
smtpd_helo_required = yes
smtpd_delay_reject = no
smtpd_client_restrictions = check_client_access cidr:/etc/postfix/drop.cidr
message_size_limit = 51200000

virtual_transport = dovecot
dovecot_destination_recipient_limit = 1

virtual_mailbox_domains = ra-gas.de
virtual_mailbox_maps = hash:/etc/postfix/vmailbox
virtual_alias_maps = hash:/etc/postfix/virtual
```

```conf
# /etc/postfix/vmailbox

# Domain                Anything
ra-gas.de          whatever
zzeroo.com          whatever
serversonfire.de    whatever
```

```conf
# /etc/postfix/virtual
postmaster@ra-gas.de postmaster
```

```conf
postmap /etc/postfix/virtual
```

```conf
postmap /etc/postfix/vmailbox
```

```conf
systemctl reload postfix
```



----


```conf
# /etc/postfix/ldap_virtual_recipients.cf

bind = yes
bind_dn = cn=postfix,ou=dsa,dc=ra-gas,dc=de
bind_pw = $PASSWORD
server_host = ldap://mail.ra-gas.de:389
search_base = ou=people,dc=ra-gas,dc=de
domain = ra-gas.de
query_filter = (mail=%s)
result_attribute = mail
start_tls = yes
version = 3
```

Virtuelle Aliase vorbereiten ...

```conf
# /etc/postfix/ldap_virtual_aliases.cf

bind = yes
bind_dn = cn=postfix,ou=dsa,dc=ra-gas,dc=de
bind_pw = $PASSWORD
server_host = ldap://mail.ra-gas.de:389
search_base = ou=alias,dc=ra-gas,dc=de
domain = ra-gas.de
query_filter = (mail=%s)
result_attribute = gosaMailAlternateAddress, gosaMailForwardingAddress
start_tls = yes
version = 3
```

Identity Check vorbereiten

```conf
# /etc/postfix/identitycheck.pcre

# Identity (RegEx)              Action

/^(mail\.example\.com)$/       REJECT Hostname Abuse: $1
/^(1\.2\.3\.4)$/                REJECT Hostname Abuse: $1
/^(\[1\.2\.3\.4\])$/            REJECT Hostname Abuse: $1
```

Blacklist File vorbereiten

```conf
# /etc/postfix/drop.cidr

# IP/CIDR                       Action

1.2.3.0/24                      REJECT Blacklisted
```

virtual domains hashmap erstellen

```bash
postmap hash:/etc/postfix/virtual_domains
```

Das Alles sollte eine funktionierende Konfiguration ergeben. Getestet wird dies indem der postfix Server neu gestartet und anschließend sein Status geprüft wird.

```bash
systemctl restart postfix
systemctl status postfix
```

Auf welche Ports Postfix hört kann mit folgendem Befehl geprüft werden

```bash
ss -lnptu | grep master
```

## Support für SMTPs Ports 465 und 587 aktivieren

Dazu die Datei `/etc/postfix/master.cf` editieren und die beiden folgenden Zeilen entkommentieren.

```conf
# /etc/postfix/master.cf

submission inet n       -       -       -       -       smtpd
smtps     inet  n       -       -       -       -       smtpd
```

Nun wieder postfix neu starten und Status checken

```bash
systemctl restart postfix
systemctl status postfix
```

Der folgende Befehl sollte nun die Ports 465 und 587 listen

```bash
ss -lnptu | grep master
```

## perfect forward secrecy

```bash
mkdir /etc/postfix/certs
cd /etc/postfix/certs
openssl dhparam -2 -out dh_512.pem 512
openssl dhparam -2 -out dh_1024.pem 1024
chmod 600 dh_*
```

Test

```bash
postmap -q s.mueller@ra-gas.de ldap:/etc/postfix/ldap_virtual_recipients.cf 
```

der Test sollte folgendes Ergebnis bringen:

```result
s.mueller@ra-gas.de
```

