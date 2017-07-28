# OpenLDAP Konfiguration

[Debian Wiki OpenLDAP Setup][debian-wiki-openldap-setup]

Bei der OpenLDAP Installation wurde nur nach dem LDAP Password gefragt. Eine Vollständige Konfiguration kann mit folgendem Befehl gestartet werden.

```bash
dpkg-reconfigure -plow slapd
```

Die erste Frage des Konfigurators ist seltsam ("Konfiguration auslassen?"), Sinn dieser Aktion ist es ja eine default Konfiguration zu erstellen. Wir antworten also mit `NO`.

[![](../images/slapd-konfiguration-01.png)](../images/slapd-konfiguration-01.png)

Domain Namen passt und kann als Basis DN verwendet werden.

[![](../images/slapd-konfiguration-02.png)](../images/slapd-konfiguration-02.png)

Name der Organisation kann irgend ein vielsagender Name sein. Ich verwende hier auch wieder den DNS Namen.

[![](../images/slapd-konfiguration-03.png)](../images/slapd-konfiguration-03.png)

Ein Passwort vergeben,

[![](../images/slapd-konfiguration-04.png)](../images/slapd-konfiguration-04.png)

und bestätigen.

[![](../images/slapd-konfiguration-05.png)](../images/slapd-konfiguration-05.png)

Anschließend das MDB Datenbank Format wählen.

[![](../images/slapd-konfiguration-06.png)](../images/slapd-konfiguration-06.png)

Die alten Datenbanken sollen bei einem `apt purge` gelöscht werden. Wie haben ja eine Datensicherung.

[![](../images/slapd-konfiguration-07.png)](../images/slapd-konfiguration-07.png)

Evtl. bestehende "alte" Datenbanken aus dem Weg räumen `YES` (in unserem Fall gibt es keine).

[![](../images/slapd-konfiguration-08.png)](../images/slapd-konfiguration-08.png)

Das LDAPv2 Protokoll soll nicht mehr verwendet werden.

[![](../images/slapd-konfiguration-09.png)](../images/slapd-konfiguration-09.png)


Die Konfigruation kann mit diesem Befehl geprüft werden:

```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b "cn=config" 
```

