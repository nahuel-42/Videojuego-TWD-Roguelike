class_name GameEvents
extends RefCounted

############################################################
static var OnLoadBoard = Action.new()
############################################################
static var OnLoadDiscard = Action.new()
############################################################
static var OnGetSlotDetectorUI = Func.new()
static var OnGetSpellDetectorUI = Func.new()
static var OnGetPassiveDetectorUI = Func.new()
############################################################
static var OnShowPopCards = Action.new()
############################################################
static var OnAddCardsInGame = Action.new()
static var OnSwapCardsInGame = Action.new()
static var OnRemoveBoardCards = Action.new()
############################################################
static var OnUpdateMana = Action.new()
static var OnUpdateHealth = Action.new()
