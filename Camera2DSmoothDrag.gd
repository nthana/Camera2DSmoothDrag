extends Camera2D

enum CameraMode {DRAG_MODE = 1, PRECISE_MODE, IGNORE_MODE}

export (CameraMode) var drag_mode_H = 1
export (CameraMode) var drag_mode_V = 1

# Usage:
# 1. attach this class under a Camera2D
# 2. the camera2D should be independent to the character
# 3. whenever the character's position is changed,
#     should call notify_character_position(character.global_position)
#        or notify_character_changed(character)

# External fields used:
#   drag_margin_left, drag_margin_right
#   drag_margin_top, drag_margin_bottom
# Assumption:
#   global_canvas_transform and canvas_transform's scales = (1,1)

var screen_margin_right
var screen_margin_left
var screen_margin_bottom
var screen_margin_top

func _ready():
	refresh_parameters()

# if the viewport size or drag_margin are changed, 
#     should call refresh_parameters()
func refresh_parameters():
	var half_screen = get_logical_viewport_size() / 2
	screen_margin_right = half_screen.x*drag_margin_right
	screen_margin_left = -half_screen.x*drag_margin_left
	screen_margin_bottom = half_screen.y*drag_margin_bottom
	screen_margin_top = -half_screen.y*drag_margin_top
	
func get_logical_viewport_size():
	var viewport = self.get_viewport()
	if !viewport.is_size_override_enabled():
		return viewport.size
	else:
		return viewport.get_size_override()

func notify_character_changed(character):
	notify_character_position(character.global_position)

func notify_character_position(char_global_pos):
	if !self.current:
		return

	var dif
	if drag_mode_H == DRAG_MODE:
		dif = char_global_pos.x - (global_position.x + screen_margin_right)
		if dif > 0:
			global_position.x += dif
			align()
		else:
			dif = char_global_pos.x - (global_position.x + screen_margin_left)
			if dif < 0:
				global_position.x += dif
				align()
	elif drag_mode_H == PRECISE_MODE:
		global_position.x = char_global_pos.x
		align()

	if drag_mode_V == DRAG_MODE:
		dif = char_global_pos.y - (global_position.y + screen_margin_bottom)
		if dif > 0:
			global_position.y += dif
			align()
		else:
			dif = char_global_pos.y - (global_position.y + screen_margin_top)
			if dif < 0:
				global_position.y += dif
				align()
	elif drag_mode_V == PRECISE_MODE:
		global_position.y = char_global_pos.y
		align()
