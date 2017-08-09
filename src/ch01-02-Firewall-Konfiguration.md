# Firewall Konfiguration

Folgende Ports sollen von außen erreichbar sein.

|Protokoll|Port|Name|Bemerkung
|:------|------|:------|------
|TCP|22|ssh|Der Zugriff sollte auf spezielle IP Adressen/ Bereiche begrenzt werden. SSH ist mit Abstand der erste Dienst der vom Internet aus attackiert wird.
|TCP|25|smtp|
|TCP|587|smtps|
|TCP|465|smtps.old|
|TCP|80|http|
|TCP|443|https|
|TCP|110|pop3|
|TCP|995|pop3s|
|TCP|143|imap|
|TCP|636|ldaps|
|TCP|993|imap TLS|
