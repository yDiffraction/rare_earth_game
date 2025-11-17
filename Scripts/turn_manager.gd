extends Node
@onready var Eventpopup :=  preload("res://Scenes/event_popup.tscn")
@onready var InfoPannel = $"../InfoPannel"
@onready var RareEarthScoreboard = $"../Scoreboard/RareEarths"
var rng = RandomNumberGenerator.new()

@onready var zustimmungEvent = preload("res://Events/zuunzufrieden.tres")
@export var earthList = [
	["NdPr", 0], #china:10.000t Australien:1.000t USA:1.000t
	["DyTb", 0], #china:1500t japan:100t vietnam:50t(bisschen teurer) myanmar:1000t(sehr teuer)
	["LaCe", 0], #china:20.000t russland:10.000t
	["Sm", 0], # usa:200t china:150t indien:150t
	["ScY", 0], #china:3000t thailand:500t
	["Sonstige", 0] #uae: 100t nigeria:100t south africa:100t peru:100t 
]
var wirtschaftMultiplier = [
	["NdPr", 1],
	["DyTb", 1],
	["LaCe", 1],
	["Sm", 1],
	["ScY", 1],
	["Sonstige", 1]
]

func _ready():
	calc_year(true)

func EndTurn():
	print_debug("Jahrvorbei")
	InfoPannel.hideInfo(true) #notwendig weil ich schlecht gecoded hab
	calc_year()
	print(earthList)
	
	#Momentane Wirtschaft - Ausgaben + Gewinn kalkuliert aus deckung der einzelnen Bedarfe
	#Änderung der zufriedenHeit, augehend vom Handelsvolumen der Länder

func calc_year(setup=false):
	var sumHandel = 0
	var SumAnsehen = 0
	var sumAusgaben = 0
	for i in range(len(earthList)):
		earthList[i][1] = 0
	for c in DataLoader.Countrys:
		for i in range(len(c.Exports)):
			for i2 in range(len(earthList)):
				if c.Exports[i][0]==earthList[i2][0]:
					sumHandel +=  c.Exports[i][1] * wirtschaftMultiplier[i2][1]
					SumAnsehen +=  c.Exports[i][1] * c.Ansehen
					sumAusgaben +=  c.Exports[i][1] * c.Exports[i][3]
					earthList[i2][1] += c.Exports[i][1]
	RareEarthScoreboard.update_scoreboard(earthList)
	InfoPannel.new_turn()
	if setup:
		return
	if sumHandel != 0:
		$"../Scoreboard".zufriedenheit = 25 * (SumAnsehen/sumHandel)
		print_debug(SumAnsehen/sumHandel)
		$"../Scoreboard".update_scoreboard()
	if $"../Scoreboard".zufriedenheit < 20:
		var eventPopup = Eventpopup.instantiate()
		var currentEvent = zustimmungEvent
		eventPopup.Name = currentEvent.Name
		eventPopup.Description = currentEvent.Beschreibung
		add_child(eventPopup)
	else:
		RandomEvent()
	

func _on_play_button_pressed() -> void:
	EndTurn()


func _on_debugevent_button_pressed() -> void:
	RandomEvent()
	
func RandomEvent():
	var eventPopup = Eventpopup.instantiate()
	var currentEvent = DataLoader.AllEvents[randi_range(0, DataLoader.AllEvents.size() -1)]
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
			currentEvent.Ef.SetAnsehen:
				DataLoader.SetAnsehen(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
			currentEvent.Ef.ChangeAnsehen:
				DataLoader.ChangeAnsehen(currentEvent.Land[i], currentEvent.Stat[i], currentEvent.Effekt[i])
	DataLoader.AllEvents.erase(currentEvent)
