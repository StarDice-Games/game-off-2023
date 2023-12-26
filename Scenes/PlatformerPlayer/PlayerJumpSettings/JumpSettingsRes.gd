extends Resource
class_name JumpSettingsResource

@export_category("Movement")
@export var GROUND_SPEED = 300.0
@export var AIR_SPEED = 300.0
@export var ACCELERATION: float = 30
@export var FRICTION: float = 50
@export_category("Jump")
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@export var coyote_time : float = 0.5
