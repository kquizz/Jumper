extends Node

class_name GameEngine
# enum Colors {BLUE, YELLOW, GREEN, RED}
var colors = ["blue", "yellow", "green", "red"]

var stages = ["1-1"]

@export var level = 0

@onready var green_player: CharacterBody2D = $"../Players/Green Player"
@onready var blue_player: CharacterBody2D = $"../Players/Blue Player"


var keys = {}
var gems = {}
var flags = {}

func _ready():
	for color in colors:
		keys[color] = 0
		gems[color] = 0
		flags[color] = 0

func add_key(color): keys[color] += 1
func add_gem(color): gems[color] += 1
func add_flag(color): flags[color] += 1

func get_gems(color): return gems[color]
	
func has_key(color): return keys[color] > 0

func remove_key(color):
	if keys[color] > 0:
		keys[color] -= 1

func check_level_finished(color):
	add_flag(color)

	if flags["blue"] >= 1 and flags["green"] >= 1:
		level += 1

		if level >= stages.size():
			get_tree().change_scene_to_file("res://scenes/stages/win_screen.tscn")
		else: 
			get_tree().change_scene_to_file("res://scenes/stages/Stage"+stages[level]+".tscn")
	else:
		return false
