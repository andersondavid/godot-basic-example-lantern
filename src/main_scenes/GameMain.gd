extends Spatial
onready var flashlight = get_node("Player/PlayerControl/Flashlight")
onready var hud = get_node("Hud")

func _ready():
	flashlight.connect("batteryStatus", $Hud, "updateBatteryStatus")
