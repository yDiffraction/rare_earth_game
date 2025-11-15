extends VBoxContainer
@onready var CountryLabel = $HBoxContainer/CountryLabel
@onready var list = $VBoxContainer
var EntryScene := preload("res://Scenes/ExportSelectorEntry.tscn")
var country
var country_data
var locked = false
var nodes = []

func showInfo(country: Area2D):
	self.country = country
	self.visible = true
	print_debug(country)
	country_data = matchName(country.name)
	if !locked:
		CountryLabel.text = country_data.Name
		_spawn_sliders(country_data.Exports)

func _spawn_sliders(export_list):
	for i in export_list:
		var entry = EntryScene.instantiate()
		entry.get_node("Label").text = "%s:" % i[0]
		var slider = entry.get_node("MarginContainer/HSlider")
		slider.min_value = 0
		slider.max_value = 0.5*i[1]+0.5*i[2]
		slider.value = i[1]
		slider.step = 1

		list.add_child(entry)
		nodes.append(entry)
	
func hideInfo():
	if !locked:
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
	locked = false
	hideInfo()
