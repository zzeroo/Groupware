# Dovecot Zugriff auf LDAP userPassword

Normaler Weise erlaubt LDAP Niemanden den Zugriff auf die User Passwörter. Dovecot muss aber prüfen ob das Password des LDAP Benutzers das Passwort des Dovecot Users ist.
Dazu müssen wir dem [DSA Benutzer "dovecot"](./ch04-05-00-DSA-Benutzer-anlegen.html) den Zugriff explizit erlauben.
Quelle: [https://wiki.dovecot.org/AuthDatabase/LDAP/PasswordLookups#LDAP_server_permissions](https://wiki.dovecot.org/AuthDatabase/LDAP/PasswordLookups#LDAP_server_permissions)

Die foldende ldif löscht den ACL Eintrag `olcAccess: {0}` und erstellt ihn anschließend neu mit der Änderung das der dn "cn=dovecot,ou=dsa,dc=ra-gas,dc=de" nun `userPassword` lesen darf.

```ini
# dovecot_pass_access.ldif

dn: olcDatabase={1}mdb,cn=config
changetype: modify
delete: olcAccess
olcAccess: {0}to attrs=userPassword by self write by anonymous auth by * none
-
add: olcAccess
olcAccess: {0}to attrs=userPassword
        by dn="cn=dovecot,ou=dsa,dc=ra-gas,dc=de" read
        by self write
        by anonymous auth
        by * none
```

```bash
ldapmodify -Y EXTERNAL -H ldapi:/// -f dovecot_pass_access.ldif
```
