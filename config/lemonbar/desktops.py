import subprocess
#import pdb

def get_output_from_bspc(cmd):
	process = subprocess.Popen(cmd.split(), stdout = subprocess.PIPE)
	output, error = process.communicate()

	if error:
		print(error)
		exit()

	return output

def desktop_has_nodes(desktop):
	num_nodes_query = "bspc query -d " + desktop + " -N"
	return int.from_bytes(get_output_from_bspc(num_nodes_query), "big")

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
		desktops.append("%{B#bf616a}%{F#2e3440}  " + icons[index] + "  %{B-}%{F-}")
	elif desktop_has_nodes(item):
		desktops.append("%{A:bspc desktop -f " + item  + ":}%{B#81a1c1}%{F#2e3440}  " + icons[index] + "  %{B-}%{F-}%{A-}")
	else:
		desktops.append("%{A:bspc desktop -f " + item  + ":}  " + icons[index] + " %{A-}")

print(("\U00000009").join(desktops))

