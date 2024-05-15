class_name GameEvents
extends RefCounted

############################################################
static var OnLoadBoard = Action.new()
############################################################
static var OnLoadDiscard = Action.new()
############################################################
static var OnGetSlotDetector = Func.new()
############################################################
static var OnAddCardsInGame = Action.new()
static var OnSwapCardsInGame = Action.new()
