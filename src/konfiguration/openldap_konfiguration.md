# OpenLDAP Konfiguration

[Debian Wiki OpenLDAP Setup][debian-wiki-openldap-setup]

Bei der OpenLDAP Installation wurde nur nach dem LDAP Password gefragt. Eine Vollständige Konfiguration kann mit folgendem Befehl gestartet werden.

```bash
dpkg-reconfigure -plow slapd
```

Die Konfigruation kann mit diesem Befehl geprüft werden:

```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b "cn=config" 
```

## SOGo Konfiguration

```conf
# /etc/sogo/sogo.conf

  SOGoUserSources = ( 
    {
      type = ldap;
      CNFieldName = cn; 
      UIDFieldName = uid;
      IDFieldName = uid; // first field of the DN for direct binds
      bindFields = (uid, mail); // array of fields to use for indirect binds
      baseDN = "ou=Users,dc=sogo,dc=zzeroo,dc=org";
      bindDN = "uid=sogo,ou=Users,dc=sogo,dc=zzeroo,dc=org";
      bindPassword = ***REMOVED***;
      canAuthenticate = YES;
      displayName = "Shared Addresses";
      hostname = ldap://127.0.0.1:389;
      id = public;
      isAddressBook = YES;
    }
  );
```

## Users und Groups anlegen

Datei `frontend.sogo.zzeroo.org.ldif` anlegen.

```bash
dn: ou=Users,dc=sogo,dc=zzeroo,dc=org
objectClass: organizationalUnit
ou: Users

dn: ou=Groups,dc=sogo,dc=zzeroo,dc=org
objectClass: organizationalUnit
ou: Groups
```

```bash
ldapadd -f frontend.sogo.zzeroo.org.ldif -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org
```

## Benutzer hinzufügen
### SOGo Administrator Account

Lege eine Datei `sogo.ldif` mit folgendem Inhalt an:

```ldif
dn: uid=sogo,ou=Users,dc=sogo,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: sogo
cn: SOGo Administrator
mail: sogo@zzeroo.com
sn: Administrator
givenName: SOGo
```

```bash
ldapadd -f sogo.ldif -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org
```

Password des Benutzers setzen

```bash
ldappasswd -h 127.0.0.1 -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org uid=sogo,ou=Users,dc=sogo,dc=zzeroo,dc=org -s ***REMOVED***
```

### Normale SOGo User

smueller.ldif
```ldif
dn: uid=smueller,ou=Users,dc=sogo,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: smueller
cn: Stefan Müller
mail: smueller@zzeroo.org
sn: Mueller
givenName: Stefan
```

```bash
ldapadd -f smueller.ldif -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org
```

Password des Benutzers setzen

```bash
ldappasswd -h 127.0.0.1 -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org uid=smueller,ou=Users,dc=sogo,dc=zzeroo,dc=org -s ***REMOVED***
```

## KLS Benutzer anlegen


```bash
# users.ldif

# S. Mueller
dn: uid=s.mueller,ou=Users,dc=sogo,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: s.mueller
cn: Stefan Müller
mail: s.mueller@zzeroo.org
sn: Mueller
givenName: Stefan

# I. Belser
dn: uid=i.belser,ou=Users,dc=sogo,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: i.belser
cn: Ingrid Belser
mail: i.belser@zzeroo.org
sn: Belser
givenName: Ingrid

# K. Keilhofer
dn: uid=k.keilhofer,ou=Users,dc=sogo,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: k.keilhofer
cn: Karlheinz Keilhofer
mail: k.keilhofer@zzeroo.org
sn: Keilhofer
givenName: Karlheinz

# H. Kliemann
dn: uid=h.kliemann,ou=Users,dc=sogo,dc=zzeroo,dc=org
objectClass: top
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
uid: h.kliemann
cn: Helge Kliemann
mail: h.kliemann@zzeroo.org
sn: Kliemann
givenName: Helge  
```

users.ldif einlesen

```bash
ldapadd -x -D cn=admin,dc=sogo,dc=zzeroo,dc=org -w ***REMOVED*** -H ldap:// -f users.ldif
```


### Passworte festlegen

Die Passworte (Parameter `-s`) können jederzeit und immer wieder geändert werden. Wird der Parameter `-s` weg gelassen dann wird ein zufälliges Passwort vergeben.

```bash
ldappasswd -h 127.0.0.1 -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org uid=s.mueller,ou=Users,dc=sogo,dc=zzeroo,dc=org -s ***REMOVED***

ldappasswd -h 127.0.0.1 -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org uid=i.belser,ou=Users,dc=sogo,dc=zzeroo,dc=org -s belser

ldappasswd -h 127.0.0.1 -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org uid=k.keilhofer,ou=Users,dc=sogo,dc=zzeroo,dc=org -s keilhofer

ldappasswd -h 127.0.0.1 -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org uid=h.kliemann,ou=Users,dc=sogo,dc=zzeroo,dc=org -s kliemann

```



# Tipp's

## Benutzer Löschen

```bash
ldapdelete -h 127.0.0.1 -x -w ***REMOVED*** -D cn=admin,dc=sogo,dc=zzeroo,dc=org uid=smueller,ou=Users,dc=sogo,dc=zzeroo,dc=org
```

```bash
ldapsearch -xLLL -b dc=sogo,dc=zzeroo,dc=org
```


# Links

* [Super LDAP Tutorial auf digitalocean.com][digitalocean-ldap-tutorial]
* [LDAP Tutorial auf wiki.debian.org][debian-wiki-openldap-setup]


[debian-wiki-openldap-setup]: https://wiki.debian.org/LDAP/OpenLDAPSetup
[digitalocean-ldap-tutorial]: https://www.digitalocean.com/community/tutorials/how-to-use-ldif-files-to-make-changes-to-an-openldap-system
