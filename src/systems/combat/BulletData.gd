## BulletData.gd
## Resource defining the stats of a single bullet type.
## Create one .tres per weapon in assets/data/weapons/.
class_name BulletData
extends Resource


@export var damage: int = 25
@export var speed: float = 600.0
@export var max_range: float = 500.0
@export var piercing: bool = false
