extends Node
@export var Countrys: Array[CountryInfo]
@export var AllEvents: Array[Events]

func statChange(Target:String, Stat:String, Effekt:float):
	var targetCountry
	var targetStat
	for c in Countrys:
		if c.Name == Target:
			targetCountry = c
	for expo in targetCountry.Exports:
		if expo[0] == Stat:
			targetStat = expo
	targetStat[2] = Effekt * targetStat[2]
	
func statAdd(Target:String, Stat:String, Effekt:float):
	var targetCountry
	for c in Countrys:
		if c.Name == Target:
			targetCountry = c
	var newStat :Array[Variant] = [Stat, 0, Effekt]
	targetCountry.Exports.push_back(newStat)

func statDelete(Target:String, Stat:String, _Effekt:float):
	var targetCountry
	for c in Countrys:
		if c.Name == Target:
			targetCountry = c
	for expo in targetCountry.Exports:
		if expo[0] == Stat:
			targetCountry.Exports.erase(expo)
	
func DeleteAll(Target:String, _Stat:String, _Effekt:float):
	var targetCountry
	for c in Countrys:
		if c.Name == Target:
			targetCountry = c
	targetCountry.Exports.clear()
	
func MultiplyAll(Target:String, _Stat:String, Effekt:float):
	var targetCountry
	for c in Countrys:
		if c.Name == Target:
			targetCountry = c
	for expo in targetCountry.Exports:
		expo[2] = Effekt * expo[2]

func MultiplyAllPrices(Target:String, _Stat:String, Effekt:float):
	var targetCountry
	for c in Countrys:
		if c.Name == Target:
			targetCountry = c
	for expo in targetCountry.Exports:
		expo[3] = Effekt * expo[3]
		
func MultiplyPrice(Target:String, Stat:String, Effekt:float):
	var targetCountry
	var targetStat
	for c in Countrys:
		if c.Name == Target:
			targetCountry = c
	for expo in targetCountry.Exports:
		if expo[0] == Stat:
			targetStat = expo
	targetStat[3] = Effekt * targetStat[3]
