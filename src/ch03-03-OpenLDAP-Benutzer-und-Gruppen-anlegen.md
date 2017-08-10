# Benutzer und Gruppen anlegen

Datei `frontend.ra-gas.de.ldif` anlegen.

```ini
# frontend.ra-gas.de.ldif
dn: ou=people,dc=ra-gas,dc=de
objectClass: organizationalUnit
ou: users

dn: ou=groups,dc=ra-gas,dc=de
objectClass: organizationalUnit
ou: groups
```

```bash
ldapadd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// -f frontend.ra-gas.de.ldif
```

## SOGo Administrator Account

Lege eine Datei `sogo-admin.ldif` mit folgendem Inhalt an:

```ini
# sogo-admin.ldif
dn: uid=sogo,ou=people,dc=ra-gas,dc=de
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: sogo
cn: SOGo Administrator
mail: sogo@ra-gas.de
sn: Administrator
givenName: SOGo
```

```bash
ldapadd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// -f sogo-admin.ldif
```

Password des Benutzers setzen

> **Tipp**, wenn der letzte Parameter `-s` mit dem Password weg gelassen wird. Dann wird ein zufälliges Password vergeben und auf der Console ausgegeben. Probiert es einfach aus. Der Befehl kann beliebig oft wiederholt werden, ein Password soll ja oft geändert werden.

```bash
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=sogo,ou=people,dc=ra-gas,dc=de -s $PASSWORD
```

## Benutzer anlegen

Eine Datei mit dem Namen `users.ldif` anlegen.

```ini
# users.ldif
# S. Mueller
dn: uid=smueller,ou=people,dc=ra-gas,dc=de
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: smueller
cn: Stefan Müller
mail: s.mueller@ra-gas.de
sn: Mueller
givenName: Stefan

# H. Kliemann
dn: uid=hkliemann,ou=people,dc=ra-gas,dc=de
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: hkliemann
cn: Helge Kliemann
mail: h.kliemann@ra-gas.de
sn: Kliemann
givenName: Helge

# I. Kaltenbach
dn: uid=ikaltenbach,ou=people,dc=ra-gas,dc=de
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: ikaltenbach
cn: Ingrid Kaltenbach
mail: i.kaltenbach@ra-gas.de
sn: Kaltenbach
givenName: Ingrid

# K. Keilhofer
dn: uid=kkeilhofer,ou=people,dc=ra-gas,dc=de
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: kkeilhofer
cn: Karlheinz Keilhofer
mail: k.keilhofer@ra-gas.de
sn: Keilhofer
givenName: Karlheinz

# D. Pfeiffer
dn: uid=dpfeiffer,ou=people,dc=ra-gas,dc=de
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: dpfeiffer
cn: Dennis Pfeiffer
mail: d.pfeiffer@ra-gas.de
sn: Pfeiffer
givenName: Dennis
```

Anschließend wird die `users.ldif` eingelesen.

```bash
ldapadd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// -f users.ldif
```


## Passworte festlegen

> Auch hier gilt, wird der Parameter `-s` weg gelassen dann wird ein zufälliges Passwort gesetzt und auf der Console ausgegeben.

```bash
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=smueller,ou=people,dc=ra-gas,dc=de -s $PASSWORD
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=hkliemann,ou=people,dc=ra-gas,dc=de -s $PASSWORD
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=ikaltenbach,ou=people,dc=ra-gas,dc=de -s $PASSWORD
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=kkeilhofer,ou=people,dc=ra-gas,dc=de -s $PASSWORD
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=dpfeiffer,ou=people,dc=ra-gas,dc=de -s $PASSWORD
```
