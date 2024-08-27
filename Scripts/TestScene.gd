extends Node2D

@onready var timer = $Timer

@onready var dialog: Array[String] = [
  "Hello",
  "How are you",
  "I'm fine thank you",
  "Woah mah gaah"
]

var a = Vector2(500, 500)

func _physics_process(delta):
  if Input.is_action_pressed("start_dialog"):
    DialogManager.startDialog(a, dialog)
