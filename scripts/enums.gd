extends Node

class_name Enums

enum States { STAND, WALK, JUMP, RIDE, HURT, DEAD_ACTIVE, DEAD_INACTIVE, TPOSE }
enum Inputs {LEFT, RIGHT, JUMP}

static func get_state_string(state):
	match state:
		States.STAND:
			return "stand"
		States.WALK:
			return "walk"
		States.JUMP:
			return "jump"
		States.RIDE:
			return "ride"
		States.HURT:
			return "hurt"
		States.DEAD_ACTIVE:
			return "dead_active"
		States.DEAD_INACTIVE:
			return "dead_inactive"
		States.TPOSE:
			return "tpose"
