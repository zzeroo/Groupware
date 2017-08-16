# Groupware Installation
## mit OpenLDAP, FusionDirectory, Apache2, letsencrypt SSL, Postfix, Dovecot und SOGo

[Projektseiter |][homepage]&nbsp;[Online Version |][buch]&nbsp;[Github Repo][github]

Dieses Repository beinhaltet den Quellcode zu dem Buch [*"Groupware Installation mit OpenLDAP, FusionDirectory, Apache2, letsencrypt SSL, Postfix, Dovecot und SOGo"*][buch]

## Mitmachen

Wenn ihr das Buch selber aus den Quellen übersetzen wollt, zum Beispiel um lokale Änderungen zu checken bevor ihr ein Pull Request schickt ;), dann geht bitte wie folgt vor.

### Rust

Ihr braucht als Erstes Rust. Rust kann auf allen Rechnern, sehr einfach und bequem via [Rustup (https://www.rustup.rs/)][rustup] installiert werden.

Unter arch/debian/ubuntu sieht das so aus. Ich habe den originalen Befehl `curl https://sh.rustup.rs -sSf | sh` so angepasst das die *nightly* Version von Rust installiert wird.

```bash
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly
```

Anm.: *nightly* bedeutet unter Rust nicht unstable oder so, vielmehr bedeutet nightly "Alle neuen Features bitte!" :)


### mdbook

mdbook ist ein wundervolles Tool. Ich schreibe fast alle Dokumntationen und Anleitungen mit mdbook. Besucht doch die mdbook Homepage und lest euch etwas weiter ein.

Ich habe mdbook auf meinem System mit diesem Befehl installiert.

```bash
cargo install mdbook
```

### Quelltest des Buches mit git herunterladen (clonen)

Wechselt nun in das Verzeichnis in dem ihr eure Quelltexte speichert und clont das Git Repository.

```bash
git clone https://github.com/zzeroo/Groupware.git
```

### Quelltext übersetzen

Jetzt kann mit dem Befehl `mdbook build` der Quelltext (die .md Dateien) in ein html5/css/js Version gewandelt werden.

```bash
cd Groupware
mdbook build
```

#### Tipp
Mit dem Befehl `mdbook serve` kann man ein kleinen Webserver starten. Dieser erlaubt es euch unter der URL [http://localhost:3000](http://localhost:3000) die übersetzte Version des Quelltextes anzuzeigen.

#### noch ein Tipp

Lasst `mdbook serve` laufen und editiert eine der .md Dateien im `src` Verzeichnis. Am besten wenn ihr gleichzeitig diese Webseite in einem Browserfenster geöffnet habt.


[homepage]: https://zzeroo.com
[buch]: https://zzeroo.org/Groupware
[github]: https://github.com/zzeroo/Groupware
[rustup]: https://www.rustup.rs/
