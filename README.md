# Frika RoundEndSounds
 
Dieses Addon ermöglicht es, benutzerdefinierte Musik für den Rundenabschluss im Trouble in Terrorist Town (TTT)-Modus von Garry's Mod abzuspielen. Spieler können ihre Lautstärke einstellen und die aktuell abgespielte Musik anzeigen lassen.

## Funktionen

- **Musik nach Rundenende:** 
  - Unterschiedliche Musik je nach Siegbedingung (z. B. Innocent-Sieg, Traitor-Sieg).
- **Lautstärkesteuerung:** 
  - Spieler können die Lautstärke mit dem Befehl `!volume` im Chat anpassen.
- **Anzeige der aktuellen Musik:** 
  - Spieler können die aktuelle Musik mit dem Befehl `!music` im Chat anzeigen lassen.

## Installation

1. Lade das Addon in deinen `addons`-Ordner in Garry's Mod hoch.
2. Stelle sicher, dass die Ordnerstruktur für die Sounddateien korrekt ist:
sound/ ├── round/ ├── traitors/ ├── innocents/ ├── timelimit/ ├── teams/
3. Füge die gewünschten `.mp3`- oder `.ogg`-Dateien in die entsprechenden Verzeichnisse ein.

## Verwendung

### Befehle
- **`!volume <Zahl>`:** Stellt die Lautstärke der Musik ein (z. B. `!volume 75` für 75% Lautstärke).
- **`!music`**: Zeigt den Namen der aktuell abgespielten Musik im Chat an.

### Netzwerkeinstellungen
Stelle sicher, dass die folgenden Netzwerk-Strings definiert sind:
- `ttt_end_round_music_name`
- `ttt_end_round_music_path`

## Anforderungen

- **Garry's Mod**
- **TTT-Modus**

## Fehlerbehebung

- **Keine Musik abgespielt:**
- Überprüfe die Dateipfade und stelle sicher, dass die Dateien vorhanden sind.
- **Lautstärkeregler funktioniert nicht:**
- Stelle sicher, dass der `!volume`-Befehl korrekt verwendet wird.
- **Musikdateien werden nicht erkannt:**
- Stelle sicher, dass die Dateien im `.mp3`- oder `.ogg`-Format vorliegen und die richtige Ordnerstruktur verwenden.

## Lizenz

Dieses Addon wird unter der MIT-Lizenz veröffentlicht. Siehe `LICENSE` für weitere Informationen.

---

Falls du weitere Unterstützung benötigst, lass es mich wissen!