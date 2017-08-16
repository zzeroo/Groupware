# Tipp's
## Passwort eines Benutzers setzen

Das Passwort eines Benutzers kann jederzeit, immer wieder gesetzt werden.
Der Folgende Befehl `ldappasswd` bindet (authentifiziert) den User `admin` mit dem Password `$PASSWORD` gegen den LDAP Server `localhost` um das Passwort das Users `info` zu ändern.
Der Befehl setzt ein zufälliges Passwort und gibt dieses auf der Shell aus.

```bash
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=info,ou=people,dc=ra-gas,dc=de
```

Möchte man das Passwort selber festlegen dann muss dem obrigen Befehl noch der Parameter `-s` mit dem gewünschten Passswort übergeben werden.

```bash
ldappasswd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=info,ou=people,dc=ra-gas,dc=de -s NeuesP@assword
```


## Benutzer Löschen

```bash
ldapdelete -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// uid=smueller,ou=people,dc=ra-gas,dc=de
```

## Alle Benutzer auflisten

```bash
ldapsearch -xLLL -b dc=ra-gas,dc=de
```

## Bind testen

```bash
# ldapwhoami -vvv -h <hostname> -p <port> -D <binddn> -x -w <passwd>
ldapwhoami -vvv -h localhost -D cn=admin,dc=ra-gas,dc=de -x -w $PASSWORD
ldapwhoami -vvv -h localhost -D uid=smueller,ou=people,dc=ra-gas,dc=de -x -w $PASSWORD
```

## OpenLDAP log in rsyslog

Im rsyslog Konfigurationsordner `/etc/rsyslog.d/` muss dazu eine Datei `10-slapd.conf` mit folgendem Inhalt erstellt werden:

```
local4.*    /var/log/slapd.log;
```

```
vim /etc/rsyslog.conf
```

Zeile einfügen

```
$template slapdtmpl,"[%$DAY%-%$MONTH%-%$YEAR% %timegenerated:12:19:date-rfc3339%] %app-name% %syslogseverity-text% %msg%\n"
```

```bash
systemctl restart rsyslog.service
```

```
ldapsearch -Y external -H ldapi:///
```

```
cat /var/log/slapd.log
```

## Log Level prüfen/ setzen

[http://tutoriels.meddeb.net/openldap-log/][http://tutoriels.meddeb.net/openldap-log/]

Der erste Befehl liefert die aktuelle Loglevel Konfiguration.

```
ldapsearch -Y external -H ldapi:/// -b cn=config "(objectClass=olcGlobal)" olcLogLevel -LLL
```

```yaml
# ldapsearch -Y external -H ldapi:/// -b cn=config "(objectClass=olcGlobal)" olcLogLevel -LLL
SASL/EXTERNAL authentication started
SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
SASL SSF: 0
dn: cn=config
olcLogLevel: none
```

Zum Ändern erstellen wir wieder eine `slapdlog.ldif`

```
dn: cn=config
changeType: modify
replace: olcLogLevel
olcLogLevel: stats
```

Diese Datei wird mit `ldapmodify` eingelesen.

```
ldapmodify -Y external -H ldapi:/// -f slapdlog.ldif
```

Das Ergebnis kann wieder mit dem Befehl `ldapsearch` geprüft werden.

```
ldapsearch -Y external -H ldapi:/// -b cn=config "(objectClass=olcGlobal)" olcLogLevel -LLL
```

```bash
systemctl restart slapd.service
systemctl status slapd.service
```

## Enforce TLS connections

>Achtung nach dieser Konfiguration ist nur noch die Kommunikation via TLS möglich!

```
# slapd_config_TLS_enforce.ldif
dn: cn=config
changetype: modify
add: olcSecurity
olcSecurity: tls=128
```

```bash
ldapmodify -Y EXTERNAL -H ldapi:/// -f slapd_config_TLS_enforce.ldif
```
