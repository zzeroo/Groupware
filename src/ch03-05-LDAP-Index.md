# LDAP Index

```ini
# olcDbIndex.ldif

dn: olcDatabase={1}mdb,cn=config
changetype: modify
add: olcDbIndex
olcDbIndex: sn pres,sub,eq
-
add: olcDbIndex
olcDbIndex: displayName pres,sub,eq
-
add: olcDbIndex
olcDbIndex: default sub
-
add: olcDbIndex
olcDbIndex: mail,givenName eq,subinitial
-
add: olcDbIndex
olcDbIndex: dc eq
```

Anschließend wieder mit `ldapmodify` einlesen.

```bash
ldapmodify -Y EXTERNAL -H ldapi:/// -f olcDbIndex.ldif
```

Prüfen kann man das wieder mit dem Befehl:

```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b "cn=config"
```
