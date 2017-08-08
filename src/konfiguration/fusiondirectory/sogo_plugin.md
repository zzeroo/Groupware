# SOGo Plugin

Quelle: [https://documentation.fusiondirectory.org/en/documentation/plugin/sogo_plugin](https://documentation.fusiondirectory.org/en/documentation/plugin/sogo_plugin)

```bash
apt install fusiondirectory-plugin-sogo fusiondirectory-plugin-sogo-schema
```

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/sogo-fd-conf.schema
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/calEntry.schema
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/calRessources.schema
```