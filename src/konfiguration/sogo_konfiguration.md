# SOGo Konfiguration

Quelle dieser Konfiguration ist der [SOGo Installation and Configuration Guide][sogo-installation-guide].

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
      baseDN = "ou=users,dc=zzeroo,dc=org";
      bindDN = "uid=sogo,ou=users,dc=zzeroo,dc=org";
      bindPassword = ***REMOVED***;
      canAuthenticate = YES;
      displayName = "Gemeinsame Adressen";
      hostname = ldap://127.0.0.1:389;
      id = public;
      isAddressBook = YES;
    }
  );
```

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

[sogo-installation-guide]: https://sogo.nu/files/docs/SOGoInstallationGuide.html