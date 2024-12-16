extends Area2D


var color : String

func _ready() -> void:
	var regex = RegEx.new()
	var pattern = r"\b(\w+) Gem\w*\d*\b"
	var error = regex.compile(pattern)
	
	if error != OK:
		print("Failed to compile regex pattern")
		return

	var result = regex.search(self.name)
	color = result.get_string(1).to_lower()

func _on_body_entered(body: Node2D) -> void:
	if body.color == self.color:
		GlobalEngine.add_gem(color)
		body.update_hud()
		self.queue_free()
