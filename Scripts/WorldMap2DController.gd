extends Control

@onready var countries_container = $WorldMap/CountriesContainer
@onready var highlight_poly :=  preload("res://Scenes/highlight_polygon.tscn")
@onready var InfoPanel = $InfoPannel
@onready var TradeRouteDisplay = $TradeRoute
var current_country

var currenthighlights: Array[Node]
func _ready():
	# connect mouse signals for each country polygon
	for country in countries_container.get_children():
		if country is Area2D:
			country.connect("mouse_entered", Callable(self, "_on_country_mouse_entered").bind(country))
			country.connect("mouse_exited", Callable(self, "_on_country_mouse_exited").bind(country))

func _input(event):
	if(event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and current_country != null):
		if InfoPanel.locked:
			InfoPanel.locked = false
			InfoPanel.hideInfo()
			InfoPanel.showInfo(current_country)
		InfoPanel.locked = true
func _on_country_mouse_entered(country):
	#var collision_poly = country.get_node("CollisionPolygon2D")
	#var poly = collision_poly.polygon
	#highlight_poly.polygon = poly
	#highlight_poly.visible = true
	current_country  = country
	for poligon in country.get_children():
		var highlight = highlight_poly.instantiate()
		add_child(highlight)
		highlight.polygon = poligon.polygon
		currenthighlights.append(highlight)
		
	
	
	InfoPanel.showInfo(country)
	TradeRouteDisplay.visible = true
	TradeRouteDisplay.points = InfoPanel.country_data.Path

func _on_country_mouse_exited(country):
	#highlight_poly.visible = false
	current_country = null
	for node in currenthighlights:
		node.queue_free()
		currenthighlights = []
	TradeRouteDisplay.visible = false
	
	InfoPanel.hideInfo()
