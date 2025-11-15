extends Panel
@onready var CountryLabel = $CountryLabel
@onready var ExportLabel = $ExportLabel
var current
var Country
var locked = false

func showInfo(country):
	current = country
	self.visible = true
	print_debug(country)
	Country = matchName(current.name)
	print_debug(Country)
	if !locked:
		CountryLabel.text = Country.Name
		ExportLabel.text = "Export: " + str(Country.Export) + "T"
	
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
