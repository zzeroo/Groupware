# Dovecot Zugriff auf userPassword

Quelle: [https://wiki.dovecot.org/AuthDatabase/LDAP/PasswordLookups#LDAP_server_permissions](https://wiki.dovecot.org/AuthDatabase/LDAP/PasswordLookups#LDAP_server_permissions)

Die foldende ldif löscht den ACL Eintrag `olcAccess: {0}` und erstellt ihn anschließend neu mit der Änderung das der dn "cn=dovecot,ou=dsa,dc=ra-gas,dc=de" lesen darf.

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