extends Control

@onready var countries_container = $CountriesContainer
@onready var highlight_poly = countries_container.get_node("HighlightPolygon")

func _ready():
	# connect mouse signals for each country polygon
	for country in countries_container.get_children():
		if country is Area2D:
			country.connect("mouse_entered", Callable(self, "_on_country_mouse_entered").bind(country))
			country.connect("mouse_exited", Callable(self, "_on_country_mouse_exited").bind(country))

func _on_country_mouse_entered(country):
	var collision_poly = country.get_node("CollisionPolygon2D")
	var poly = collision_poly.polygon
	highlight_poly.polygon = poly
	highlight_poly.visible = true
	

func _on_country_mouse_exited(country):
	highlight_poly.visible = false
