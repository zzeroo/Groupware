# Mail Plugin

SOGo benötigt das Systems und das Mail Plungin. Das Mail Plugin wird wie folgt installiert.

Quellen diese Anleitung sind

* [das offizielle Fusion Directory wiki](https://documentation.fusiondirectory.org/en/documentation/admin_mail_method_installation/how_to_install_mail_plugin)
* und [ein Blogpost von Theo Andreou](https://www.theo-andreou.org/?p=1568#comment-10434)

## Mail

```bash
apt install fusiondirectory-plugin-mail fusiondirectory-plugin-mail-schema
```

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/mail-fd.schema
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/mail-fd-conf.schema
```

## Alias

```bash
apt install fusiondirectory-plugin-alias fusiondirectory-plugin-alias-schema
```

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/alias-fd-conf.schema
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/alias-fd.schema
```

## Postfix

```bash
apt install fusiondirectory-plugin-postfix fusiondirectory-plugin-postfix-schema
```

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/postfix-fd.schema
```


----

```bash
apt install fusiondirectory-plugin-dovecot
apt install fusiondirectory-plugin-dovecot-schema
```

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/dovecot-fd.schema 
```