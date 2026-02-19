# ARCHITECTURE.md – Technische Architektur

## Godot 4 Szenenbaum (Hauptstruktur)

```
Main (Node)
├── GameManager (Autoload)
├── EventBus (Autoload)
├── SaveSystem (Autoload)
└── SceneManager (Autoload)

GameScene (Node2D)
├── World
│   ├── TileMap (Boden/Wände)
│   ├── Actors
│   │   ├── Marine (CharacterBody2D)
│   │   └── Enemies (Node2D)
│   │       └── [Enemy instances]
│   └── Items (Node2D)
├── Systems
│   ├── CombatSystem
│   ├── AISystem
│   └── RogueliteSystem
└── UI (CanvasLayer)
    ├── HUD
    └── PauseMenu
```

---

## Autoloads (Singletons)

### GameManager
Verwaltet den globalen Spielzustand.
```gdscript
# Zuständig für:
- Aktueller Run-Status (aktiv/beendet)
- Aktuelle Map/Mission
- Marine-Referenz
- Schwierigkeitsgrad
```

### EventBus
Zentrales Signal-System für lose Kopplung zwischen Systemen.
```gdscript
# Signale (Beispiele):
signal marine_died
signal enemy_died(enemy: Enemy, position: Vector2)
signal item_picked_up(item: ItemData)
signal room_cleared(room_id: int)
signal run_ended(success: bool, score: int)
```

### SaveSystem
Verwaltet persistente Daten (Meta-Progression).
```gdscript
# Speichert:
- Requisition Points
- Freigeschaltete Kapitel
- Statistiken (Runs, Kills, etc.)
- Codex-Einträge
```

---

## Resource-Klassen (Datendefinitionen)

```gdscript
# MarineData.gd
class_name MarineData extends Resource
@export var chapter_name: String
@export var max_health: int
@export var base_armor: float
@export var base_speed: float
@export var special_ability: String

# WeaponData.gd
class_name WeaponData extends Resource
@export var weapon_name: String
@export var damage: int
@export var fire_rate: float
@export var magazine_size: int
@export var projectile_speed: float
@export var weapon_type: WeaponType  # enum

# EnemyData.gd
class_name EnemyData extends Resource
@export var enemy_name: String
@export var max_health: int
@export var damage: int
@export var speed: float
@export var xp_reward: int
@export var faction: Faction  # enum
```

---

## Kernszenen

### Marine (CharacterBody2D)
```
Marine
├── CollisionShape2D
├── Sprite2D
├── AnimationPlayer
├── HealthComponent (Node)
├── WeaponComponent (Node)
│   └── Muzzle (Marker2D)
└── StateMachine (Node)
    ├── IdleState
    ├── MoveState
    ├── ShootState
    └── DeadState
```

### Enemy (CharacterBody2D)
```
Enemy
├── CollisionShape2D
├── Sprite2D
├── AnimationPlayer
├── HealthComponent (Node)
├── AIComponent (Node)
│   └── NavigationAgent2D
└── StateMachine (Node)
    ├── IdleState
    ├── PatrolState
    ├── ChaseState
    ├── AttackState
    └── DeadState
```

---

## Kommunikationsfluss

```
Input → Marine → WeaponComponent → Projectile → EnemyHealthComponent
                                              → EventBus.enemy_died
                                                        → RogueliteSystem (XP)
                                                        → UISystem (Anzeige)
```

---

## Prozedurale Map-Generierung

```
MapGenerator
1. Erstelle Grid (z.B. 10x10 Räume)
2. Platziere Start-Raum (immer links/unten)
3. Platziere Boss-Raum (immer rechts/oben)
4. Fülle Pfad mit Pflicht-Räumen (Elite, Loot)
5. Fülle Rest zufällig mit normalen Räumen
6. Verbinde Räume mit Korridoren
7. Instantiiere Room-Scenes aus Template-Pool
```

---

## Performance-Richtlinien

- Feinde nutzen `_physics_process` nur wenn aktiv (sichtbar im Viewport)
- Projektile: Object-Pooling für häufig gespawnte Objekte
- TileMap für Boden/Wände (performanter als einzelne Sprites)
- LOD: Feinde außerhalb des Viewports pausieren ihre KI
- Maximale gleichzeitige Feinde: 50 (konfigurierbar in GameManager)
