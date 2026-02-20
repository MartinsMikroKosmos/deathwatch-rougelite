# CLAUDE.md – Deathwatch Roguelite

> Diese Datei wird von Claude Code automatisch gelesen. Immer aktuell halten!

## Projekt
Warhammer 40K Deathwatch Roguelite in Top-Down Perspektive.
- **Engine**: Godot 4.x (neueste stabile Version)
- **Sprache**: GDScript
- **Look & Feel**: Rimworld (Pixelart, taktisch, gritty, top-down)
- **Genre**: Roguelite mit Permadeath, prozeduralen Maps, Upgrade-System
- **Thema**: Deathwatch Space Marines kämpfen gegen Xenos-Bedrohungen (Tyraniden, Orks, Nekrons)

## Entwickler-Setup
- Mac, PyCharm Pro + Claude Code
- GitHub: privates Repository

## Coding Standards
- **Code & Kommentare**: Englisch
- **Kommunikation**: Deutsch
- **Naming**: `snake_case` für Variablen/Funktionen, `PascalCase` für Klassen/Nodes
- **Keine magischen Zahlen**: Immer Konstanten oder `.tres` Ressourcen
- **Docstrings**: Jede public-Funktion bekommt einen kurzen Kommentar
- **Signals over direct calls**: Lose Kopplung durch Godot Signals bevorzugen
- **Data-driven**: Stats/Balancing in Ressource-Dateien, nicht hardcoded

## Architektur-Prinzipien
- **Composition over Inheritance**: Systeme als separate Nodes/Autoloads
- **Autoloads** für globale Systeme: GameManager, EventBus, SaveSystem
- **Resources** für Datendefinitionen: MarineData, WeaponData, EnemyData
- **Scenes** sind eigenständig und kommunizieren über Signals

## Projektstruktur
```
deathwatch-roguelite/
├── CLAUDE.md                  # Diese Datei
├── project.godot
├── docs/
│   ├── GDD.md                 # Game Design Document
│   ├── ARCHITECTURE.md        # Technische Architektur
│   └── ROADMAP.md             # Milestones & Tasks
├── src/
│   ├── actors/
│   │   ├── marine/            # Space Marine (Spieler)
│   │   └── enemies/           # Xenos-Feinde
│   ├── systems/
│   │   ├── combat/            # Kampfsystem
│   │   ├── ai/                # Feind-KI
│   │   ├── inventory/         # Ausrüstung & Items
│   │   ├── roguelite/         # Permadeath, Runs, Upgrades
│   │   └── map/               # Prozedurale Kartengenerierung
│   ├── ui/
│   │   ├── hud/               # In-Game HUD
│   │   └── menus/             # Hauptmenü, Pausemenü
│   ├── maps/                  # Szenen für Maps/Räume
│   └── utils/                 # Hilfsfunktionen
├── assets/
│   ├── sprites/
│   ├── audio/
│   └── fonts/
└── tests/
```

## Aktueller Status
- [x] Projektstruktur aufgesetzt
- [x] GDD erstellt
- [x] Godot Projekt initialisiert
- [x] Autoloads eingerichtet (EventBus, GameManager, SaveSystem)
- [x] HealthComponent erstellt
- [x] Marine-Szene (CharacterBody2D, WASD, Maus-Aiming, Kenney Sprite)
- [x] Test-Map mit Wänden und Kamera
- [ ] Bolter Schusssystem
- [ ] Gant-Feind (einfache KI)
- [ ] HUD (HP-Balken, Munition)
- [ ] Game Over Screen

## Wichtige Hinweise für Claude Code
- Immer Godot 4 Syntax verwenden (nicht Godot 3!)
- Vor größeren Features: Architektur kurz erklären
- Bei Änderungen an bestehenden Systemen: Auswirkungen nennen
- Auf Performance achten: `_process` sparsam nutzen, `_physics_process` für Bewegung

## Git-Workflow
Nach jeder abgeschlossenen Änderung (auch kleinen Fixes) immer committen:
- **Nach jeder Aufgabe**: `git add` + `git commit` mit aussagekräftiger Message
- **Nach größeren Abschnitten** (neues System, neues Feature, mehrere zusammenhängende Dateien): zusätzlich `git push origin main`
- Commit-Messages auf **Englisch**, Präfix-Schema: `feat:`, `fix:`, `refactor:`, `docs:`
- Immer nur die tatsächlich geänderten Dateien stagen, kein `git add .` oder `git add -A`

## README.md aktuell halten
Die `README.md` im Projektstamm ist die GitHub-Hauptseite des Projekts. Sie muss bei folgenden Änderungen mitgepflegt werden:

- **Neue Autoloads oder Systeme**: Projektstruktur-Tabelle aktualisieren
- **Milestone abgeschlossen**: Checkbox im Roadmap-Abschnitt abhaken (`- [ ]` → `- [x]`)
- **Neues Feature implementiert**: Falls es unter einen Roadmap-Punkt fällt, dort abhaken
- **Autoload-Reihenfolge ändert sich**: Tabelle unter "Getting Started" anpassen
- **Neue Kapitel/Feinde spielbar**: Tabellen in der README erweitern
- **Neue Einstiegsvoraussetzungen** (z.B. andere Godot-Version): "Getting Started" anpassen

Faustregel: Wenn der Spielstand oder die Projektstruktur sich ändert, README mitändern.
