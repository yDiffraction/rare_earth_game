extends Control

@onready var list = $VBoxContainer
var EntryScene := preload("res://Scenes/RareEarthScoreboardEntry.tscn")

#name, necessary import (t), current import (t)
var earthList = [
	["NdPr", 1500, 0], #china:10.000t Australien:1.000t USA:1.000t
	["DyTb", 30, 0], #china:1500t japan:100t vietnam:50t(bisschen teurer) myanmar:1000t(sehr teuer)
	["LaCe", 4000, 0], #china:20.000t russland:10.000t
	["Sm", 125, 0], # usa:200t china:150t indien:150t
	["ScY", 150, 0], #china:3000t thailand:500t
	["Sonstige", 100, 0] #uae: 100t nigeria:100t south africa:100t peru:100t 
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
