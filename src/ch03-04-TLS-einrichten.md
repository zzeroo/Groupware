# TLS einrichten

```bash
ldapsearch -Y EXTERNAL -H ldaps:/// -b "cn=config"
```


* [https://documentation.fusiondirectory.org/en/documentation/tls_support](https://documentation.fusiondirectory.org/en/documentation/tls_support)

Dateisystemberechtigungen erweitern

```bash
useradd letsencrypt
chown openldap:letsencrypt /etc/letsencrypt/ -R
usermod -a -G letsencrypt openldap
```

Activate services

```ini
# /etc/default/slapd
#SLAPD_SERVICES="ldap:/// ldapi:///"
SLAPD_SERVICES="ldap:/// ldapi:/// ldaps:///"
```

Nun informieren wir OpenLDAP wo es die Letsencrypt Certs finden kann.

```ini
# tls.ldif
dn: cn=config
changetype: modify
add: olcTLSCipherSuite
olcTLSCipherSuite: NORMAL
-
add: olcTLSCRLCheck
olcTLSCRLCheck: none
-
add: olcTLSVerifyClient
olcTLSVerifyClient: never
-
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/letsencrypt/live/mail.ra-gas.de/fullchain.pem
-
add: olcTLSCertificateFile
olcTLSCertificateFile: /etc/letsencrypt/live/mail.ra-gas.de/cert.pem
-
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/letsencrypt/live/mail.ra-gas.de/privkey.pem
-
add: olcTLSProtocolMin
olcTLSProtocolMin: 3.3
```

```bash
ldapmodify -Y EXTERNAL -H ldapi:/// -f tls.ldif
```

Nun noch ldap neu starten und den status checken

```bash
systemctl restart slapd.service
systemctl status slapd.service
```

Testen

```bash
ldapsearch -Y EXTERNAL -H ldaps:/// -b "cn=config"
```

```bash
ldapsearch -x -D "cn=admin,dc=zzeroo,dc=org" -w "secret" -H ldaps://mail.ra-gas.de/ -b dc=zzeroo,dc=org -w $PASSWORD
```
