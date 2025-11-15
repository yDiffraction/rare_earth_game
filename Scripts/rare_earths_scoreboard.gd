extends Control

@onready var list = $VBoxContainer
var EntryScene := preload("res://Scenes/RareEarthScoreboardEntry.tscn")

#name, necessary import (t), current import (t)
var earthList = [
	["Neodym", 1000, 0],
	["Praseodym", 400, 0],
	["Dysprosium", 25, 0],
	["Terbium", 5, 0],
	["Lanthan", 1250, 0],
	["Cer", 2500, 0],
	["Yttrium", 100, 0],
	["Samarium", 125, 0],
	["Scandium", 15, 0],
	["Gadolinium", 30, 0],
	["Eu,Ho,Er,Tm,Yb,Lu", 50, 0]
]
var nodes = {}

func add_earth(name: String, value: float, max_value: float):
	var entry = EntryScene.instantiate()
	entry.get_node("Label").text = "%s: %dt" % [name, value]
	var bar = entry.get_node("ProgressBar")
	bar.max_value = max_value
	bar.value = value

	list.add_child(entry)
	nodes[name] = entry

func _ready():
	for i in earthList:
		i[2] = float(i[1]) * 0.75
		add_earth(i[0], i[2], i[1])
