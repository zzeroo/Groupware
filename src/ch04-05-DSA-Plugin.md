# DSA Plugin

Dieses Plugin wird für die so genannten "Directory Service Accounts", für administrative Aufgaben (wie pam_ldap, dns, nssldap, smbldap-tools, argonaut, usw.) im LDAP verwendet.

* [Fusiondirectory.org "how_to_setup_dsa_plugin"](https://documentation.fusiondirectory.org/en/documentation/plugin/dsa_plugin/how_to_setup_dsa_plugin)

```bash
apt install fusiondirectory-plugin-dsa fusiondirectory-plugin-dsa-schema
```

Nach der Installation müssen die Schemata noch in das LDAP Verzeichnis eingetragen werden.

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/dsa-fd-conf.schema
```
