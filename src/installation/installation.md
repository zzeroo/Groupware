# Installation

## Vorbereitungen

```bash
apt-get update
apt-get upgrade
```

### Rust und Tools

```bash
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

cat <<EOF >.config/fish/config.fish
set -gx PATH "$HOME/.cargo/bin" $PATH;
EOF

cargo install ripgrep

cargo install --git https://github.com/sharkdp/fd
```

## Apache2

```bash
apt-get install apache2
```

## PostgreSQL

```bash
apt-get install postgresql
```

## OpenLDAP

- [Debian Wiki OpenLDAP Setup][debian-wiki-openldap-setup]


```bash
apt install slapd ldap-utils ldapscripts
```

## MTA
### Sendmail 

```bash
apt-get install -y sendmail
```

oder 

### Postfix (Alternative zu Sendmail)

```bash

apt-get install postfix
```

## Cyrus

```bash
apt install cyrus-common cyrus-doc cyrus-imapd cyrus-pop3d cyrus-admin cyrus-murder cyrus-replication cyrus-nntpd cyrus-caldav cyrus-clients cyrus-imspd cyrus-dev cyrus-sasl2-doc
```



[debian-wiki-openldap-setup]: https://wiki.debian.org/LDAP/OpenLDAPSetup
