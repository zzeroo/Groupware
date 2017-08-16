# Konfiguration Postfix

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
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 172.31.37.176 52.28.204.86
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
virtual_mailbox_maps = ldap:/etc/postfix/ldap-accounts.cf
#virtual_alias_maps = ldap:/etc/postfix/ldap-aliases.cf ldap:/etc/postfix/ldap-forward.cf ldap:/etc/postfix/ldap-forward-only.cf

smtpd_sasl_auth_enable = yes
broken_sasl_auth_clients = yes

compatibility_level = 2
```

```conf
# /etc/postfix/ldap-accounts.cf

server_host = mail.ra-gas.de
search_base = ou=people,dc=ra-gas,dc=de
scope = sub
bind = no
version = 3
start_tls = yes

query_filter = (&(mail=%s)(objectClass=gosaMailAccount)(!(gosaMailDeliveryMode=[*I*])))
result_attribute = mail
```

```conf
#  /etc/postfix/ldap-aliases.cf
server_host = mail.ra-gas.de
search_base = ou=people,dc=ra-gas,dc=de
scope = sub
bind = no
version = 3
start_tls = yes

query_filter = (&(|(objectClass=gosaMailAccount)(objectClass=mailAliasRedirection)(objectClass=mailAliasDistribution))(|(mail=%s)(gosaMailAlternateAddress=%s)))
result_attribute = gosaMailServer,gosaMailAlternateAddress
```

```conf
# /etc/postfix/ldap-forward.cf
server_host = mail.ra-gas.de
search_base = ou=people,dc=ra-gas,dc=de
scope = sub
bind = no
version = 3
start_tls = yes

query_filter = (&(|(gosaMailAlternateAddress=%s)(mail=%s))(objectClass=gosaMailAccount)(!(gosaMailDeliveryMode=[*I*])))
result_attribute = mail,gosaMailForwardingAddress
```

```conf
# /etc/postfix/ldap-forward-only.cf
server_host = mail.ra-gas.de
search_base = ou=people,dc=ra-gas,dc=de
scope = sub
bind = no
version = 3

query_filter = (&(|(gosaMailAlternateAddress=%s)(mail=%s))(gosaMailDeliveryMode=[*I*])(objectClass=gosaMailAccount))
result_attribute = gosaMailForwardingAddress
```

## Identity Check

```conf
# /etc/postfix/identitycheck.pcre

# Identity (RegEx)              Action

/^(mail\.example\.com)$/       REJECT Hostname Abuse: $1
/^(1\.2\.3\.4)$/                REJECT Hostname Abuse: $1
/^(\[1\.2\.3\.4\])$/            REJECT Hostname Abuse: $1
```

## Blacklist File vorbereiten

```conf
# /etc/postfix/drop.cidr

# IP/CIDR                       Action

1.2.3.0/24                      REJECT Blacklisted
```

## Postfix neu starten

Das Alles sollte eine funktionierende Konfiguration ergeben. Getestet wird dies indem der postfix Server neu gestartet und anschließend sein Status geprüft wird.

```bash
systemctl restart postfix
systemctl status postfix
```


## Support für SMTPs Ports 465 und 587 aktivieren

Auf welche Ports Postfix hört kann mit folgendem Befehl geprüft werden

```bash
ss -lnptu | grep master
```

Dieser Befehl zeigt an das nur auf Port `` gehört wird (TCP/IPv4 und TCP/IPv6).
Um die SSL Ports zu aktivieren muss die Datei `/etc/postfix/master.cf` editiert werden.

Bitte `submission` und `smtps` wie folgt konfigurieren.

```conf
# /etc/postfix/master.cf

submission inet n       -       y       -       -       smtpd
  -o syslog_name=postfix/submission
  -o smtpd_tls_security_level=encrypt
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_sasl_type=dovecot
  -o smtpd_sasl_path=private/auth
  -o smtpd_relay_restrictions=permit_sasl_authenticated,reject

smtps     inet  n       -       y       -       -       smtpd
  -o syslog_name=postfix/smtps
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_sasl_type=dovecot
  -o smtpd_sasl_path=private/auth
  -o smtpd_relay_restrictions=permit_sasl_authenticated,reject
```

Nun Postfix neu starten und anschließend den Postfix Status checken

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

### Test

```bash
postmap -q s.mueller@ra-gas.de ldap:/etc/postfix/ldap-accounts.cf
```

der Test sollte folgendes Ergebnis bringen:

```result
s.mueller@ra-gas.de
```

# Links

* [Blog Post mit Postfix/ FusionDirectory LDAP][blog-mit-working-ldap]:

[blog-mit-working-ldap]: https://wikit.firewall-services.com/doku.php/tuto/fusiondirectory/postfix
