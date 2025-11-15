extends Panel
@onready var CountryLabel = $CountryLabel
@onready var ExportLabel = $ExportLabel
var current

func showInfo(country):
	current = country
	self.visible = true
	print_debug(country)
	var Country = DataLoader.Countrys[DataLoader.Countrys.find_custom(matchName)]
	print_debug(Country)
	CountryLabel.text = Country.Name
	ExportLabel.text = "Export: " + str(Country.Export) + "T"
	
func hideInfo():
	self.visible = false

func _ready() -> void:
	hideInfo()
	
func matchName(name):
	if(name.Name == current.name):
		return true
