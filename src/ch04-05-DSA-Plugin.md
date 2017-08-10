# DSA Plugin

Dieses Plugin wird für die so genannten "Directory Service Accounts", für administrative Aufgaben (wie pam_ldap, dns, nssldap, smbldap-tools, argonaut, usw.) im LDAP verwendet. Quelle: [Fusiondirectory.org "how_to_setup_dsa_plugin"](https://documentation.fusiondirectory.org/en/documentation/plugin/dsa_plugin/how_to_setup_dsa_plugin)

Wir verwenden die DSA Benutzer zur Authentifizierung der Dienste: Dovecot, Postfix, saslauthd und SOGo gegen unser LDAP Verzeichnis.

Zunächst müssen aber wieder die Plugin und Schemata installiert werden.

```bash
apt install fusiondirectory-plugin-dsa fusiondirectory-plugin-dsa-schema
```

Nach der Installation müssen die Schemata noch in das LDAP Verzeichnis eingetragen werden.

```bash
fusiondirectory-insert-schema -i /etc/ldap/schema/fusiondirectory/dsa-fd-conf.schema
```
