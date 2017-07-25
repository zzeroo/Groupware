# Konfiguration

Die Konfiguration beginnt wieder mit der Apache2 Konfiguration. Hier wird `letsencrypt` der https Zugriff eingerichtet. Die Letsencrypt Zertifikate werden anschließend auch für Postfix und Dovecot verwendet.

Als Vorlage für die Postfix & Dovecot Konfiguration dient ein Youtube Tutorial [Debian mailserver with Postfix & Dovecot + Thunderbird demo](https://www.youtube.com/watch?v=WCo7dwtgprg).

SOGo nutzt die GNUstep Umgebung zur Konfiguration.

Die Einstellungsdatei ist unter `/etc/sogo/sogo.conf` zu finden. Dies ist eine Textdatei die mit einem beliebigen Editor bearbeitet werden kann.