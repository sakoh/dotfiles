import sys
import re

blue = "#88c0d0"
yellow = "#ebcb8b"
red = "#bf616a"

temp = sys.argv[1]

def make_temp_dict(temp):
	temp_float = float(re.findall("\d+\.\d+",str(temp))[0])

	if temp_float > 80.0:
		return {
			"icon": "\uf2c7",
			"color": red
		}
	elif temp_float > 60.0:
		return {
			"icon": "\uf2c9",
			"color": yellow
		}
	else:
		return {
			"icon": "\uf2cb",
			"color": blue
		}

temp_dict = make_temp_dict(temp)

print(f"%{{A:alacritty -e sensors:}}%{{U{temp_dict['color']}}}%{{F{temp_dict['color']}}} %{{+u}} {temp_dict['icon']} {temp} %{{-u}}%{{U-}}%{{F-}}%{{A}}")
