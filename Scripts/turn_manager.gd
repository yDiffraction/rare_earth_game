extends Node
@onready var Eventpopup :=  preload("res://Scenes/event_popup.tscn")
@onready var InfoPannel = $"../InfoPannel"
var earthList = [
	["NdPr", 0], #china:10.000t Australien:1.000t USA:1.000t
	["DyTb", 0], #china:1500t japan:100t vietnam:50t(bisschen teurer) myanmar:1000t(sehr teuer)
	["LaCe", 0], #china:20.000t russland:10.000t
	["Sm", 0], # usa:200t china:150t indien:150t
	["ScY", 0], #china:3000t thailand:500t
	["Sonstige", 0] #uae: 100t nigeria:100t south africa:100t peru:100t 
]

func EndTurn():
	print_debug("Jahrvorbei")
	InfoPannel.hideInfo(true) #notwendig weil ich schlecht gecoded hab
	calc_year()
	print(earthList)
	
	#Momentane Wirtschaft - Ausgaben + Gewinn kalkuliert aus deckung der einzelnen Bedarfe
	#Änderung der zufriedenHeit, augehend vom Handelsvolumen der Länder

func calc_year():
	for i in range(len(earthList)):
		earthList[i][1] = 0
	for c in DataLoader.Countrys:
		for i in range(len(c.Exports)):
			for i2 in earthList:
				if c.Exports[i][0]==i2[0]:
					i2[1] += c.Exports[i][1]
					c.Exports[i][1] = 0

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
