# Game Design Document – Deathwatch Roguelite

**Version**: 0.1  
**Stand**: 2026  
**Status**: In Entwicklung

---

## 1. Vision

Ein taktisches Top-Down Roguelite im Warhammer 40K Universum. Der Spieler führt einen Deathwatch Space Marine durch prozedural generierte Missionen gegen Xenos-Bedrohungen. Jeder Run ist einzigartig – bei Tod beginnt alles von vorne, aber permanente Fortschritte schalten neue Möglichkeiten frei.

**Elevator Pitch**: *„Rimworld trifft Hades – im Grimdark des 41. Jahrtausends."*

---

## 2. Core Gameplay Loop

```
Start Run
  → Mission auswählen (Ziel, Schwierigkeit, Xenos-Typ)
  → Prozedural generierte Map erkunden
  → Kämpfen, Loot sammeln, Upgrades wählen
  → Boss besiegen oder Missionsziel erreichen
  → Tod → Permadeath → Meta-Progression freischalten
  → Neuer Run mit neuen Möglichkeiten
```

---

## 3. Spieler (Space Marine)

### Deathwatch Kapitel (Startklassen)
| Kapitel | Stärke | Spezialfähigkeit |
|---|---|---|
| Ultramarines | Ausgeglichen | Taktischer Vorteil (Teambonus) |
| Space Wolves | Nahkampf | Berserker-Rage |
| Dark Angels | Fernkampf | Präzisionsschuss |
| Blood Angels | Geschwindigkeit | Todessprung |
| Iron Hands | Panzerung | Bionische Reparatur |

### Stats
- **Health**: Lebenspunkte
- **Armor**: Schadensreduktion
- **Speed**: Bewegungsgeschwindigkeit
- **Accuracy**: Trefferwahrscheinlichkeit
- **Willpower**: Fähigkeits-Ressource

### Ausrüstung
- **Primärwaffe**: Bolter, Plasmagewehr, Melter, Sturmkanone
- **Sekundärwaffe**: Boltpistole, Plasmakanone, Kettenschwert
- **Rüstungsmod**: Servo-Arm, Eisenmantel, Sprungsystem
- **Relikte**: Passive Boni (1-3 Slots)

---

## 4. Feinde (Xenos)

### Tyraniden (Schwarm)
- **Ganten**: Schwache Nahkämpfer, kommen in Massen
- **Hormaguanten**: Schnelle Flanker
- **Warrior**: Mittelstarke Elite-Einheit
- **Carnifex**: Boss – großer gepanzerter Nahkämpfer

### Orks (Chaos)
- **Gretchin**: Schwache Fernkämpfer
- **Boyz**: Standarte Nahkämpfer
- **Nob**: Elite mit Powerklinge
- **Warboss**: Boss – massiver Nahkämpfer mit Schockwelle

### Nekrons (Elite, später)
- **Warrior**: Regenerierende Fernkämpfer
- **Immortal**: Gepanzerte Elite
- **Overlord**: Boss – Teleportation, Auferstehensmechanik

---

## 5. Maps & Umgebung

### Typen
- **Raumschiff** (Corridors, Räume, Reaktorkern)
- **Ruinenwelt** (Trümmer, offene Flächen, Deckung)
- **Untergrund** (Tunnel, Höhlen, Nester)

### Prozedurale Generierung
- Raum-basiertes System (wie Rimworld Biome)
- Definierte Raum-Templates + zufällige Verbindungen
- Loot-Räume, Elitefeind-Räume, Bossraum immer vorhanden

---

## 6. Progression

### In einem Run (temporär)
- Waffen-Upgrades finden/kaufen
- Fähigkeiten freischalten (Skill-Tree pro Run)
- Relikte sammeln (passive Boni)

### Meta-Progression (permanent)
- **Requisition Points**: Währung zwischen Runs
- Neue Kapitel/Marines freischalten
- Startausrüstungs-Optionen erweitern
- Codex-Einträge (Lore freischalten)

---

## 7. Technische Ziele

- **Pixelart**: 16x16 oder 32x32 Sprites (Rimworld-Style)
- **Performance**: 60 FPS mit bis zu 50 Feinden gleichzeitig
- **Speichern**: Auto-Save nach jedem Raum, kein manuelles Speichern
- **Platform**: PC (Mac, Windows, Linux)

---

## 8. Milestones / Roadmap

### v0.1 – Playable Prototype
- [ ] Marine Bewegung (WASD + Maus-Aiming)
- [ ] Bolter Schussystem
- [ ] 1 Feind-Typ (Gant) mit einfacher KI
- [ ] 1 Test-Map (handgebaut)
- [ ] Einfaches HUD (HP, Munition)

### v0.2 – Core Roguelite Loop
- [ ] Permadeath implementiert
- [ ] Prozedurale Map-Generierung (3-5 Räume)
- [ ] Loot-System (Waffen/Relikte finden)
- [ ] 3 Feind-Typen
- [ ] Einfache Meta-Progression (Punkte sammeln)

### v0.3 – Content & Polish
- [ ] Alle 3 Xenos-Fraktionen
- [ ] 5 Deathwatch Kapitel spielbar
- [ ] Vollständiger Skill-Tree
- [ ] Sound & Musik
- [ ] Main Menu & UI polish

### v1.0 – Release
- [ ] Balancing & Testing
- [ ] Achievements
- [ ] Vollständige Lore/Codex
- [ ] Build für Mac/Windows/Linux
