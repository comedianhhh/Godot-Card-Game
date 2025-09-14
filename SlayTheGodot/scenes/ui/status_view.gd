class_name StatusView
extends Control

const STATUS_TOOLTIP = preload("res://scenes/ui/status_tooltip.tscn")

@onready var status_tooltips: VBoxContainer = %StatusTooltips

func _ready() -> void:
	for tooltip: StatusTooltip in status_tooltips.get_children():
		tooltip.queue_free()
		
	Events.status_tooltip_requested.connect(show_view)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and visible:
		hide_view()
	
func show_view(statuses: Array[Status]) -> void:
	for status in statuses:
		var status_tooltip: StatusTooltip = STATUS_TOOLTIP.instantiate()
		status_tooltips.add_child(status_tooltip)
		status_tooltip.status = status
	show()
	
func hide_view() -> void:	
	for tooltip: StatusTooltip in status_tooltips.get_children():
		tooltip.queue_free()
	hide()

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse") and visible:
		hide_view()
	

func _on_back_button_button_down() -> void:
	hide_view()
