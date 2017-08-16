# Konfiguration SOGo
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
      baseDN = "ou=people,dc=ra-gas,dc=de";
      bindDN = "uid=sogo,ou=people,dc=ra-gas,dc=de";
      bindPassword = $PASSWORD;
      canAuthenticate = YES;
      displayName = "Mitarbeiter";
      hostname = ldap://127.0.0.1:389;
      id = public;
      isAddressBook = YES;
    }
  );
```

```conf
  WOWatchDogRequestTimeout = 60;
  SOGoTimeZone = Europe/Berlin;
  SOGoMailDomain = ra-gas.de;
  SOGoLanguage = German;
  SOGoSupportedLanguages = ( "German" );
  // SMTP Server Configuration
  SOGoMailingMechanism = smtp;
  SOGoSMTPServer = smtp.ra-gas.de;
  SOGoForceExternalLoginWithEmail = YES;

  // IMAP Server Configuration
  SOGoIMAPServer = "imap://imap.ra-gas.de:143/?tls=YES";
  //SOGoIMAPAclStyle = rfc2086;
  SOGoIMAPAclConformsToIMAPExt = YES;
  //SOGoSieveServer = "sieve://127.0.0.1:2000/?tls=YES";
  SOGoForceExternalLoginWithEmail = YES;

  // Web Interface Configuration
  SOGoFirstDayOfWeek = 1;

  SOGoMailKeepDraftsAfterSend = YES;
```

# Apache2 Konfiguration

Der SOGo Installer installiert die Apache2/SOGo Konfigurationsdatei nach `/etc/apache2/conf.d/SOGo.conf` richtig ist aber dieser Pfad `/etc/apache2/conf-available/SOGo.conf`. Wir korregieren das mit folgendem Befehl:

```bash
mv /etc/apache2/conf.d/SOGo.conf /etc/apache2/conf-available/SOGo.conf
```

Anschließend wird diese Konfiguration aktiviert

```conf
a2enconf SOGo
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


[sogo-installation-guide]: https://sogo.nu/files/docs/SOGoInstallationGuide.html
