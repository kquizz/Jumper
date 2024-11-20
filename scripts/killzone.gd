extends Area2D

@onready var timer = $Timer
@onready var engine: Node = %Engine


func _on_body_entered(body: Node2D) -> void:
	timer.start()
	Engine.time_scale = .5
	body.get_node("CollisionShape2D").disabled = true
	body.get_node("AnimatedSprite2D").mask = 0
	print("you died")


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	%Engine.setup_level()
