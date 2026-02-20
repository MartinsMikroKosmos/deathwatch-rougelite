## EnemyData.gd
## Resource defining the stats of a single enemy type.
## Create one .tres per enemy in assets/data/enemies/.
class_name EnemyData
extends Resource


@export var enemy_name: String = "Hormagaunt"
@export var max_health: int = 60
@export var move_speed: float = 80.0
@export var damage: int = 10
@export var attack_cooldown: float = 1.5
@export var detection_range: float = 300.0
@export var xp_reward: int = 10
