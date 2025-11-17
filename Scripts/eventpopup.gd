extends Control
@onready var NameLabel = $PanelContainer/VBoxContainer/Label
@onready var DescriptionLabel = $PanelContainer/VBoxContainer/HBoxContainer/Label2

@onready var Name
@onready var Description
@onready var next: Callable

func _on_button_pressed() -> void:
	next.call()
	queue_free()

func _ready() -> void:
	NameLabel.text = Name
	DescriptionLabel.text = Description
	if next.is_null():
		next = func(): pass
