extends Control

onready var batPercent = $BatPercent

func updateBatteryStatus(batteryStatus):
	batPercent.text = str(batteryStatus, "%")
