extends Area2D

var color : String

func _ready() -> void:
	color = self.name.replace(" Flag", "").to_lower()
	return 

func _on_body_entered(body: Node2D) -> void:
	print("in flag")
	print(body is CharacterBody2D)
	print(body.color)
	print(color)
	if body is CharacterBody2D and body.color == color:
		%Engine.add_flag(color)
		if %Engine.check_level_finished():
			print("you win!")
			get_tree().call_deferred("reload_current_scene")
		else:
			self.queue_free()
