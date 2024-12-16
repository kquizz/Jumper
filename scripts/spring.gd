extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var launch_timer: Timer = $LaunchTimer


@onready var hold_location: Marker2D = $HoldLocation
var child_original_parent
var loaded = false
var reset = true

func _on_ready() -> void:
	animated_sprite.animation = "up"

func _on_loading_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.launch_up(200)
	
	#if body is Player and not loaded and reset: 
		#animated_sprite.animation = "down"
		#launch_timer.start()
		#loaded = true
		#reset = false
		#carry_character(body)

func _on_launch_timer_timeout() -> void:
	for child in get_children():
		if child is Player and child:
			child.reparent(child.original_parent)
			child.set_animation("jump")
			loaded = false
			launch_timer.start()
			child.launch_up(200)
			break

func carry_character(body) -> void:
	body.reparent(self, false)
	body.position = hold_location.position

	body.state = Enums.States.RIDE
	#body.collision_layer = 3

func _on_loading_area_body_exited(body: Node2D) -> void:
	reset = true
	loaded = false
	launch_timer.stop()
