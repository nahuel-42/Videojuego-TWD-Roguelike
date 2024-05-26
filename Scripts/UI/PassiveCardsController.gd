extends Node

@export var m_hideCards: Control = null
@export var m_mainRef: Control = null

var m_hide:bool=true

func _on_button_hide_board_cards_button_down():
	if (m_hide==false):
		m_mainRef.anchor_top=0.0
		m_mainRef.anchor_bottom=1.0
		m_mainRef.anchor_left = 0.0
		m_mainRef.anchor_right = 1.0
		m_hide=true
	else:
		m_mainRef.anchor_top=m_hideCards.anchor_top
		m_mainRef.anchor_bottom=m_hideCards.anchor_bottom
		m_mainRef.anchor_left = m_hideCards.anchor_left 
		m_mainRef.anchor_right = m_hideCards.anchor_right
		m_hide=false
