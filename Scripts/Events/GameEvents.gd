class_name GameEvents
extends RefCounted

############################################################
static var OnLoadBoard = Action.new()
############################################################
static var OnLoadDiscard = Action.new()
############################################################
static var OnGetSlotDetector = Func.new()
static var OnGetPowerDetector = Func.new()
static var OnGetPassiveDetector = Func.new()
############################################################
static var OnShowPopCards = Action.new()
############################################################
static var OnAddCardsInGame = Action.new()
static var OnSwapCardsInGame = Action.new()
static var OnRemoveBoardCards = Action.new()
