extends Node2D

@export var animal_scene: PackedScene
@export var min_count := 3
@export var max_count := 6
@export var spawn_radius := 80


func _ready():
    spawn_group()


func spawn_group():

    if animal_scene == null:
        push_error("Animal scene belum diisi!")
        return

    var count = randi_range(min_count, max_count)

    for i in count:
        var animal = animal_scene.instantiate()

        # posisi acak di sekitar spawner
        var offset = Vector2(
            randf_range(-spawn_radius, spawn_radius),
            randf_range(-spawn_radius, spawn_radius)
        )

        animal.global_position = global_position + offset

        get_tree().current_scene.add_child.call_deferred(animal)

	