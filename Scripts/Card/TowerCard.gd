extends ActiveCard
class_name TowerCard


#func _init(id, cardName, description, sprite, cost, active, type, range, damage, attackSpeed, presition):
#	super._init(id, cardName, description, sprite, cost, active, type, range, damage, attackSpeed, presition)

func use(param):
	var slot = param[0]
	print("Se usa TowerCard")
	var id = slot.apply_card(m_idCard)
	if (id == -1):
		GameEvents.OnAddCardsInGame.Call([id])
	else:
		GameEvents.OnSwapCardsInGame.Call([id])
	#se usa la carta y se colocan en un array del mapa
