class_name UI_funcs
extends RefCounted

static func SetParent(parent, node: Control, keepPosition = false):
	var pos = node.global_position
	if (node.get_parent() != null):
		node.get_parent().remove_child(node)
	if (parent != node.get_parent()):
		parent.add_child(node)
	if (keepPosition):
		node.global_position = pos

static func LocateCard(parent, node : Control, keepPosition = false):
	SetParent(parent, node, keepPosition)
	node.set_anchors_preset(Control.PRESET_FULL_RECT)
	node.anchor_left = 0.0
	node.anchor_right = 1.0
	node.anchor_top = 0.0
	node.anchor_bottom = 1.0
	
	node.offset_left = 0
	node.offset_right = 0
	node.offset_top = 0
	node.offset_bottom = 0
