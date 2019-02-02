extends Camera2D

var screen_margin_right
var screen_margin_left
var screen_margin_bottom
var screen_margin_top

func _ready():
	refresh_parameters()

# if viewport screen size or drag_margin... are changed, 
#     then need to call update_parameters()
func refresh_parameters():
	var half_screen = get_viewport().size / 2
	screen_margin_right = half_screen.x*drag_margin_right
	screen_margin_left = -half_screen.x*drag_margin_left
	screen_margin_bottom = half_screen.y*drag_margin_bottom
	screen_margin_top = -half_screen.y*drag_margin_top

func notify_character_position(char_global_pos):
	var dif
	
	dif = char_global_pos.x - (global_position.x + screen_margin_right)
	if dif > 0:
		global_position.x += dif
		align()
	else:
		dif = char_global_pos.x - (global_position.x + screen_margin_left)
		if dif < 0:
			global_position.x += dif
			align()

	dif = char_global_pos.y - (global_position.y + screen_margin_bottom)
	if dif > 0:
		global_position.y += dif
		align()
	else:
		dif = char_global_pos.y - (global_position.y + screen_margin_top)
		if dif < 0:
			global_position.y += dif
			align()
