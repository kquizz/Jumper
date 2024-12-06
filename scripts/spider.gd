extends Node2D

const SPEED = 60
const GRAVITY = 30

@onready var ray_cast_right: RayCast2D = $RayCast_Right
@onready var ray_cast_left: RayCast2D = $RayCast_Left
@onready var ray_cast_down_left: RayCast2D = $RayCast_Down_Left
@onready var ray_cast_down_right: RayCast2D = $RayCast_Down_Right
@onready var ray_cast_down: RayCast2D = $RayCast_Down

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

enum MovingDirection { LEFT, RIGHT, FALLING }
enum FeetFacingDirection { UP, DOWN, LEFT, RIGHT }

var moving_direction: MovingDirection
var feet_facing_direction: FeetFacingDirection

var moving_direction_prev : MovingDirection = MovingDirection.FALLING
var feet_facing_direction_prev : FeetFacingDirection = FeetFacingDirection.DOWN
var ray_cast_left_prev : bool = false
var ray_cast_right_prev: bool = false
var ray_cast_down_left_prev: bool = false
var ray_cast_down_right_prev: bool = false
var ray_cast_down_prev: bool = false

func _ready() -> void:
	moving_direction = MovingDirection.FALLING
	feet_facing_direction = FeetFacingDirection.DOWN

func _physics_process(delta: float) -> void:
	var direction_vector = Vector2()
	var angle = deg_to_rad(self.rotation_degrees)


	match moving_direction:
		MovingDirection.FALLING:
			position.y += GRAVITY * delta

			if ray_cast_down.is_colliding():
				moving_direction = MovingDirection.LEFT

		MovingDirection.LEFT:
			if animated_sprite.flip_h != false:
				animated_sprite.flip_h = false
			direction_vector = Vector2(-cos(angle), -sin(angle))
			position += direction_vector * SPEED * delta
			
			if ray_cast_left.is_colliding():
				self.rotation_degrees += 90

			if not ray_cast_down_left.is_colliding() and not ray_cast_down_right.is_colliding():
				self.rotation_degrees -= 90
				
				var down_angle = deg_to_rad(self.rotation_degrees + 90)
				var down_vector = Vector2(cos(down_angle), sin(down_angle))
				
				position += down_vector * 5

		MovingDirection.RIGHT:
			if animated_sprite.flip_h != true:
				animated_sprite.flip_h = true
			
			direction_vector = Vector2(cos(angle), sin(angle))
			position += direction_vector * SPEED * delta
			
			if ray_cast_right.is_colliding():
				self.rotation_degrees -= 90

			if not ray_cast_down_left.is_colliding() and not ray_cast_down_right.is_colliding():
				self.rotation_degrees += 90
				
				var down_angle = deg_to_rad(self.rotation_degrees + 90)
				var down_vector = Vector2(cos(down_angle), sin(down_angle))
				
				position += down_vector * 5
