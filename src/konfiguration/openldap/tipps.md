# Tipp's

## Benutzer Löschen

```bash
ldapdelete -x -D cn=admin,dc=zzeroo,dc=org -w $PASSWORD -H ldap:// uid=smueller,ou=users,dc=zzeroo,dc=org
```

## Alle Benutzer auflisten

```bash
ldapsearch -xLLL -b dc=zzeroo,dc=org
```

## Bind testen

```bash
# ldapwhoami -vvv -h <hostname> -p <port> -D <binddn> -x -w <passwd>
ldapwhoami -vvv -h localhost -D cn=admin,dc=zzeroo,dc=org -x -w $PASSWORD
ldapwhoami -vvv -h localhost -D uid=smueller,ou=users,dc=zzeroo,dc=org -x -w $PASSWORD
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

# Postfix Schema

> Nicht funktional

[https://www.vennedey.net/resources/2-LDAP-managed-mail-server-with-Postfix-and-Dovecot-for-multiple-domains](https://www.vennedey.net/resources/2-LDAP-managed-mail-server-with-Postfix-and-Dovecot-for-multiple-domains)

```bash
wget -O postfix.ldif https://raw.githubusercontent.com/68b32/postfix-ldap-schema/master/postfix.ldif
ldapadd -x -D cn=admin,dc=zzeroo,dc=org -w $PASSWORD -H ldap:// -f postfix.ldif
```

# Indexing

>Noch nicht mit Fusion Directory getestet!

Für mehr Performance und im SOGo Manual empfohlen müssen einige Spalten indiziert werdebn

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
