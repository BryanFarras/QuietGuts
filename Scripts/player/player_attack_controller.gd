extends Node2D

@export var attack_cooldown := 0.5
@export var attack_duration := 0.15
@export var attack_damage := 20

@onready var attack_pivot: Marker2D = $AttackPivot
@onready var attack_area: Area2D = $AttackPivot/AttackArea
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer

var can_attack := true

func _ready():
	attack_area.monitoring = false
	attack_area.connect("body_entered", Callable(self, "_on_AttackArea_body_entered"))
	
	attack_cooldown_timer.wait_time = attack_cooldown
	attack_cooldown_timer.connect("timeout", Callable(self, "_on_AttackCooldown_timeout"))	

	PlayerInteractionEvent.MeleeAttackPressed.connect(Callable(self, "perform_attack"))

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var player_pos = get_parent().global_position
	var direction = (mouse_pos - player_pos).normalized()
	attack_pivot.rotation = direction.angle()

func perform_attack():
	can_attack = false
	attack_area.monitoring = true

	await get_tree().create_timer(attack_duration).timeout
	attack_area.monitoring = false

	attack_cooldown_timer.start()

func _on_AttackCooldown_timeout():
	can_attack = true

func _on_AttackArea_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)
