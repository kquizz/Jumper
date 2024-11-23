extends Node

var level = 1

var gems = {
    "blue": 0,
    "green": 0,
    "red": 0,
    "yellow": 0,
    "beige": 0
}

func add_gems(color: String, amount: int) -> void:
    gems[color] += amount

func add_gems_from_hash(gems_hash: Dictionary) -> void:
    for color in gems_hash.keys():
        gems[color] += gems_hash[color]

func get_gems_count(color: String) -> int:
    return gems[color]

func get_level() -> int:
    return level

func next_level() -> int:
    level += 1
    return level
