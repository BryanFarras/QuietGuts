extends StaticBody2D

@export var max_health := 50
@export var drop_scene : PackedScene
@export var drop_amount := 3
@export var drop_radius := 16

var health := 0

func _ready():
	health = max_health

func take_damage(amount):
	health -= amount
	
	if health <= 0:
		die()

func die():
	drop_resources()
	queue_free()

func drop_resources():
	for i in drop_amount:
		var drop = drop_scene.instantiate()
		drop.global_position = global_position + Vector2(
			randf_range(-drop_radius, drop_radius),
			randf_range(-drop_radius, drop_radius)
		)
		get_tree().current_scene.call_deferred("add_child", drop)
