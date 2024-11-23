extends StaticBody2D

@onready var engine: Node = %Engine
var color : String 
@export var height: int = 5
@onready var lock_texture: Texture2D = $Lock.texture
@onready var icon: Sprite2D = $Icon
@onready var unlock_area: CollisionShape2D = $Area2D/UnlockArea


func _ready() -> void:
	color = self.name.replace(" Gate", "").to_lower()
	_create_sprites()
	_adjust_collision_shape()
	#unlock_area.debug_draw = true

func _create_sprites() -> void:
	for i in range(height):
		var sprite = Sprite2D.new()
		sprite.texture = lock_texture
		sprite.position = Vector2(0, -i * lock_texture.get_size().y)
		add_child(sprite)

func _adjust_collision_shape() -> void:
	var collision_shape = $CollisionShape2D
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(lock_texture.get_size().x / 2, lock_texture.get_size().y * height / 2)
	collision_shape.shape = shape
	collision_shape.position = Vector2(0, -lock_texture.get_size().y * height / 2)
	var unlock_shape = unlock_area.shape as RectangleShape2D
	unlock_shape.extents = Vector2(lock_texture.get_size().x / 2 + 4, lock_texture.get_size().y * height / 2)
	unlock_area.position = Vector2(-2, -lock_texture.get_size().y * height / 2)
	pass

func _on_body_entered(body: Node) -> void:
	print("gated")
	print(body.color)
	print(color)
	print(%Engine.keys)
	if body is CharacterBody2D and body.color == color and %Engine.has_key(color):
		self.queue_free()
