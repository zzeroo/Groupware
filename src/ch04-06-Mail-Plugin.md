# Mail Plugin

SOGo benötigt das **Systems** und das **Mail** Plungin.
**Systems** sollte schon installiert sein, das Mail Plugin wird wie folgt installiert.

Quellen diese Anleitung sind

* [das offizielle Fusion Directory "how_to_install_mail_plugin" wiki](https://documentation.fusiondirectory.org/en/documentation/admin_mail_method_installation/how_to_install_mail_plugin)
* und [ein Blogpost von Theo Andreou](https://www.theo-andreou.org/?p=1568#comment-10434)

Die Installation via `apt` ist wieder sehr einfach.

```bash
apt install fusiondirectory-plugin-mail fusiondirectory-plugin-mail-schema
```

Nach der Installation müssen die Schemata noch in das LDAP Verzeichnis eingetragen werden.

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/mail-fd.schema
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/mail-fd-conf.schema
```
