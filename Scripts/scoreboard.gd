extends Control

@onready var zufriedenheit_label = $Zufriedenheit
@onready var zufriedenheit_bar   = $ZufriedenheitBar
@onready var wirtschaft_label = $Wirtschaft
@onready var wirtschaft_bar   = $WirtschaftBar

var zufriedenheit: int = 0
var max_zufriedenheit: int = 100
var wirtschaft: int = 0
var max_wirtschaft: int = 100

func _ready():
	update_scoreboard()

func add_zufriedenheit(amount: int):
	zufriedenheit = clamp(zufriedenheit + amount, 0, max_zufriedenheit)
	update_scoreboard()

func add_wirtschaft(amount: int):
	wirtschaft = clamp(wirtschaft + amount, 0, max_wirtschaft)
	update_scoreboard()

func update_scoreboard():
	zufriedenheit_label.text = "Zufriedenheit: %s" % zufriedenheit + "%"
	zufriedenheit_bar.value = zufriedenheit
	wirtschaft_label.text = "Wirtschaft: %s" % wirtschaft + "%"
	wirtschaft_bar.value = wirtschaft

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		add_zufriedenheit(5)
		add_wirtschaft(5)
	if Input.is_action_just_pressed("ui_down"):
		add_zufriedenheit(-5)
		add_wirtschaft(-5)
