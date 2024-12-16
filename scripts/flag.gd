extends Area2D

var color : String


func _ready() -> void:
	color = self.name.replace(" Flag", "").to_lower()
	return 

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.color == color:
		if not GlobalEngine.check_level_finished(color):
			self.call_deferred("queue_free")
			body.drop_children()
			body.call_deferred("queue_free")
