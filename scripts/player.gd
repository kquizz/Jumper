extends CharacterBody2D

enum States { STAND, WALK, JUMP, RIDE, HURT, DEAD_ACTIVE, DEAD_INACTIVE, TPOSE }
enum Inputs {LEFT, RIGHT, JUMP}

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -525.0

@onready var engine: Node = %Engine
var color : String
var original_parent = null
var can_be_carried = true
var state = States.STAND

@onready var carry_cooldown_timer: Timer = $CarryCooldownTimer

@onready var ray_cast_down: RayCast2D = $RayCast_down
@onready var ray_cast_up: RayCast2D = $RayCast_up
@onready var carry_position: Marker2D = $CarryPosition
@onready var hud: CanvasLayer = $HUD


func _ready() -> void:
	color = self.name.replace(" Player", "").to_lower()
	update_hud()
	original_parent = self.get_parent()

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
	if not ray_cast_down.is_colliding():
		velocity += get_gravity() * delta
		state = States.JUMP
	else:
		if self.get_parent() is CharacterBody2D:
			state = States.RIDE
		else:
			state = States.STAND

	if Input.is_action_just_pressed(color+"_jump") and ray_cast_down.is_colliding():
		velocity.y = JUMP_VELOCITY

		if state == States.RIDE:
			self_parent()
		state = States.JUMP

	var direction := Input.get_axis(color+"_move_left", color+"_move_right")
	if direction:
		velocity.x = direction * SPEED

		if state == States.RIDE:
			self_parent()
		
		if state != States.WALK:
			state = States.WALK
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		
	$AnimatedSprite2D.animation = str(state)
		
	if ray_cast_up.is_colliding():
		var colliding_body = ray_cast_up.get_collider()
		if colliding_body and colliding_body is CharacterBody2D and colliding_body.can_be_carried:
			carry_character(colliding_body)

	if state != States.RIDE:
		move_and_slide()

	for child in get_children():
		if child is CharacterBody2D:
			child.position = $CarryPosition.position
			break

func carry_character(body) -> void:
	body.reparent(self, false)
	body.position = $CarryPosition.position

	body.state = States.RIDE
	body.collision_layer = 2
	
func self_parent() -> void:
	self.global_position = self.get_parent().carry_position.global_position  # Update global position
	self.reparent(original_parent)
	self.collision_layer = 1  # Enable collision with the player
	can_be_carried = false
	carry_cooldown_timer.start()
	
func _on_carry_cooldown_timer_timeout() -> void:
	can_be_carried = true

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
