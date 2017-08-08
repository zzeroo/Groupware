# TLS Setup

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
olcTLSCACertificateFile: /etc/letsencrypt/live/mail.zzeroo.org/fullchain.pem
-
add: olcTLSCertificateFile
olcTLSCertificateFile: /etc/letsencrypt/live/mail.zzeroo.org/cert.pem
-
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/letsencrypt/live/mail.zzeroo.org/privkey.pem
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
ldapsearch -x -D "cn=admin,dc=zzeroo,dc=org" -w "secret" -H ldaps://mail.zzeroo.org/ -b dc=zzeroo,dc=org -w $PASSWORD
```


----

# FAQ

## Fehler: `ldap_modify: Other (e.g., implementation specific) error (80)`

```bash
# ldapmodify -Y EXTERNAL -H ldapi:/// -f tls.ldif 
SASL/EXTERNAL authentication started
SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
SASL SSF: 0
modifying entry "cn=config"
ldap_modify: Other (e.g., implementation specific) error (80)
```

## Lösung: `ldap_modify: Other (e.g., implementation specific) error (80)`

Die Dateisystemberechtigungen stimmten nicht. Bitte unbedingt folgende Befehle auführen.

```bash
useradd letsencrypt
chown openldap:letsencrypt /etc/letsencrypt/ -R
usermod -a -G letsencrypt openldap
```



ldapsearch -D "cn=saslauthd,ou=dsa,dc=zzeroo,dc=org" -w hackthor -H ldap://mail.zzeroo.org -b "ou=people,dc=zzeroo,dc=org" ¨CZZ
