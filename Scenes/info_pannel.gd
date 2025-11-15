extends Panel
@onready var CountryLabel = $CountryLabel
@onready var ExportLabel = $ExportLabel
var current
var Country

func showInfo(country):
	current = country
	self.visible = true
	print_debug(country)
	Country = matchName(current.name)
	print_debug(Country)
	CountryLabel.text = Country.Name
	ExportLabel.text = "Export: " + str(Country.Export) + "T"
	
func hideInfo():
	self.visible = false

func _ready() -> void:
	hideInfo()
	
func matchName(name):
	for c in DataLoader.Countrys:
		if c.Name == name:
			return c
