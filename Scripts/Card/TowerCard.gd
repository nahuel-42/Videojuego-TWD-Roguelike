extends ActiveCard
class_name TowerCard


#func _init(id, cardName, description, sprite, cost, active, type, range, damage, attackSpeed, presition):
#	super._init(id, cardName, description, sprite, cost, active, type, range, damage, attackSpeed, presition)

func use(param):
	var slot = param
	print("Se usa TowerCard")
	slot.use(m_idCard)
	#se usa la carta y se colocan en un array del mapa
