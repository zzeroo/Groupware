# Installation FusionDirectory

## Apt Keys dem Schlüsselbund hinzufügen

### Vorbereitungen

```bash
apt install gnupg
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
cat <<-EOF > /etc/apt/sources.list.d/fusion-directory.list
# fusiondirectory repository
deb http://repos.fusiondirectory.org/fusiondirectory-current/debian-stretch stretch main

# fusiondirectory extra repository
deb http://repos.fusiondirectory.org/fusiondirectory-extra/debian-stretch stretch main
EOF
```

```bash
apt update
```

## FusionDirectory installieren

```bash
apt install fusiondirectory
```

```bash
apt install fusiondirectory-schema
```
