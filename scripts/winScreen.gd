extends Node

@onready var green_tens: TextureRect = $Green/Tens
@onready var green_ones: TextureRect = $Green/Ones

@onready var blue_tens: TextureRect = $Blue/Tens
@onready var blue_ones: TextureRect = $Blue/Ones



func _ready() -> void:
	
	var green_gems = GlobalEngine.get_gems("green")
	var blue_gems = GlobalEngine.get_gems("blue")
	
	green_tens.texture = get_preload(green_gems / 10)
	green_ones.texture = get_preload(green_gems % 10)
	
	blue_tens.texture = get_preload(blue_gems / 10)
	blue_ones.texture = get_preload(blue_gems % 10)

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
