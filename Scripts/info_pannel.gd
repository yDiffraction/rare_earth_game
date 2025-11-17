extends VBoxContainer
@onready var CountryLabel = $HBoxContainer/CountryLabel
@onready var list = $VBoxContainer
var EntryScene := preload("res://Scenes/ExportSelectorEntry.tscn")
var export_list
var country
var country_data
var locked = false
var nodes = []

func showInfo(country: Area2D, force=false):
	if !locked or force:
		self.country = country
		self.visible = true
		country_data = matchName(country.name)
		match country_data.Ansehen:
			0:
				CountryLabel.text = country_data.Name + " | --" 
			1:
				CountryLabel.text = country_data.Name + " | -" 
			2:
				CountryLabel.text = country_data.Name + " | O" 
			3:
				CountryLabel.text = country_data.Name + " | +" 
			4:
				CountryLabel.text = country_data.Name + " | ++" 
		_spawn_sliders(country_data.Exports)

func _spawn_sliders(export_list):
	if len(nodes)>0:
		return
	self.export_list = export_list
	for i in export_list:
		var entry = EntryScene.instantiate()
		entry.get_node("Label").text = "%s: %dt" % [i[0], i[1]] + " | " + str(i[3]) +"$pt"
		var slider = entry.get_node("MarginContainer/HSlider")
		slider.min_value = 0
		slider.max_value = i[2]
		slider.value = i[1]
		slider.step = 1

		list.add_child(entry)
		nodes.append(entry)

func _process(delta: float) -> void:
	if locked:
		for i in range(len(nodes)):
			var val = nodes[i].get_node("MarginContainer/HSlider").value
			nodes[i].get_node("Label").text = "%s: %dt" % [export_list[i][0], val] + " | " + str(export_list[i][3]) + "$pt"
			for c in range(len(DataLoader.Countrys)):
				if DataLoader.Countrys[c].Name == country_data.Name:
					DataLoader.Countrys[c].Exports[i][1] = val

func hideInfo(force=false):
	if !locked or force:
		self.visible = false
		for i in nodes:
			i.queue_free()
		nodes = []

func _ready() -> void:
	hideInfo()
	
func matchName(name):
	for c in DataLoader.Countrys:
		if c.Name == name:
			return c


func _on_exit_button_pressed() -> void:
	hideInfo(true)
	locked = false
