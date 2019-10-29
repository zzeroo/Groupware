

[Quelle](https://dokuwiki.tachtler.net/doku.php?id=tachtler:dovecot_shares)

[Hilfe](https://listen.jpberlin.de/pipermail/dovecot/2016-July/001122.html)

mkdir /var/lib/dovecot/db

chown vmail:vmail /var/lib/dovecot/db

chown vmail:vmail /var/lib/dovecot

```bash
# /etc/dovecot/conf.d/10-master.conf
# ...
service auth {
  unix_listener auth-userdb {
    mode = 0777
    user =  dovecot
    group = dovecot
  }
  # ...
}
# ...
```

```bash
# /etc/dovecot/conf.d/10-mail.conf
mail_location = maildir:/srv/vmail/%u/Maildir
namespace inbox {
  separator = /
  inbox = yes
}
namespace {
  type = shared
  separator = /
  prefix = shared/%%u/
  location = maildir:/srv/vmail/%%u/Maildir:INDEX=/srv/vmail/%u/shared/%%u:CONTROL=/srv/vmail/%u/shared/%%u
  subscriptions = yes
  list = children
}
mail_uid = 5000
mail_gid = 5000
mail_plugins = $mail_plugins quota acl
protocol !indexer-worker {
}
```

### namespace

### list

```bash
# /etc/dovecot/conf.d/20-imap.conf
protocol imap {
  mail_plugins = $mail_plugins imap_quota imap_acl
}
```


```bash
# /etc/dovecot/conf.d/90-acl.conf
plugin {
}
plugin {
}
plugin {
  acl = vfile
  acl_shared_dict = file:/var/lib/dovecot/db/shared-mailboxes.db
}
```

Jetzt kann `dovecot` neu gestartet werden. Der zweite Befehl sorgt dafür das der Status des dovecot Dienstes ausgegeben wird.

```bash
systemctl restart dovecot
systemctl status dovecot
```

## Administration

### doveadm acl

```bash
# doveadm acl
usage: doveadm [-Dv] [-f <formatter>] acl <command> [<args>]
  add          [-u <user>|-A] [-S <socket_path>] <mailbox> <id> <right> [<right> ...]
  debug        [-u <user>|-A] [-S <socket_path>] <mailbox>
  delete       [-u <user>|-A] [-S <socket_path>] <mailbox> <id>
  get          [-u <user>|-A] [-S <socket_path>] [-m] <mailbox>
  recalc       [-u <user>|-A] [-S <socket_path>]
  remove       [-u <user>|-A] [-S <socket_path>] <mailbox> <id> <right> [<right> ...]
  rights       [-u <user>|-A] [-S <socket_path>] <mailbox>
  set          [-u <user>|-A] [-S <socket_path>] <mailbox> <id> <right> [<right> ...]
```

#### Rechte setzen

```bash
doveadm acl set -u info@ra-gas.de INBOX user=s.mueller@ra-gas.de admin create delete expunge insert lookup post read write write-deleted write-seen
```

#### Rechte wegnehmen

Mit nachfolgendem Befehl können einzelne Berechtigungen weggenommen werden, nachfolgend soll nur das Recht: admin weggenommen werden:

```bash
doveadm acl remove -u petra@tachtler.net INBOX user=klaus@tachtler.net admin
```

#### Rechte löschen

Mit nachfolgendem können alle Rechte entzogen werden:

```bash
doveadm acl delete -u petra@tachtler.net INBOX user=klaus@tachtler.net
```

###

```bash
```

###

```bash
```
