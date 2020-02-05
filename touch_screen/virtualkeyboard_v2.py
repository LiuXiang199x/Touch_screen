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
	choices = ["Power button","Home button","Return botton","Switch applications","start_App_TouchScreen","stop_App_TouchScreen"]
	var = g.choicebox(msg, title, choices)
	
	
	


	# 弹出一个Continue/Cancel对话框


	#num_command = input("Please enter the number of command you want to press:")

	if var == choices [0]:
		var = 'adb shell input keyevent 26'

	elif var == choices [1]:
		var = 'adb shell input keyevent 3'

	elif var == choices [2]:
		var = 'adb shell input keyevent 4'

	elif var == choices [3]:
		var = 'adb shell input keyevent 187'
	
	elif var == choices [4]:
		var = 'adb shell am start org.qtproject.example.touch_screen/org.qtproject.qt5.android.bindings.QtActivity'

        elif var == choices [5]:
		var = 'adb shell pm clear org.qtproject.example.touch_screen'

	
	os.system(var)

	msg ="Do you want more operation?"
	title = "Please choose"
	if g.ccbox(msg, title):
		pass		# 如果用户选择Continue
	else:
		sys.exit(0)	# 如果用户选择Cancel

	
