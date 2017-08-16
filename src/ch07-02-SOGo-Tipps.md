# SOGo Tipp's

## Kalender View default nach login

In der Datein `` müssen folgende Einträge erstellt werden

```conf
// Kalender ist default nach Login
SOGoLoginModule = Calendar;
```

## Frage: Multiple Adressbücher
```
Am 19.07.2017 um 13:39 schrieb Marko Weber | 8000 (weber@zbfmail.de):
>
> hello list!,
>
> i want to ask if it is possible to have "ONE" global addressbook in sogo
> for multiple added domains?
> so when sogo is running for     domone.de , domtwo.de , domthree.de <-
> can they use together one global addressbook?
>
> thanks for any help and hints...
>
```

## Antwort: Mutliple Adressbücher

```
Yes, you can use one SOGoUserSources entry for the address book and one
for the authentication part.
The address book has "isAddressBook = YES;" and "canAuthenticate = NO;".
The authentication one has "isAddressBook = NO;" and "canAuthenticate =
YES;".
```

Zwei Adressbücher werden so definiert (es gehen auch noch viel mehr)

```conf
  SOGoUserSources = (
    {
      type = ldap;
      CNFieldName = cn;
      UIDFieldName = uid;
      IDFieldName = uid; // first field of the DN for direct binds
      bindFields = (uid, mail); // array of fields to use for indirect binds
      baseDN = "ou=people,dc=example,dc=com";
      bindDN = "uid=sogo,ou=people,dc=example,dc=com";
      bindPassword = $PASSWORD;
      canAuthenticate = YES;
      displayName = "Gemeinsame Adressen";
      hostname = ldap://127.0.0.1:389;
      id = public;
      isAddressBook = YES;
    },
    {
      type = ldap;
      CNFieldName = cn;
      UIDFieldName = uid;
      IDFieldName = uid; // first field of the DN for direct binds
      bindFields = (uid, mail); // array of fields to use for indirect binds
      baseDN = "uid=sogo-thing,ou=resources,dc=example,dc=com";
      bindDN = "uid=sogo,ou=people,dc=example,dc=com";
      bindPassword = $PASSWORD;
      canAuthenticate = NO;
      displayName = "Adressen SOGo Thing";
      hostname = ldap://127.0.0.1:389;
      id = addresses;
      isAddressBook = YES;
    }
  );
```
