class_name Events
extends Resource

@export var Name: String
@export var Beschreibung: String
@export_category("Effekt:")
@export var Land : Array[String]
@export var Effekttyp: Array[Ef]
enum Ef {Multiply, Add, Delete, MultiplyAll, DeleteAll, MultiplyPrice, MultiplyAllPrices}
var item_type : String = "Effekt"


@export var Stat : Array[String]
@export var Effekt : Array[float]
