# Installation Postfix

```bash
apt install postfix postfix-pcre postfix-ldap
```


Im Dialog wird "Internet Site" ausgewählt,

!["Internet Site" wählen](../images/postfix-installation-01.png)

und der richtige Domainname eingetragen.

!["Internet Site" wählen](../images/postfix-installation-02.png)


# Installation Dovecot

```bash
apt install dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-ldap
```

# SASL für SMTP AUTH

```bash
apt install libsasl2-2 sasl2-bin
```
