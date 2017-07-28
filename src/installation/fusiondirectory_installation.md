# Fusion Directory Installation

Die LDAP Schemata werden als erstes installiert. Im Kapitel Konfiguration werden diese dann in das LDAP Verzeichnis eingebunden.

## Apt Keys
### Vorbereitungen

`apt-key` benötigt das Tool `dirmngr`.

```bash
apt install dirmngr
```

### official gpg key

```bash
apt-key adv --keyserver keys.gnupg.net --recv-key D744D55EACDA69FF
```

### development gpg key

```bash
apt-key adv --keyserver keys.gnupg.net --recv-key ADD3A1B88B29AE4A
```

## Sources.list ergänzen

```bash
# /etc/apt/sources.list.d/fusion-directory.list
# fusiondirectory repository
deb http://repos.fusiondirectory.org/fusiondirectory-current/debian-jessie jessie main
 
# fusiondirectory extra repository
deb http://repos.fusiondirectory.org/fusiondirectory-extra/debian-jessie jessie main
```

```bash
apt update
```

## Fusion Directory Schema installieren

```bash
apt install fusiondirectory-schema
```

## Fusion Directory installieren

Danach folgt die Installation des Fusion Directory Software Stacks.

```bash
apt install fusiondirectory php-mdb2
```
