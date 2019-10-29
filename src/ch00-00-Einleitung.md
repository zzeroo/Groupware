# Einleitung
Die Unterseiten der Kapitel sollten in der gleichen Reihenfolge abgearbeitet werden.

## Passworte

> Passworte werden nur als Variable (z.B. `$PASSWORD`) dargestellt.
> Diese Variable muss also in eurer Konfiguration ersetzt werden.

### Tipp

Wenn ihr Befehle wie diesen seht `ldapadd -x -D cn=admin,dc=ra-gas,dc=de -w $PASSWORD -H ldap:// -f frontend.ra-gas.de.ldif` dann könnt ihr das `$PASSWORD` entweder immer durch euer richtiges Passwort ersetzen, oder ihr lasst es einfach so wie es ist (`$PASSWORD`). Damit Letzteres funktioniert müsst Ihr euere Shell (bash, zsh, fish) mitteilen das es `$PASSWORD` durch euere Password ersetzen soll. Das geht mit folgender Umgebungsvariablen (bitte nur das für eure Shell verwenden).

```bash
# bash/zsh/sh
set PASSWORD=fumanchu123$
# fish
set PASSWORD fumanchu123$
```

Einmal gesetzt (set) ersetzt eure Shell nun immer `$PASSWORD` durch `fumanchu123$`. Diese Umgebungvariable gilt bis ihr die Shell schließt. Ihr müsst sie also immer wieder setzen. Und sucht garnicht erst bei Google nach einem Weg das automatisch zu setzten ;) das wäre immer ein Sicherheitsrisiko.
