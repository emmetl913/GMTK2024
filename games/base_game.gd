extends Node2D

class_name Base_Game

var parent

#var timers should be set in each child class
#var timers will be the timer on the clock for each game phase
var timers : Array[int]

var directionMessage : String


func set_parent(par : Node2D):
	parent = par

func onWin():
	parent.winGame()

func onLose():
	parent.loseGame()

#Returns the value the timer should be set to for the current game phase
func getTimer(game_phase : int):
	return timers[game_phase]
