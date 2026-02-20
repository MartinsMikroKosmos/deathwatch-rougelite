## EventBus.gd
## Global signal hub for loose coupling between game systems.
## All inter-system communication should flow through here.
extends Node


# --- Marine Signals ---

## Emitted when the player's marine is killed.
signal marine_died

# --- Combat Signals ---

## Emitted when a bullet hits any target with a HealthComponent.
## [param target] The Node that was hit.
## [param damage] The amount of damage dealt.
signal bullet_hit(target: Node, damage: int)

## Emitted when the active weapon's ammo count changes.
## [param current] Rounds remaining in the magazine.
## [param max_ammo] Full magazine capacity.
signal ammo_changed(current: int, max_ammo: int)

## Emitted when a reload begins.
## [param duration] How long the reload takes in seconds.
signal reload_started(duration: float)

# --- Enemy Signals ---

## Emitted when an enemy takes damage from a bullet.
## [param enemy] The enemy Node that was hit.
## [param damage] The amount of damage dealt.
signal enemy_hit(enemy: Node, damage: int)

## Emitted when an enemy is killed.
## [param enemy] The enemy Node that was killed.
## [param xp] Experience points rewarded to the player.
signal enemy_died(enemy: Node, xp: int)

# --- Item Signals ---

## Emitted when the player picks up an item.
## [param item_name] The display name of the picked-up item.
signal item_picked_up(item_name: String)

# --- Room / Map Signals ---

## Emitted when all enemies in a room have been defeated.
signal room_cleared

# --- Run Signals ---

## Emitted when the current run ends.
## [param success] True if the marine completed the mission, false on death.
signal run_ended(success: bool)

# --- Entity Signals ---

## Emitted whenever an entity's health changes.
## [param entity] The Node whose health changed.
## [param current] The entity's current health value.
## [param maximum] The entity's maximum health value.
signal health_changed(entity: Node, current: int, maximum: int)