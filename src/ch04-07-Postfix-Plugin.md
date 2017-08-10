# Postfix Plugin

Das Postfix Plugin wird wie die vorhergehenden Plugin installiert.

```bash
apt install fusiondirectory-plugin-postfix fusiondirectory-plugin-postfix-schema
```

Nach der Installation müssen die Schemata noch in das LDAP Verzeichnis eingetragen werden.

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/postfix-fd.schema
```
