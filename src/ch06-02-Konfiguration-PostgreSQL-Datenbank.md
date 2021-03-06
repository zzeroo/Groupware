# Konfiguration PostgreSQL Datenbank

SOGo benötigt eine relationale Datenbank um Einladungen, Aufgaben und Kontakte zu speichern. Außerdem wird die Datenbank auch zum Speichern der persönlichen Einstellungen der SOGo Benutzer genutzt.

## Postgres Role "sogo" anlegen

Zunächst wird der postgres Benutzer aufgerufen. Der zweite Befehl legt dann eine so genannte Rolle mit dem Namen "sogo" an. Der Befehl fragt nach einem Password für diese Rolle, hier muss auch "sogo" eingegeben werden (Oder das Password muss in der sogo.conf angepasst werden.).

```bash
su - postgres
createuser --no-superuser --no-createdb --no-createrole --encrypted --pwprompt sogo
# (vergebt “sogo” als Password, nur jemand der Zugang zu einer root Shell hat kann sich mit postgres verbinden.)
```

## Postgres Datenbank "sogo" anlegen

```bash
createdb -O sogo sogo
```

## Postgres Zugriff

Die [SOGo Anleitung](https://sogo.nu/files/docs/SOGoInstallationGuide.html) bittet nun den Anwender in der Datei /var/lib/pgsql/data/pg_hba.conf ganz am Anfang eine Zeile einzufügen.

**Unter Debian lautet der Name/Pfad dieser Datei: __/etc/postgresql/9.6/main/pg_hba.conf__**

```conf
# BEGIN der Datei /etc/postgresql/9.6/main/pg_hba.conf
host   sogo   sogo     127.0.0.1/32     md5
```

Zum Abschluss wird postgres neu gestartet und dessen Status geprüft.

```bash
systemctl restart postgresql
systemctl status postgresql
```
