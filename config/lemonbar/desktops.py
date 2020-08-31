import subprocess
#import pdb

# colors
red = "#bf616a"
blue = "#81a1c1"
magenta = "#b48ead"
cyan = "#88c0d0"
fg_color = "#2e3440"

def get_output_from_bspc(cmd):
	process = subprocess.Popen(cmd.split(), stdout = subprocess.PIPE)
	output, error = process.communicate()

	if error:
		print(error)
		exit()

	return output

def desktop_has_nodes(desktop):
	num_nodes_query = "bspc query -d %s -N" %(desktop)
	return int.from_bytes(get_output_from_bspc(num_nodes_query), "big")

def render_current_desktop(icon):
	return f"%{{B{red}}}%{{F{fg_color}}}  {icon}  %{{B-}}%{{F-}}"

def render_desktop_with_bg_color_and_action_handler(desktop, icon, bg_color):
	return f"%{{A:bspc desktop -f {desktop} :}}%{{B{bg_color}}}%{{F{fg_color}}}  {icon}  %{{B-}}%{{F-}}%{{A-}}"

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
		desktops.append(render_desktop_with_bg_color_and_action_handler(item, icons[index], blue))
	else:
		desktops.append(render_desktop_with_bg_color_and_action_handler(item, icons[index], cyan))

print(("\U00000009").join(desktops))

