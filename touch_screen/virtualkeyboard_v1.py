# -*- coding: UTF-8 -*-
import os
import easygui as g
import sys
# Please refer to the form for the function corresponding to the number

# print("Number and command comparison table:\n0 = Power button	        1 = Home button	       	     2 = Return botton\n3 = Switch applications		4 = start_App_TouchScreen    5 = stop_App_TouchScreen\n")

g.buttonbox('			Hi! Welcome to the social robot!',image='/home/xiang/图片/hill_t.png',choices=('continue','cancle'))


while True:

	msg ="		Number - function table"
	title = "Number-function"
	choices = ["0 = Power button","1 = Home button","2 = Return botton","3 = Switch applications","4 = start_App_TouchScreen","5 = stop_App_TouchScreen"]
	choice = g.choicebox(msg, title, choices)
	
	num_command = g.integerbox('Please enter a number',title='survey',lowerbound=0,upperbound=100)



	# 弹出一个Continue/Cancel对话框


	#num_command = input("Please enter the number of command you want to press:")

	if num_command == 0:
		num_command = 'adb shell input keyevent 26'

	elif num_command == 1:
		num_command = 'adb shell input keyevent 3'

	elif num_command == 2:
		num_command = 'adb shell input keyevent 4'

	elif num_command == 3:
		num_command = 'adb shell input keyevent 187'
	
	elif num_command == 4:
		num_command = 'adb shell am start org.qtproject.example.touch_screen/org.qtproject.qt5.android.bindings.QtActivity'

	elif num_command == 5:
		num_command = 'adb shell pm clear org.qtproject.example.touch_screen'

	elif num_command == 6:
		num_command = 'adb shell am kill-all'
	os.system(num_command)

	msg ="Do you want more operation?"
	title = "Please choose"
	if g.ccbox(msg, title):
		pass		# 如果用户选择Continue
	else:
		sys.exit(0)	# 如果用户选择Cancel

	
