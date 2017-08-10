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
