extends CharacterBody2D

@export var max_speed := 200.0
@export var acceleration := 800.0
@export var friction := 900.0

var input_direction := Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		PlayerInteractionEvent.MeleeAttackPressed.emit()

func _physics_process(delta):
	handle_input()
	apply_movement(delta)
	move_and_slide()

func handle_input():
	input_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

func apply_movement(delta):
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(
			input_direction * max_speed,
			acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			friction * delta
		)
