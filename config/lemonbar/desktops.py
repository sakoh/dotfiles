import subprocess
#import pdb

# colors
red = "#bf616a"
magenta = "#b48ead"
cyan = "#88c0d0"
blue = "#81a1c1"
green = "#a3be8c"
bg_color = "#2e3440"
fg_color = "#d8dee9"

def get_output_from_bspc(cmd):
	process = subprocess.Popen(cmd.split(), stdout = subprocess.PIPE)
	output, error = process.communicate()

	if error:
		print(error)
		exit()

	return output

def desktop_has_nodes(desktop):
	num_nodes_query = f"bspc query -d {desktop} -N"
	return int.from_bytes(get_output_from_bspc(num_nodes_query), "big")

def render_current_desktop(icon):
	return f"%{{U{red}}}%{{F{red}}}%{{+u}}  {icon}  %{{-u}}%{{U-}}%{{F-}}"

def render_empty_desktop(desktop, icon):
	return f"%{{A:bspc desktop -f {desktop}:}}  {icon}  %{{A}}"

def render_desktop_with_nodes(desktop, icon):
	return f"%{{A:bspc desktop -f {desktop}:}}%{{U{cyan}}}%{{F{cyan}}}%{{+u}}  {icon}  %{{-u}}%{{U-}}%{{F-}}%{{A}}"

#pdb.set_trace()
all_desktops_query = "bspc query -D"

all_desktops = get_output_from_bspc(all_desktops_query)
all_desktops = str(all_desktops).split("\\n")
all_desktops.pop()
all_desktops[0] = all_desktops[0].replace("b'","")

desktops = []
icons = [ "\uf120", "\uf57d", "\uf086", "\uf11b", "\uf001", ]

for index, item in enumerate(all_desktops):
	current_desktop_query = "bspc query -D -d"
	current_desktop = get_output_from_bspc(current_desktop_query)
	current_desktop = str(current_desktop).replace("'","").replace("b","").replace("\\n", "")

	if item == current_desktop:
		desktops.append(render_current_desktop(icons[index]))
	elif desktop_has_nodes(item):
		desktops.append(render_desktop_with_nodes(item, icons[index]))
	else:
		desktops.append(render_empty_desktop(item, icons[index]))

print(("\U00000009").join(desktops))

