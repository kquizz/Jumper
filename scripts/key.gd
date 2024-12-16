extends Area2D

var color : String

func _ready() -> void:
	color = self.name.replace(" Key", "").to_lower()

func _on_body_entered(body: Node2D) -> void:
	if body is not CharacterBody2D:
		return

	if body.color == color: 
		GlobalEngine.add_key(color)
		body.update_hud()
		queue_free()
