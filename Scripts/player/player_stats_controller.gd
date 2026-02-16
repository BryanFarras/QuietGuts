extends Node
class_name PlayerStatsController

var max_health := 100
var health := 100

var max_hunger := 100
var hunger := 100

var max_sanity := 100
var sanity := 100

func _process(delta):
	hunger -= 2 * delta
	sanity -= 1 * delta
	
	if hunger <= 0:
		health -= 5 * delta
