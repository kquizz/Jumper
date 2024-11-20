extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -525.0

@onready var engine: Node = %Engine
var color : String


@onready var gem_label: Label = $"CanvasLayer/Gem Label"
@onready var key_icon_enabled: TextureRect = $"CanvasLayer/Key Icon - Enabled"
@onready var key_icon_disabled: TextureRect = $"CanvasLayer/Key Icon - Disabled"
@onready var gem_count_tens: TextureRect = $"CanvasLayer/Gem Count Tens"
@onready var gem_count_ones: TextureRect = $"CanvasLayer/Gem Count Ones"

@onready var ray_cast_down: RayCast2D = $RayCast_down
@onready var ray_cast_up: RayCast2D = $RayCast_up
@onready var carry_position: Marker2D = $CarryPosition
@onready var hud: CanvasLayer = $HUD


func _ready() -> void:
	color = self.name.replace(" Player", "").to_lower()
	update_hud()
	ray_cast_up.enabled = true

func update_hud() -> void:
	if color == "blue":
		return
	if engine.keys[color] > 0:
		hud.get_node("Key Icon - Enabled").hide()
		hud.get_node("Key Icon - Disabled").show()
	else:
		hud.get_node("Key Icon - Enabled").hide()
		hud.get_node("Key Icon - Disabled").show()

	var gem_tens = engine.gems[color] / 10
	var gem_ones = engine.gems[color] % 10
	
	hud.get_node("Gem Count Tens").texture = get_preload(gem_tens)
	hud.get_node("Gem Count Ones").texture = get_preload(gem_ones)

func _physics_process(delta: float) -> void:
	# var colliding = false
	var colliding_body

	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimatedSprite2D.animation = "jump"

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor():
		if velocity.x == 0:
			$AnimatedSprite2D.animation = "stand"
		else:
			$AnimatedSprite2D.animation = "walk"
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		
	if ray_cast_up.is_colliding():
		print("being ridden")
		colliding_body = ray_cast_up.get_collider()
		if colliding_body and colliding_body is CharacterBody2D and colliding_body.velocity.y >= 0:  
			colliding_body.get_parent().remove_child(colliding_body)
			self.add_child(colliding_body)
			colliding_body.position = $CarryPosition.position

			colliding_body.state = "ride"
			colliding_body.collision_layer = 0  # Disable collision with the player

	move_and_slide()

	for child in get_children():
		if child is CharacterBody2D:
			#print("set position")
			child.position = $CarryPosition.position
			break
		
	
func get_preload(num):
	match num:
		0:
			return preload("res://assets/HUD/hud_0.png")
		1:
			return preload("res://assets/HUD/hud_1.png")
		2:
			return preload("res://assets/HUD/hud_2.png")
		3:
			return preload("res://assets/HUD/hud_3.png")
		4:
			return preload("res://assets/HUD/hud_4.png")
		5:
			return preload("res://assets/HUD/hud_5.png")
		6:
			return preload("res://assets/HUD/hud_6.png")
		7:
			return preload("res://assets/HUD/hud_7.png")
		8:
			return preload("res://assets/HUD/hud_8.png")
		9:
			return preload("res://assets/HUD/hud_9.png")
