class_name DirectDropTarget
extends Area2D

signal item_received(payload: Variant, source: DirectDraggableItem)

@export var accepted_tag: StringName = &"ingredient"
@export var enabled: bool = true


func accepts(item: DirectDraggableItem) -> bool:
	if not enabled:
		return false
	return accepted_tag == &"" or item.drag_tag == accepted_tag


func try_receive(item: DirectDraggableItem) -> bool:
	if not accepts(item):
		return false

	item_received.emit(item.get_interaction_payload(), item)
	return true
