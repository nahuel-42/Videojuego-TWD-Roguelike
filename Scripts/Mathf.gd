class_name Mathf
extends RefCounted

static func Lerp(a : Vector2, b : Vector2, t : float):
	return a + (b - a) * t
