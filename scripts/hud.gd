extends CanvasLayer

@onready var clock_label: Label = $ClockLabel

func _process(_delta: float) -> void:
	clock_label.text = "Day %d  %s" % [GameClock.day, GameClock.get_time_string()]
