extends Spatial

var batteryTime = 300
var batteryTimeFull = 300
var batteryTimePercent = 100
var lightPower setget setLightPower
onready var flashlight = $SpotLight
signal batteryStatus

func setLightPower(value):
	flashlight.light_energy = value

func recharge():
	batteryTime = 300

func _process(delta):
	batteryTime -= delta
	if batteryTime > 60:
		setLightPower(18)
	elif batteryTime < 60:
		setLightPower(6)
	elif batteryTime < 0:
		setLightPower(0)

	batteryTimePercent = (batteryTime / batteryTimeFull) * 100
	
	emit_signal("batteryStatus", int(round(batteryTimePercent)))
	
	
