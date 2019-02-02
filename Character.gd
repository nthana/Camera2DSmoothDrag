extends Node2D

func _process(delta):
	var direction = Vector2()
	if Input.is_key_pressed(KEY_UP):
		direction.y += -1
	if Input.is_key_pressed(KEY_DOWN):
		direction.y += 1
		
	if Input.is_key_pressed(KEY_LEFT):
		direction.x += -1
	if Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1
		
	direction = direction.normalized()
	var ds = direction * 400 * delta
	if ds != Vector2():
		translate(ds)
		$"../Camera2D".notify_character_position(self.global_position)

		
		
