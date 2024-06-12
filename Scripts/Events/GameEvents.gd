class_name GameEvents
extends RefCounted

#In Game Events
############################################################
static var OnSpellCardActivated = Action.new()
############################################################

############################################################
################     UI EVENTS     #########################
############################################################
static var OnLoadBoard = Action.new()
static var OnLoadDiscard = Action.new()
static var OnRestartDeck = Action.new()
############################################################
static var OnGetSlotDetectorUI = Func.new()
static var OnGetSpellDetectorUI = Func.new()
static var OnGetPassiveDetectorUI = Func.new()
############################################################
static var OnShowPopCards = Action.new()
static var OnShowPopupSpeciality = Action.new()
############################################################
static var OnAddCardsInGame = Action.new()
static var OnSwapCardsInGame = Action.new()
static var OnRemoveBoardCards = Action.new()
############################################################
static var OnUpdateMana = Action.new()
static var OnUpdateHealth = Action.new()
############################################################
static var OnHideBoard = Action.new()
############################################################
static var OnPlayMovementCard = Action.new()
static var OnPlayUsedCard = Action.new()
############################################################
static var OnSetNotVisible = Action.new()
