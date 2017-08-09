# DNS

## Verschiedene Domain Namen für verschiedene Dienste

Im Laufe dieser Anleitung konfigurieren wir sehr viele Dienste auf nur einem physischem Rechner. Es würde also technisch ausreichen nur einen DNS Record für alle Dienste zu erstellen und die Dienste auf diese eine Adresse zu konfigurieren.

Das scalliert aber nicht. Das heist, wenn wir mal annehmen das unsere Dienste durchschlagenden Erfolg haben werden, dann wird es irgendwann einmal nötig sein, für die start belasteten Dienste, einen separaten Rechner zu stellen. Zeigen nun alle Konfigurationen auf nur einen Rechnernamen, dann wird das kompliziert. Haben alle Dienste aber eigenen URL's (Rechnernamen; DNS Domain Namen) dann ist dieses Problem schon im Keim erstickt, noch bevor es ein richtiges Problem wird.

## Übersicht der Verwendeten Domain Namen

|Domain Name|Verwendung
|:---|:------|
|mail.zzeroo.org|Dieser Record sollte auf den IMAP und den SMTP Server zeigen. Ich verwende ihn auch in der SOGo Konfiguration|
|sogo.zzeroo.org|wie der `mail` Record, aber speziell für die SOGo Groupware Installation|
|imap.zzeroo.org|Posteingangsserver|
|smtp.zzeroo.org|Postausgangsserver|
|ldap.zzeroo.org|der OpenLDAP Server|
|db.zzeroo.org|PostgreSQL Server|
|mx.zzeroo.org|für den DNS MX Record|

## Beispiel Konfiguration

Meine Domains sind bei 1und1 gehostet. Für dieses Buch verwende ich daher auch den DNS Konfigurator von 1und1.
Alle hier besprochenen Themen sind aber auch auf alle anderen Provider anwendbar.

[![1](./images/ch01/1und1-DNS.png)](./images/ch01/1und1-DNS.png)
