# SOGo Konfiguration

Quelle dieser Konfiguration ist der [SOGo Installation and Configuration Guide][sogo-installation-guide].

SOGo nutzt die GNUstep Umgebung zur Konfiguration.

Die Einstellungsdatei ist unter `/etc/sogo/sogo.conf` zu finden. Dies ist eine Textdatei die mit einem beliebigen Editor bearbeitet werden kann.

## SOGo Datenbank Anbindung

```conf
# /etc/sogo/sogo.conf

  SOGoProfileURL = "postgresql://sogo:sogo@localhost:5432/sogo/sogo_user_profile";
  OCSFolderInfoURL = "postgresql://sogo:sogo@localhost:5432/sogo/sogo_folder_info";
  OCSSessionsFolderURL = "postgresql://sogo:sogo@localhost:5432/sogo/sogo_sessions_folder";
```

## SOGo User Sources

```conf
# /etc/sogo/sogo.conf

  SOGoUserSources = (
    {
      type = ldap;
      CNFieldName = cn;
      UIDFieldName = uid;
      IDFieldName = uid; // first field of the DN for direct binds
      bindFields = (uid, mail); // array of fields to use for indirect binds
      baseDN = "ou=people,dc=zzeroo,dc=org";
      bindDN = "uid=sogo,ou=people,dc=zzeroo,dc=org";
      bindPassword = $PASSWORD;
      canAuthenticate = YES;
      displayName = "Mitarbeiter";
      hostname = ldap://127.0.0.1:389;
      id = public;
      isAddressBook = YES;
    }
  );
```

# Apache2

RequestHeader set "x-webobjects-server-port" "443"
RequestHeader set "x-webobjects-server-name" "sogo"
RequestHeader set "x-webobjects-server-url" "https://sogo.domain.com" [^]

# Microsoft Enterprise ActiveSync

```bash
apt install sogo-activesync libwbxml2-0
```

```ini
# /etc/apache2/conf-available/SOGo.conf
ProxyPass /Microsoft-Server-ActiveSync \
	http://127.0.0.1:20000/SOGo/Microsoft-Server-ActiveSync \
	retry=60 connectiontimeout=5 timeout=3600
```

Bei einem timeout von 3600 muss der `WOWatchDogRequestTimeout` in `/etc/sogo/sogo.conf` auf 60 Sekunden gesetzt werden.

```ini
# /etc/sogo/sogo.conf
WOWatchDogRequestTimeout = 60;
```

Apache2 neustarten ...

```bash
systemctl restart apache2
systemctl status apache2
```

und SOGo neustarten ...

```bash
systemctl start sogo.service
systemctl status sogo.service
```

----

# FAQ

## Fehler: SOGo Website nicht erreichbar

Unter der SOGo Url war keine Webseite erreichbar.

## Lösung:

Auf einer Debian Jessie Installation musste die Apache2 SOGo Konfig von Hand aktiviert werden.

```bash
a2enconf SOGo
systemctl reload apache2
```


----

# Tipp's

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

Yes, you can use one SOGoUserSources entry for the address book and one
for the authentication part.
The address book has "isAddressBook = YES;" and "canAuthenticate = NO;".
The authentication one has "isAddressBook = NO;" and "canAuthenticate =
YES;".
```



[sogo-installation-guide]: https://sogo.nu/files/docs/SOGoInstallationGuide.html
