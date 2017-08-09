# weitere Sicherheitstools

## Fail2ban

Server sichern, siehe den Blog Artikel von Thomas Krenn unter [https://www.thomas-krenn.com/de/wiki/SSH_Login_unter_Debian_mit_fail2ban_absichern](https://www.thomas-krenn.com/de/wiki/SSH_Login_unter_Debian_mit_fail2ban_absichern).

```bash
apt install fail2ban
```

```bash
systemctl restart fail2ban
systemctl status fail2ban
```
