# Cyrus Konfiguration

- [Cyrus][CyrusIMAP]
- [Cyrus Configuration Guide (en)][Cyrus-konfiguration]

Die folgenden Punkte sind als Ergänzungen zum [Quickstart Guide][quickstart] anzusehen. Bitte alle dort aufgeführten Punkte ausführen/ prüfen!

## Installation

Die [Installation][cyrus-installation] sollte ja schon zu Begin der Anleitung erfolgt sein.

Nach der [Installation][cyrus-installation] muss der Dienst `cyrus-imapd` noch aktiviert werden. Dies scheint bei der Standard Debian Installation nicht der Fall zu sein (kann man prüfen mit `systemctl is-enabled cyrus-imapd`).

```bash
systemctl enable cyrus-imapd
```

## Setup User und Gruppen

Die Debian default Konfiguration scheint den Vorgaben aus dem [Quickstart](https://cyrusimap.org/quickstart.html#setup-the-cyrus-mail-user-and-group) zu befolgen.

Ich habe nur die Berechtigungen für SSL von Hand ausgeführt

```bash
usermod -aG ssl-cert cyrus
```

## Authentifizierung mit SASL

```bash
groupadd -fr saslauth
usermod -aG saslauth cyrus
```

Datei `/etc/default/saslauthd` editieren

```conf
# cat /etc/default/saslauthd  | egrep -v "(^#.*|^\$)"
START=yes
DESC="SASL Authentication Daemon"
NAME="saslauthd"
MECHANISMS="sasldb"
MECH_OPTIONS=""
THREADS=5
OPTIONS="-c -m /var/run/saslauthd"
```

```bash
systemctl restart saslauthd
systemctl status saslauthd
```

### IMAP User in SASL anlegen

```bash
echo '***REMOVED***' | saslpasswd2 -p -c imapuser
```

und testen

```bash
testsaslauthd -u imapuser -p ***REMOVED***
```

Der letzte Befehl sollte `0: OK "Success."` zurück liefern.


## Email Weiterleitung/ MTA Setup

Cyrus IMAP muss auch Emails empfangen können die der locale SMTP Server angenommen hat. In Cyrus wird das über ein Protokoll Names **LMTP** abgeweickelt. LMTP muss vom Email Server unterstützt werden. Postfix und Sendmail sind LMTP kompatible.

In dieser Konfiguration wird Sendmail verwendet. Die Postfix Konfiguration aus dem [Quickstart Guide][quickstart] können übersprungen werden.

### Sendmail installieren

Die [Installation](../installation/installation.html#cyrus) sollte ja schon zu Begin der Anleitung erfolgt sein.


### Sendmail konfigurieren

Num muss Sendmail darüber informiert werden das wir Cyrus IMAP Server verwenden. Dazu muss die Datei `/etc/mail/sendmail.mc` editiert werden. Die folgende Zeile muss **über** der MAILER_DEFINITIONS Sektion eingefügt werden.

```conf
define(`confLOCAL_MAILER', `cyrusv2')dnl
```

Und gleich nach der MAILER_DEFINITIONS, füge diese Zeile ein

```conf
MAILER(`cyrusv2')dnl
```

Nun muss aus dieser Vorgaben Datei eine Sendmail Konfigurationsdatei erstellt werden. Das dauert etwas!

```bash
sudo sendmailconfig
```

Zum Abschluss muss noch ein Verzeichnis für die Sockets angelegt werden und dessen Dateisystemberechtigungen gesetzt werden.

```bash
sudo mkdir -p /var/run/cyrus/socket
sudo chown cyrus:mail /var/run/cyrus/socket
sudo chmod 750 /var/run/cyrus/socket
```


## SSL Zertifikate

```bash
sudo openssl req -new -x509 -nodes -out /var/lib/cyrus/server.pem \
    -keyout /var/lib/cyrus/server.pem -days 365 \
    -subj "/C=DE/ST=BW/L=Kernen i.R./O=Mail/CN=localhost"
```

```bash
sudo chown cyrus:mail /var/lib/cyrus/server.pem
```

Am Ende der Datei `/etc/imapd.conf` folgende Zeilen einfügen

```bash
# /etc/imapd.conf
# ...
tls_server_cert: /var/lib/cyrus/server.pem
tls_server_key: /var/lib/cyrus/server.pem
```

Und in der Datei `/etc/cyrus.conf` imaps aktivieren

```bash
# /etc/cyrus.conf
# ...
imaps        cmd="imapd" listen="imaps" prefork=0
# ...
```

### Dienste neu starten

```bash
systemctl restart cyrus-imapd
systemctl status cyrus-imapd
```

### Testen 

Das Tool `imtest` it leider nicht im Standard Path

```bash
ln -s /usr/lib/cyrus/bin/imtest /usr/bin/
```

```bash
imtest -t "" -u imapuser -a imapuser -w ***REMOVED*** localhost
```

----

**Ein Teil ist mir bis hier her noch nicht ganz klar. Der Unterschied zwischen den SASL Benutzer `imapuser` und dem Benutzer `cyrus`.**

Der folgende Teil steht so nicht im [Quickstart Guide][quickstart] er wurde von mir "free style" hinzugefügt.

## Benutzer `cyrus` als Admin definieren

Dazu muss in der Datei `/etc/imapd.conf` der `admins:` Eintrag unkommentiert werden.

```conf
# /etc/imapd.conf
# ...
# Uncomment the following and add the space-separated users who 
# have admin rights for all services.
admins: cyrus
```

## Password User `cyrus` setzen

```bash
saslpasswd2 -c cyrus
```

Nun können als Benutzer `cyrus` Mailboxen angelegt werden.

## Mailboxen anlegen

### Mailboxnamen wie `user/s.mueller@zzeroo.org` erlauben

```conf
# /etc/imapd.conf
# ...
unixhierarchysep: yes
# ...
```

## Benutzer anlegen

```bash
echo '***REMOVED***' | saslpasswd2 -p -c s.mueller
echo 'belser' | saslpasswd2 -p -c i.belser
```

## Mailboxen anlegen

```bash
echo 'createmailbox user/s.mueller@zzeroo.org' | cyradm -u cyrus -w ***REMOVED*** localhost
echo 'createmailbox user/i.belser@zzeroo.org' | cyradm -u cyrus -w ***REMOVED*** localhost
```


----
# FAQ


## Fehler: "SOGo Sent is not an IMAP4 folder"

Dieser Fehler tritt auf wenn SOGo versucht den Send Ordner im IMAP eines Users zu erstellen. Infos gibt es [Hier](https://lists.inverse.ca/sogo/arc/users/2014-08/msg00023.html)

## Lösung: "SOGo Sent is not an IMAP4 folder"

Die Cyrus Benutzer und Mailboxen müssen von Hand angelegt werden.


## Fehler: `DBERROR: opening /var/lib/cyrus/tls_sessions.db: cyrusdb error`

Der Cyrus Server startet nicht.

```log
Jul 20 11:39:27 sogo cyrus/tls_prune[10056]: DBERROR: opening /var/lib/cyrus/tls_sessions.db: cyrusdb error
Jul 20 11:39:27 sogo cyrus/master[10048]: process type:START name:tlsprune path:/usr/sbin/cyrus age:0.000s pid:10056 exited, status 1
Jul 20 11:39:27 sogo systemd[1]: cyrus-imapd.service: Main process exited, code=exited, status=1/FAILURE
Jul 20 11:39:27 sogo cyrus/master[10048]: can't run startup
Jul 20 11:39:27 sogo systemd[1]: cyrus-imapd.service: Unit entered failed state.
Jul 20 11:39:27 sogo cyrus/master[10048]: exiting
Jul 20 11:39:27 sogo systemd[1]: cyrus-imapd.service: Failed with result 'exit-code'.
```

## Lösung `DBERROR: opening /var/lib/cyrus/tls_sessions.db: cyrusdb error`

Im START Block muss die Zeile `tlsprune›  cmd="/usr/sbin/cyrus tls_prune"` auskommentiert werden.

```bash
vim /etc/cyrus.conf
```
```conf
# ...
START {
# ...
    # tlsprune›  cmd="/usr/sbin/cyrus tls_prune"
}
# ...
```

[CyrusIMAP]: https://cyrusimap.org/
[Cyrus-konfiguration]: https://cyrusimap.org/imap/concepts/deployment.html
[quickstart]: https://cyrusimap.org/quickstart.html
[cyrus-installation]: ../installation/installation.html#cyrus