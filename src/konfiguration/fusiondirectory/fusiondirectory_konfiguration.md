# Fusion Directory Konfiguration

* [http://mail.zzeroo.org/fusiondirectory](http://mail.zzeroo.org/fusiondirectory)
* [https://documentation.fusiondirectory.org/en/documentation/admin_installation/core_installation](https://documentation.fusiondirectory.org/en/documentation/admin_installation/core_installation)

## Fusion Directory Schema Integration

Installation der Schema erfolgt mit dem Befehl:

```bash
fusiondirectory-insert-schema
```

Prüfen kann man das Ergebnis indem man alle Schema auflistet.

```bash
fusiondirectory-insert-schema -l
```

## Fusion Directory Konfiguration via Webinterface

Anschließend die URL [https://mail.zzeroo.org/fusiondirectory](https://mail.zzeroo.org/fusiondirectory) aufrufen und den Anweisungen folge leisten.

Zu Begin muss eine Text Datei mit einem Hash auf dem Server erstellt werden.

[![](../images/fusiondirectory-konfiguration-01.png)](../images/fusiondirectory-konfiguration-01.png)

Anschließend wird die Sprache der Oberfläche gewählt.

[![](../images/fusiondirectory-konfiguration-02.png)](../images/fusiondirectory-konfiguration-02.png)

PHP gecheckt, 

[![](../images/fusiondirectory-konfiguration-03.png)](../images/fusiondirectory-konfiguration-03.png)

und die Zugangsdaten für den OpenLDAP Server eingetragen (Admin DN und Password). Der Hacken bai "TLS connection" wird gesetzt.

[![](../images/fusiondirectory-konfiguration-04.png)](../images/fusiondirectory-konfiguration-04.png)

Im Oberen Teil der Konfiguration, unter "SSL" werden die letsencrypt Zertifikatpfade eingetragen.

[![](../images/fusiondirectory-konfiguration-05.png)](../images/fusiondirectory-konfiguration-05.png)

Der "Users RDN" muss nach `ou=people` geändert werden.

[![](../images/fusiondirectory-konfiguration-06.png)](../images/fusiondirectory-konfiguration-06.png)

Die "LDAP inspection" zeigt einige offen Punkt. Diese werden von oben nach unten abgearbeitet.

[![](../images/fusiondirectory-konfiguration-07.png)](../images/fusiondirectory-konfiguration-07.png)

Auf "Migrate" klicken, anschließend auf "Close",

[![](../images/fusiondirectory-konfiguration-08.png)](../images/fusiondirectory-konfiguration-08.png)

und alle noch offenen Punkte der Reihe nach fixen. Der Fusion Directory Admin "fd-admin" hat später alle Rechte. Ein entsprechend gutes Password sollte hier gewählt werden.

[![](../images/fusiondirectory-konfiguration-09.png)](../images/fusiondirectory-konfiguration-09.png)

Wenn alle Punkte grün sind kann auf "Next" geklickt werden.

[![](../images/fusiondirectory-konfiguration-10.png)](../images/fusiondirectory-konfiguration-10.png)

Konfigurationsdatei downloaden,

[![](../images/fusiondirectory-konfiguration-11.png)](../images/fusiondirectory-konfiguration-11.png)

und z.B. in Downloads speichern.

[![](../images/fusiondirectory-konfiguration-12.png)](../images/fusiondirectory-konfiguration-12.png)

Nun die Konfigurationsdatei via SCP übertragen.

```bash
scp Downloads/fusiondirectory.conf mail.zzeroo.org:/tmp/
```

> Achtung, Wechsel auf LDAP Server!

Auf dem Fusion Directory Server die Konfigurationsdatein nach `/etc/fusiondirectory/fusiondirectory.conf` kopieren,

```bash
cp /tmp/fusiondirectory.conf /etc/fusiondirectory/fusiondirectory.conf 
```

Und den vorgeschlagen Check ausführen.

```bash
fusiondirectory-setup --check-config 
```

Danach kann auf "Next" geklickt werden.

[![](../images/fusiondirectory-konfiguration-13.png)](../images/fusiondirectory-konfiguration-13.png)


Jetzt kann mit dem Fusion Directory Super User (fd-admin) eingeloggt weden.

[![](../images/fusiondirectory-konfiguration-14.png)](../images/fusiondirectory-konfiguration-14.png)

Finales Webinterface:

[![](../images/fusiondirectory-konfiguration-15.png)](../images/fusiondirectory-konfiguration-15.png)

[![](../images/fusiondirectory-konfiguration-16.png)](../images/fusiondirectory-konfiguration-16.png)
