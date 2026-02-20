# Deathwatch Roguelite

> *"Rimworld meets Hades – in the Grimdark of the 41st Millennium."*

A tactical top-down roguelite set in the Warhammer 40K universe. Command a Deathwatch Space Marine through procedurally generated missions against Xenos threats. Every run is unique – death means starting over, but permanent meta-progression unlocks new possibilities.

---

## Tech Stack

| | |
|---|---|
| **Engine** | Godot 4.x (latest stable) |
| **Language** | GDScript |
| **Visual Style** | Pixel art, top-down, Rimworld-inspired |
| **Platform** | PC (Mac, Windows, Linux) |

---

## Gameplay

### Core Loop

```
Select Mission (objective, difficulty, Xenos type)
  → Explore procedurally generated map
  → Fight, loot, choose upgrades
  → Defeat the boss or complete the mission objective
  → Death → Permadeath → Unlock meta-progression
  → New run with new possibilities
```

### Playable Chapters (planned)

| Chapter | Strength | Special Ability |
|---|---|---|
| Ultramarines | Balanced | Tactical Advantage |
| Space Wolves | Melee | Berserker Rage |
| Dark Angels | Ranged | Precision Shot |
| Blood Angels | Speed | Death Leap |
| Iron Hands | Armor | Bionic Repair |

### Enemies

- **Tyranids** – Swarm faction. Hormagaunts, Warriors, Carnifex boss.
- **Orks** – Chaos faction. Gretchin, Boyz, Nob, Warboss boss.
- **Necrons** – Elite faction *(later)*. Warriors, Immortals, Overlord boss.

### Progression

- **In-run (temporary)**: Weapon upgrades, per-run skill tree, relics.
- **Meta-progression (permanent)**: Requisition Points unlock new chapters, starting gear, and Codex lore entries.

---

## Project Structure

```
deathwatch-roguelite/
├── docs/
│   ├── GDD.md              # Game Design Document
│   ├── ARCHITECTURE.md     # Technical architecture
│   └── ROADMAP.md          # Milestones & tasks
├── src/
│   ├── actors/
│   │   ├── marine/         # Player character
│   │   └── enemies/        # Xenos enemies
│   ├── systems/
│   │   ├── EventBus.gd     # Signal hub (Autoload)
│   │   ├── GameManager.gd  # Run & score state (Autoload)
│   │   ├── SaveSystem.gd   # Meta-progression save/load (Autoload)
│   │   ├── combat/         # Combat system
│   │   ├── ai/             # Enemy AI
│   │   ├── inventory/      # Equipment & items
│   │   ├── roguelite/      # Permadeath, runs, upgrades
│   │   └── map/            # Procedural map generation
│   ├── ui/
│   │   ├── hud/            # In-game HUD
│   │   └── menus/          # Main menu, pause menu
│   ├── maps/               # Map / room scenes
│   └── utils/              # Helper utilities
├── assets/
│   ├── sprites/
│   ├── audio/
│   └── fonts/
└── tests/
```

---

## Roadmap

### v0.1 – Playable Prototype *(current)*
- [ ] Autoloads set up (GameManager, EventBus, SaveSystem)
- [ ] Marine scene (CharacterBody2D)
- [ ] WASD movement + mouse aiming
- [ ] Bolter shooting system
- [ ] Test TileMap (1 room, walls, floor)
- [ ] Gant enemy (simple AI: chase marine)
- [ ] HealthComponent (marine + enemies)
- [ ] Basic HUD (HP bar, ammo counter)
- [ ] Game Over screen on death

### v0.2 – Core Roguelite Loop
- [ ] Permadeath + run system
- [ ] Procedural map generation (3–5 rooms)
- [ ] Loot system (find weapons/relics)
- [ ] 3 enemy types
- [ ] Basic meta-progression (Requisition Points)

### v0.3 – Content & Polish
- [ ] All 3 Xenos factions
- [ ] 5 Deathwatch chapters playable
- [ ] Full skill tree
- [ ] Sound & music
- [ ] Main menu & UI polish

### v1.0 – Release
- [ ] Balancing & testing
- [ ] Achievements
- [ ] Full Lore / Codex
- [ ] Builds for Mac / Windows / Linux

---

## Getting Started

1. Install [Godot 4.x](https://godotengine.org/download/) (latest stable).
2. Clone the repository.
3. Open `project.godot` in Godot.
4. Register the Autoloads under **Project → Project Settings → Autoload** in this order:

| Name | Path |
|---|---|
| `EventBus` | `res://src/systems/EventBus.gd` |
| `GameManager` | `res://src/systems/GameManager.gd` |
| `SaveSystem` | `res://src/systems/SaveSystem.gd` |

5. Hit **F5** to run.

---

## Development

- **Code & comments**: English
- **Communication**: German
- **Naming**: `snake_case` for variables/functions, `PascalCase` for classes/nodes
- **Architecture**: Signal-based loose coupling via `EventBus`; stats and balancing in `.tres` resource files

See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for the full technical design and [`docs/GDD.md`](docs/GDD.md) for the game design document.

---

*This is a personal hobby project. Warhammer 40,000 is a trademark of Games Workshop Ltd. This project is non-commercial.*