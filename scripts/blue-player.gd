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

#var physics = true
var state = "stand"
var max_height = 200

func _ready() -> void:
	color = self.name.replace(" Player", "").to_lower()
	update_hud()
	ray_cast_up.enabled = true
	ray_cast_down.enabled = true

func update_hud() -> void:
	if color == "blue":
		return
	if engine.keys[color] > 0:
		key_icon_disabled.hide()
		key_icon_enabled.show()
	else:
		key_icon_enabled.hide()
		key_icon_disabled.show()

	var gem_tens = engine.gems[color] / 10
	var gem_ones = engine.gems[color] % 10
	
	gem_count_tens.texture = get_preload(gem_tens)
	gem_count_ones.texture = get_preload(gem_ones)
	

func _physics_process(delta: float) -> void:
	#print(position)
	if not ray_cast_down.is_colliding():
		velocity += get_gravity() * delta
		state = "jump"
		$AnimatedSprite2D.animation = "jump"
	else:
		if self.get_parent() is CharacterBody2D:
			state = "ride"
		else:
			state = "stand"
		

	if Input.is_action_just_pressed("p2_jump") and ray_cast_down.is_colliding():
		velocity.y = JUMP_VELOCITY
		
		print("jump pressed")
		print(state)
		
		if state == "ride":
			print("jumped off")
			
			var game = get_tree().get_root().get_node("Game")
			var parent = self.get_parent()
			
			parent.remove_child(self)
			game.add_child(self)
			self.global_position = parent.carry_position.global_position  # Update global position

			self.collision_layer = 1  # Enable collision with the player
		state = "jump"
		
	var direction := Input.get_axis("p2_move_left", "p2_move_right")
	if direction:
		velocity.x = direction * SPEED
		
		if state == "ride":
			var game = get_tree().get_root().get_node("Game")
			var parent = self.get_parent()
			parent.remove_child(self)
			game.add_child(self)
			self.global_position = parent.carry_position.global_position  # Update global position
			self.collision_layer = 1  # Enable collision with the player
		
		if state != "walk":
			state = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	$AnimatedSprite2D.animation = state
	
	if state != "ride":
		#print(state)
		move_and_slide()
	
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
