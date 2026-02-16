extends Area2D
class_name ResourceBase

enum ResourceType {
	WOOD,
	STONE,
	IRON
}

@export var resource_type := ResourceType.WOOD
@export var amount := 1

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.has_method("add_item"):
		body.add_item(resource_type, amount)
		queue_free()
