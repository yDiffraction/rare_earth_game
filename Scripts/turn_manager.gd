extends Node
@onready var Eventpopup :=  preload("res://Scenes/event_popup.tscn")
func EndTurn():
	print_debug("Jahrvorbei")
	pass
	
	#Momentane Wirtschaft - Ausgaben + Gewinn kalkuliert aus deckung der einzelnen Bedarfe
	#Änderung der zufriedenHeit, augehend vom Handelsvolumen der Länder


func _on_play_button_pressed() -> void:
	EndTurn()


func _on_debugevent_button_pressed() -> void:
	var eventPopup = Eventpopup.instantiate()
	var currentEvent = DataLoader.AllEvents[randi_range(0, DataLoader.AllEvents.size() - 1)]
	eventPopup.Name = currentEvent.Name
	eventPopup.Description = currentEvent.Beschreibung
	add_child(eventPopup)
	for i in currentEvent.Land.size():
		match currentEvent.Effekttyp[i]:
			currentEvent.Ef.Multiply:
				print_debug("DataLoader.statChange(" + currentEvent.Land[i] + ", " + currentEvent.Stat[i] + ", " + str(currentEvent.Effekt[i]) +")")
				#call("DataLoader.statChange(" + str(currentEvent.Land[i]) + ", " + str(currentEvent.Stat[i]) + ", " + str(currentEvent.Effekt[i]) +")")
				DataLoader.statChange(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
			currentEvent.Ef.Add:
				DataLoader.statAdd(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
			currentEvent.Ef.Delete:
				DataLoader.statDelete(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
			currentEvent.Ef.DeleteAll:
				DataLoader.DeleteAll(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
			currentEvent.Ef.MultiplyAll:
				DataLoader.MultiplyAll(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
			currentEvent.Ef.MultiplyAllPrices:
				DataLoader.MultiplyAllPrices(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
			currentEvent.Ef.MultiplyPrice:
				DataLoader.MultiplyPrice(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
