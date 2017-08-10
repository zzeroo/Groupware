# FusionDirectory Konfiguration

Nach der [Installation](./ch04-01-Installation-FusionDirectory.html) steht unter der URL [http://mail.ra-gas.de/fusiondirectory](http://mail.ra-gas.de/fusiondirectory) die FusionDirectory Installation bereit. Wir werden gleich im Anschluss diese URL aufrufen und die dort beschriebenen Punkte erfüllen.
Hilfe bietet die Dokumentation  [https://documentation.fusiondirectory.org/en/documentation/admin_installation/core_icommunity/uranium nstallation](https://documentation.fusiondirectory.org/en/documentation/admin_installation/core_installation), sie sollte vorab gelesen und verstanden werden. Es schadet auch nicht die Webseite paralell mit offen zu haben.


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

Die "LDAP inspection" zeigt einige offen Punkt. Diese werden von oben nach unten abgearbeitet.

[![](../images/fusiondirectory-konfiguration-07.png)](../images/fusiondirectory-konfiguration-07.png)

Auf "Migrate" klicken, anschließend auf "Close",

[![](../images/fusiondirectory-konfiguration-08.png)](../images/fusiondirectory-konfiguration-08.png)

und alle noch offenen Punkte der Reihe nach fixen. Der FusionDirectory Admin "fd-admin" hat später alle Rechte. Ein entsprechend gutes Password sollte hier gewählt werden.

[![](../images/fusiondirectory-konfiguration-09.png)](../images/fusiondirectory-konfiguration-09.png)

Wenn alle Punkte grün sind kann auf "Next" geklickt werden.

[![](../images/fusiondirectory-konfiguration-10.png)](../images/fusiondirectory-konfiguration-10.png)

Konfigurationsdatei downloaden,

[![](../images/fusiondirectory-konfiguration-11.png)](../images/fusiondirectory-konfiguration-11.png)

und z.B. in Downloads speichern.

[![](../images/fusiondirectory-konfiguration-12.png)](../images/fusiondirectory-konfiguration-12.png)

Nun die Konfigurationsdatei via SCP übertragen.

```bash
scp Downloads/fusiondirectory.conf mail.ra-gas.de:/tmp/
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

[![](../images/fusiondirectory-konfiguration-16.png)](../images/fusiondirectory-konfiguration-16.png)
