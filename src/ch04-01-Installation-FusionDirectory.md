# Installation FusionDirectory

## Apt Keys dem Schlüsselbund hinzufügen

### Vorbereitungen

Damit der nächste Befehl funktioniert muss das Tool
`apt-key` benötigt das Tool `dirmngr`.

```bash
apt install dirmngr
```

### Offiziellen GPG Schlüssel hinzufügen

```bash
apt-key adv --keyserver keys.gnupg.net --recv-key D744D55EACDA69FF
```

### Entwickler GPG Schlüssel hinzufügen

```bash
apt-key adv --keyserver keys.gnupg.net --recv-key ADD3A1B88B29AE4A
```

### Apt's sources.list ergänzen

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

## FusionDirectory Schema installieren

Die eigentliche Installation beginnt mit der Installation der LDAP Schemata.

```bash
apt install fusiondirectory-schema
```

## FusionDirectory installieren

Danach folgt die Installation des FusionDirectory Software Stacks.

```bash
apt install fusiondirectory php-mdb2 php-mbstring
```
