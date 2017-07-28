# Benutzer und Gruppen anlegen

Datei `frontend.zzeroo.org.ldif` anlegen.

```ini
# frontend.zzeroo.org.ldif
dn: ou=people,dc=zzeroo,dc=org
objectClass: organizationalUnit
ou: users

dn: ou=groups,dc=zzeroo,dc=org
objectClass: organizationalUnit
ou: groups
```

```bash
ldapadd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// -f frontend.zzeroo.org.ldif
```

## SOGo Administrator Account

Lege eine Datei `sogo-admin.ldif` mit folgendem Inhalt an:

```ini
# sogo-admin.ldif
dn: uid=sogo,ou=people,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: sogo
cn: SOGo Administrator
mail: sogo@zzeroo.org
sn: Administrator
givenName: SOGo
```

```bash
ldapadd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// -f sogo-admin.ldif
```

Password des Benutzers setzen

```bash
ldappasswd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// uid=sogo,ou=people,dc=zzeroo,dc=org -s ***REMOVED***
```

## Benutzer anlegen

Eine Datei mit dem Namen `users.ldif` anlegen.

```ini
# users.ldif
# S. Mueller
dn: uid=smueller,ou=people,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: smueller
cn: Stefan Müller
mail: s.mueller@zzeroo.org
sn: Mueller
givenName: Stefan

# H. Kliemann
dn: uid=hkliemann,ou=people,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: hkliemann
cn: Helge Kliemann
mail: h.kliemann@zzeroo.org
sn: Kliemann
givenName: Helge

# I. Kaltenbach
dn: uid=ikaltenbach,ou=people,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: ikaltenbach
cn: Ingrid Kaltenbach
mail: i.kaltenbach@zzeroo.org
sn: Kaltenbach
givenName: Ingrid

# K. Keilhofer
dn: uid=kkeilhofer,ou=people,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: kkeilhofer
cn: Karlheinz Keilhofer
mail: k.keilhofer@zzeroo.org
sn: Keilhofer
givenName: Karlheinz

# D. Pfeiffer
dn: uid=dpfeiffer,ou=people,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: dpfeiffer
cn: Dennis Pfeiffer
mail: d.pfeiffer@zzeroo.org
sn: Pfeiffer
givenName: Dennis
```

Anschließend wird die `users.ldif` eingelesen.

```bash
ldapadd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// -f users.ldif
```


## Passworte festlegen

Die Passworte (Parameter `-s`) können jederzeit und immer wieder geändert werden. Wird der Parameter `-s` weg gelassen dann wird ein zufälliges Passwort vergeben.

```bash
ldappasswd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// uid=smueller,ou=people,dc=zzeroo,dc=org -s ***REMOVED***
ldappasswd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// uid=hkliemann,ou=people,dc=zzeroo,dc=org -s kliemann
ldappasswd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// uid=ikaltenbach,ou=people,dc=zzeroo,dc=org -s kaltenbach
ldappasswd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// uid=kkeilhofer,ou=people,dc=zzeroo,dc=org -s keilhofer
ldappasswd -x -D cn=admin,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// uid=dpfeiffer,ou=people,dc=zzeroo,dc=org -s pfeiffer
```