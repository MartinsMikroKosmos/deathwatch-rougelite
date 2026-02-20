## Placeholder.gd
## Temporary visual stand-in for the Marine sprite.
## Remove this node once a real sprite/spritesheet is added.
extends Node2D


func _draw() -> void:
	# Green 16x16 square centered on the origin
	draw_rect(Rect2(-8, -8, 16, 16), Color.GREEN)