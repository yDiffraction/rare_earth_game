extends Node
func EndTurn():
	print_debug("Jahrvorbei")
	pass
	
	#Momentane Wirtschaft - Ausgaben + Gewinn kalkuliert aus deckung der einzelnen Bedarfe
	#Änderung der zufriedenHeit, augehend vom Handelsvolumen der Länder


func _on_play_button_pressed() -> void:
	EndTurn()
