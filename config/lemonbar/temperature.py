import sys
import re

blue = "#81a1c1"
yellow = "#ebcb8b"
red = "#bf616a"

temp = sys.argv[1]

def make_temp_dict(temp):
	temp_float = float(re.findall("\d+\.\d+",str(temp))[0])

	if temp_float > 70.0:
		return {
			"icon": "\uf2c7",
			"color": red
		}
	elif temp_float > 50.0:
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
