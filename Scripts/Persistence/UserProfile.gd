class_name UserProfile

# Formato: [cartas, coins]
# cartas: {"id": id,"amount":-1} 
# amount : igual a -1 es que esta bloqueado, mayor o igual a 0 desbloqueado y su cantidad

var cardsList = []

#Direccion por defecto de la partida guardada
const m_user_save_path = "user_save"

##########################################
############  PUBLIC METHODS  ############
##########################################
func LoadDeck():
	var profile = Save.load_data(m_user_save_path)
	#var profile = null
	if (profile == null):
		_CreateDeck()
		Save.save_data(m_user_save_path, [cardsList])
	else:
		cardsList = profile[0]

#Devuelve 
func GetDeck(type : int):
	var typeDeck = GlobalCardsList.get_type(type)
	var referenceDeck = []
	
	for t in typeDeck:
		if (_GetUnlocked(t)):
			referenceDeck.append(t)
	return referenceDeck

#Agrega una carta al mazo del jugador, si esta desbloqueada agrega una a la cantidad
func AddCard(idCard : int):
	var i : int = 0
	while (i < len(cardsList) and idCard > cardsList[i][0]):
		i += 1
	if (i < len(cardsList) and idCard == cardsList[i][0]):
		cardsList[i][1] += 1
	else:
		cardsList.insert(i, [idCard, 1])
	
###########################################
############  PRIVATE METHODS  ############
###########################################
func _CreateDeck():
	var unlocked = GlobalCardsList.get_unlocked_cards()
	var list = []
	for u in unlocked:
		_AddCard(u)

func _AddCard(c):
	var i : int = 0
	while (i < len(cardsList) and c[0] > cardsList[i][0]):
		i += 1
	cardsList.insert(i, [c[0], 1 if c[1] else -1])		

func _GetUnlocked(id):
	var index : int = _FindCardIndex(id)
	return (index >= 0 and cardsList[index][1])

func _FindCardIndex(id) -> int:
	var i : int = 0
	var count : int = len(cardsList)
	while (i < count and cardsList[i][0] != id):
		i += 1
	return i if i < count else -1
	#var l : int = 0
	#var r : int = len(cardsList)
	#var m : int = (l+r)/2
	
	#while (l <= r and cardsList[m][0] != id):
	#	if (cardsList[m][0] < id):
	#		l = m + 1
	#	else:
	#		r = m - 1
	#	m = (l+r) / 2
	#		
	#return (l > r)
