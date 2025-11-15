extends Control
@onready var NameLabel = $PanelContainer/VBoxContainer/Label
@onready var DescriptionLabel = $PanelContainer/VBoxContainer/HBoxContainer/Label2

@onready var Name
@onready var Description

func _on_button_pressed() -> void:
	queue_free()

func _ready() -> void:
	NameLabel.text = Name
	DescriptionLabel.text = Description
