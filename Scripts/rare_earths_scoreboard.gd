extends Control

@onready var list = $VBoxContainer
var EntryScene := preload("res://Scenes/RareEarthScoreboardEntry.tscn")

#name, necessary import (t), current import (t)
var earthList = [
	["NdPr", 1500, 0, "Wird für die Herstellung der meisten industriellen Magneten genutzt"], #china:10.000t Australien:1.000t USA:1.000t
	["DyTb", 30, 0, "Notwendig für die Temperaturfestigkeit von Magneten"], #china:1500t japan:100t vietnam:50t(bisschen teurer) myanmar:1000t(sehr teuer)
	["LaCe", 4000, 0, "Genutzt in der Batterie und Elektronikbranche"], #china:20.000t russland:10.000t
	["Sm", 125, 0, "Wichtig für spezielle Arten von Magneten"], # usa:200t china:150t indien:150t
	["ScY", 150, 0, "Benötigt für Lasertechnologien, Elektronik und verschiede Legierungen und Keramiken"], #china:3000t thailand:500t
	["Sonstige", 100, 0, "Genutzt für Elektronik sowie in verschiedensten Nichenindustrien"] #uae: 100t nigeria:100t south africa:100t peru:100t 
]
var nodes = {}

func update_scoreboard(earthList):
	for i in range(len(earthList)):
		self.earthList[i][2] = earthList[i][1]
		var node = nodes[earthList[i][0]]
		var label = node.get_node("Label")
		label.text = "%s: %dt" % [earthList[i][0], earthList[i][1]]
		var bar = node.get_node("ProgressBar")
		bar.value = earthList[i][1]

func update_partially(earthList):
	for i in range(len(earthList)):
		var node = nodes[earthList[i][0]]
		var bar2 = node.get_node("ProgressBar/ProgressBar")
		bar2.value = earthList[i][1]

func add_earth(name: String, value: float, max_value: float, tooltip: String):
	var entry = EntryScene.instantiate()
	var label = entry.get_node("Label")
	label.text = "%s: %dt" % [name, value]
	label.tooltip_text = tooltip
	var bar = entry.get_node("ProgressBar")
	bar.max_value = max_value
	bar.value = value
	var bar2 = entry.get_node("ProgressBar/ProgressBar")
	bar2.max_value = max_value
	bar2.value = value

	list.add_child(entry)
	nodes[name] = entry

func _ready():
	for i in earthList:
		i[2] = float(i[1]) * 0.75
		add_earth(i[0], i[2], i[1], i[3])
