class_name GameEvents
extends RefCounted

############################################################
static var e_onLoadBoard = []

static func OnLoadBoard_AddListener(call):
	e_onLoadBoard.append(call)
	
static func OnLoadBoard_Call(cardsList):
	for f in e_onLoadBoard:
		f.call(cardsList)
		
############################################################
static var e_onLoadDiscard = []

static func OnLoadDiscard_AddListener(call):
	e_onLoadDiscard.append(call)
	
static func OnLoadDiscard_Call(cardsList): #aca se deberia trabajar la creación de las cartas
	for f in e_onLoadDiscard:
		f.call(cardsList)
############################################################
