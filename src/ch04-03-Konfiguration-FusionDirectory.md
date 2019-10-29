# FusionDirectory Konfiguration
Nach der [Installation](./ch04-01-Installation-FusionDirectory.html) steht unter der URL [http://mail.ra-gas.de/fusiondirectory](http://mail.ra-gas.de/fusiondirectory) die FusionDirectory Installation bereit. Wir werden gleich im Anschluss diese URL aufrufen und die dort beschriebenen Punkte erfüllen.

>Hilfe bietet die [Fusionsdirectory Dokumentation][fusiondirectory-user-manual-v1.3], sie sollte vorab gelesen und verstanden werden. Es schadet auch nicht die Webseite paralell mit offen zu haben.


## FusionDirectory Konfiguration via Webinterface
Anschließend die URL [https://mail.ra-gas.de/fusiondirectory](https://mail.ra-gas.de/fusiondirectory) aufrufen und den Anweisungen folge leisten.

Zu Begin muss eine Text Datei mit einem Hash auf dem Server erstellt werden.

[![](../images/fusiondirectory-konfiguration-01.png)](../images/fusiondirectory-konfiguration-01.png)

Anschließend wird die Sprache der Oberfläche gewählt.

[![](../images/fusiondirectory-konfiguration-02.png)](../images/fusiondirectory-konfiguration-02.png)

PHP gecheckt,

[![](../images/fusiondirectory-konfiguration-03.png)](../images/fusiondirectory-konfiguration-03.png)

und die Zugangsdaten für den OpenLDAP Server eingetragen (Admin DN und Password).
Der Haken bai "TLS connection" muss auch gesetzt werden.

[![](../images/fusiondirectory-konfiguration-04.png)](../images/fusiondirectory-konfiguration-04.png)

In diesem Dialog wird zunächst oben die **Timezone** gesetzt. Danach werden im mittleren Teil der Konfiguration, unter **SSL**, die letsencrypt Zertifikatpfade eingetragen.

||
|:----|----|
|Key path            |`/etc/letsencrypt/live/mail.ra-gas.de/privkey.pem`
|Certificate path    |`/etc/letsencrypt/live/mail.ra-gas.de/cert.pem`
|CA certificate path |`/etc/letsencrypt/live/mail.ra-gas.de/fullchain.pem`

[![](../images/fusiondirectory-konfiguration-05.png)](../images/fusiondirectory-konfiguration-05.png)

### LDAP inspection
Die "LDAP inspection" zeigt einige offen Punkt. Diese werden von oben nach unten abgearbeitet.

[![](../images/fusiondirectory-konfiguration-07.png)](../images/fusiondirectory-konfiguration-07.png)

#### Inspecting object classes in root object
Auf "Migrate" klicken, anschließend auf "Close",

[![](../images/fusiondirectory-konfiguration-08.png)](../images/fusiondirectory-konfiguration-08.png)

#### Checking for super administrator
Der FusionDirectory Admin "fd-admin" hat später alle Rechte. Ein entsprechend gutes Password sollte hier gewählt werden.

[![](../images/fusiondirectory-konfiguration-09.png)](../images/fusiondirectory-konfiguration-09.png)

#### Checking for default ACL roles and groups
[![](../images/fusiondirectory-konfiguration-10.png)](../images/fusiondirectory-konfiguration-10.png)

Wenn alle Punkte grün sind kann auf "Next" geklickt werden.

### Download der FusionDirectory Konfiurationsdatei
Nun muss die Konfigurationsdatei herunter geladen werden.

[![](../images/fusiondirectory-konfiguration-11.png)](../images/fusiondirectory-konfiguration-11.png)

und z.B. in Downloads speichern.

[![](../images/fusiondirectory-konfiguration-12.png)](../images/fusiondirectory-konfiguration-12.png)

Nun die Konfigurationsdatei via SCP übertragen.

```bash
scp -i ~/.ssh/sogo.gaswarnanlagen.lan ~/Downloads/fusiondirectory.conf sogo@192.168.89.16:/tmp
```

> Achtung, Wechsel auf LDAP Server!

Auf dem FusionDirectory Server die Konfigurationsdatein nach `/etc/fusiondirectory/fusiondirectory.conf` kopieren,

```bash
cp /tmp/fusiondirectory.conf /etc/fusiondirectory/fusiondirectory.conf
```

Und den vorgeschlagen Check ausführen. Es wird ein Fix vorgeschlagen. Dieser muss mit `Yes` bestätigt werden. Es werden dabei lediglich einige Dateisytemberechtigungen gesetzt.

```bash
fusiondirectory-setup --check-config
```

Danach kann auf "Next" geklickt werden.

[![](../images/fusiondirectory-konfiguration-13.png)](../images/fusiondirectory-konfiguration-13.png)


Jetzt kann mit dem FusionDirectory Super User (fd-admin) eingeloggt weden.

[![](../images/fusiondirectory-konfiguration-14.png)](../images/fusiondirectory-konfiguration-14.png)

Finales Webinterface:

[![](../images/fusiondirectory-konfiguration-15.png)](../images/fusiondirectory-konfiguration-15.png)



[fusiondirectory-user-manual-v1.3]: https://fusiondirectory-user-manual.readthedocs.io/en/1.3/index.html
