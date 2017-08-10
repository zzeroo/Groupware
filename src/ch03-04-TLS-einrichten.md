# TLS einrichten

Wenn wir versuchen über den SSL Port "ldaps://" eine Verbindung herzustellen, dann scheitert dies. 

```bash
ldapsearch -x -D "cn=admin,dc=ra-gas,dc=de" -w $PASSWORD -H ldaps://mail.ra-gas.de/ -b dc=ra-gas,dc=de
```
* [https://documentation.fusiondirectory.org/en/documentation/tls_support](https://documentation.fusiondirectory.org/en/documentation/tls_support)

Zuerst müssen wir einen gemeinsamen Benutzer und Gruppe (`letsencrypt`) anlegen und einige Dateisystemberechtigungen erweitern. Der letzte Befehl fügt den Benutzer `openldap` der Gruppe `letsencrypt` hinzu.

```bash
useradd letsencrypt
chown openldap:letsencrypt /etc/letsencrypt/ -R
usermod -a -G letsencrypt openldap
```

Dann muss der SSL Port des `slapd` Dienstes aktiviert werden.

```ini
# /etc/default/slapd
#SLAPD_SERVICES="ldap:/// ldapi:///"
SLAPD_SERVICES="ldap:/// ldapi:/// ldaps:///"
```

Nun informieren wir OpenLDAP wo es die Letsencrypt Zertifikate finden kann.

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

Dann wird der OpenLDAP Dienst `slapd` neu gestartet und dessen Zustand geprüft.

```bash
systemctl restart slapd.service
systemctl status slapd.service
```

## Test

Jetzt funktioniert der Befehl von Oben. Wir "binden" gegen den admin mit unserem OpenLDAP Password.

```bash
ldapsearch -x -D "cn=admin,dc=ra-gas,dc=de" -w $PASSWORD -H ldaps://mail.ra-gas.de/ -b dc=ra-gas,dc=de
```
