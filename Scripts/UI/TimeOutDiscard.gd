class_name  TimeOutDiscard
extends Node

@export var m_progressBar : TextureProgressBar = null
@export var m_colorBar : Color = Color.WHITE
@export var m_finishColorBar : Color = Color.YELLOW

func SetValue(value : float):
	m_progressBar.value = value
	m_progressBar.tint_progress = m_finishColorBar if (value >= 1.0) else m_colorBar
