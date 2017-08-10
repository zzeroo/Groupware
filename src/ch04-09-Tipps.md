# Tipp's

## Fusion Directory Schemata auflisten

Weiter installierbare Schemata kann man mit folgendem Befehl suchen.

```bash
apt-cache search fusiondirectory-plugin
```


## Password 'fd-admin' setzen

Der Installer legt einen weiteren Benutzer 'fd-admin' im Ldap an. Dessen Password kann, wie dass aller anderer Benutzer auch mit dem Tool `ldappasswd` geändert werden.

```bash
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=fd-admin,ou=people,dc=ra-gas,dc=de
```
