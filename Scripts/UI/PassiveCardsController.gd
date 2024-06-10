extends Node

@export var m_hideCards: Control = null
@export var m_mainRef: Control = null

var m_hide:bool=true

func ChangeHide(hide : bool):
	m_hide = hide
	if (m_hide==false):
		m_mainRef.anchor_top=0.0
		m_mainRef.anchor_bottom=1.0
		m_mainRef.anchor_left = 0.0
		m_mainRef.anchor_right = 1.0
	else:
		m_mainRef.anchor_top=m_hideCards.anchor_top
		m_mainRef.anchor_bottom=m_hideCards.anchor_bottom
		m_mainRef.anchor_left = m_hideCards.anchor_left 
		m_mainRef.anchor_right = m_hideCards.anchor_right
