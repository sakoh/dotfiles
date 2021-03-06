import subprocess
from utils import get_output_from_shell
#import pdb

# colors
magenta = "#b48ead"
frostgreen="#8fbcbb"
hover_color = "#2e3440"

def desktop_has_nodes(desktop):
	num_nodes_query = f"bspc query -d {desktop} -N"
	return int.from_bytes(get_output_from_shell(num_nodes_query), "big")

def add_bg_hover(markup):
	return f"%{{U{magenta}}}%{{+u}}{markup}%{{-u}}%{{U-}}"

def add_action_handler(markup, desktop):
	return f"%{{A:bspc desktop -f {desktop}:}}{markup}%{{A}}"

def render_desktop(desktop, icon):
	color = magenta if desktop_has_nodes(desktop) else frostgreen
	return f"%{{F{color}}}  {icon}  %{{F-}}"

#pdb.set_trace()
all_desktops_query = "bspc query -D"

all_desktops = get_output_from_shell(all_desktops_query)
all_desktops = str(all_desktops).split("\\n")
all_desktops.pop()
all_desktops[0] = all_desktops[0].replace("b'","")

desktops = []
icons = [ "\uf120", "\uf57d", "\uf086", "\uf11b", "\uf001", "\uf53f" ]

for index, item in enumerate(all_desktops):
	current_desktop_query = "bspc query -D -d"
	current_desktop = get_output_from_shell(current_desktop_query)
	current_desktop = str(current_desktop).replace("'","").replace("b","").replace("\\n", "")

	if item == current_desktop:
		desktops.append(add_bg_hover(render_desktop(item, icons[index])))
	else:
		desktops.append(add_action_handler(render_desktop(item, icons[index]), item))

print(("\U00000009").join(desktops))

