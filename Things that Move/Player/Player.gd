extends KinematicBody2D

var velocity = Vector2(0, 0)
var gravity = 4000
var jump_speed = -1800
var speed = 1200

func get_input():
	if Input.is_action_just_pressed("left"):
		velocity.y -= speed
	if Input.is_action_just_pressed("right"):
		velocity.y += speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	
	if velocity.y < 100:
		if Input.is_action_pressed("left"):
			self.flip_h = true
			$AnimatedSprite.play("walking")
		else:
			self.flip_h = true
			$AnimatedSprite.play("sliding")
	if velocity.y > 100:
		if Input.is_action_pressed("right"):
			self.flip_h = false
			$AnimatedSprite.play("walking")
		else:
			self.flip_h = false
			$AnimatedSprite.play("sliding")
	if velocity.x != 0:
		$AnimatedSprite.play("jumping")
	
	if Input.is_action_just_pressed("crawl"):
		$AnimatedSprite.play("crawling")
		$Standard.disabled = true
		$Crawling.disabled = false
	else:
		$Standard.disabled = false
		$Crawling.disabled = true
