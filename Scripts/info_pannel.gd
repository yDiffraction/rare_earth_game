extends Panel
@onready var CountryLabel = $CountryLabel
@onready var ExportLabel = $ExportLabel
var country
var country_data
var locked = false

func showInfo(country: Area2D):
	self.country = country
	self.visible = true
	print_debug(country)
	country_data = matchName(country.name)
	if !locked:
		CountryLabel.text = country_data.Name
		ExportLabel.text = "Export: " + str(country_data.Export) + "T"
	
func hideInfo():
	if !locked:
		self.visible = false

func _ready() -> void:
	hideInfo()
	
func matchName(name):
	for c in DataLoader.Countrys:
		if c.Name == name:
			return c


func _on_exit_button_pressed() -> void:
	locked = false
	hideInfo()
