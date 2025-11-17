extends Control
@onready var zufriedenheit_icon = $ZufriedenheitIcon
@onready var zufriedenheit_label = $Zufriedenheit
@onready var zufriedenheit_bar   = $ZufriedenheitBar
@onready var wirtschaft_label = $Wirtschaft
@onready var wirtschaft_bar   = $WirtschaftBar

var zufriedenheit: int = 0
var max_zufriedenheit: int = 100
var wirtschaft: int = 0
var max_wirtschaft: int = 100

@onready var happy = preload("res://assets/Happy.png")
@onready var semihappy = preload("res://assets/SemiHappy.png")
@onready var unhappy = preload("res://assets/Unhappy.png")

func _ready():
	update_scoreboard()

func add_zufriedenheit(amount: int):
	zufriedenheit = clamp(zufriedenheit + amount, 0, max_zufriedenheit)
	update_scoreboard()

func add_wirtschaft(amount: int):
	wirtschaft = clamp(wirtschaft + amount, 0, max_wirtschaft)
	update_scoreboard()

func update_scoreboard():
	zufriedenheit = clamp(zufriedenheit, 0, 100)
	wirtschaft = clamp(wirtschaft, 0, 100)
	zufriedenheit_label.text = "Zufriedenheit: %s" % zufriedenheit + "%"
	zufriedenheit_bar.value = zufriedenheit
	if zufriedenheit >= 75:
		zufriedenheit_icon.texture = happy
	elif zufriedenheit <= 25:
		zufriedenheit_icon.texture = unhappy
	else:
		zufriedenheit_icon.texture = semihappy
	wirtschaft_label.text = "Wirtschaft: %s" % wirtschaft + "%"
	wirtschaft_bar.value = wirtschaft

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		add_zufriedenheit(5)
		add_wirtschaft(5)
	if Input.is_action_just_pressed("ui_down"):
		add_zufriedenheit(-5)
		add_wirtschaft(-5)
