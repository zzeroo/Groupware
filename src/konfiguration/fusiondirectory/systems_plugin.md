# Systems Plugin

Viele Plugins setzen auf das Systems Plugin auf. Also muss dieses zuerst installiert werden.

```bash
apt install fusiondirectory-plugin-systems fusiondirectory-plugin-systems-schema
```

Nach der Installation müssen die Schemata noch in das LDAP Verzeichnis eingetragen werden.

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/service-fd.schema
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/systems-fd-conf.schema
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/systems-fd.schema
```

