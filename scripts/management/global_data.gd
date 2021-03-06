extends Node

const GRID_SIZE: Vector2 = Vector2(16, 16)

var player_skin_data: Dictionary = { #placeholder info, change later
	"idle": [
		"res://assets/character/idle/base.png",      #base
		"res://assets/character/idle/tool.png",      #tool
		"res://assets/character/idle/hair/bowl.png"  #hair
	],
	
	"walk": [
		"res://assets/character/walk/base.png",
		"res://assets/character/walk/tool.png",
		"res://assets/character/walk/hair/bowl.png"
	],
	
	"run": [
		"res://assets/character/run/base.png",
		"res://assets/character/run/tool.png",
		"res://assets/character/run/hair/bowl.png"
	],
	
	"dig": [
		"res://assets/character/dig/base.png",
		"res://assets/character/dig/tool.png",
		"res://assets/character/dig/hair/bowl.png"
	],
	
	"axe": [
		"res://assets/character/axe/base.png",
		"res://assets/character/axe/tool.png",
		"res://assets/character/axe/hair/bowl.png"
	],
	
	"mining": [
		"res://assets/character/mine/base.png",
		"res://assets/character/mine/tool.png",
		"res://assets/character/mine/hair/bowl.png"
	],
	
	"attack": [
		"res://assets/character/attack/base.png",
		"res://assets/character/attack/tool.png",
		"res://assets/character/attack/hair/bowl.png"
	]
}
