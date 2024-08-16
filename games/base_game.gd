extends Node2D

class_name Base_Game

var parent

func set_parent(par : Node2D):
	parent = par
func onWin():
	parent.winGame()
func onLose():
	parent.loseGame()
