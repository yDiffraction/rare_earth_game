extends Node2D

@export var deathParticle : PackedScene
@export var speed: float = 400.0
var target: Vector2 = Vector2.ZERO

func _process(delta):
	# Move in the direction set when spawned
	if target == Vector2.ZERO:
		return
	var direction = (target - position).normalized()
	
	if (direction * speed * delta).abs() >= (target-position).abs():
		detonate()
	
	position += direction * speed * delta
	
	rotation = direction.angle()

func detonate():
	var particle = deathParticle.instantiate()
	particle.position = global_position
	particle.rotation = global_rotation
	particle.emitting = true
	get_tree().current_scene.add_child(particle)
	
	queue_free()
