import subprocess
#bspc query -N -d 0x0040000D | wc -l
#import pdb

def get_output_from_bash_cmd(cmd):
	process = subprocess.Popen(cmd.split(), stdout = subprocess.PIPE)
	output, error = process.communicate()
	
	if error:
		print(error)
		exit()
	
	return output 

#pdb.set_trace()
cmd = "bspc query -D"
output = get_output_from_bash_cmd(cmd)

output = str(output).split("\\n")
output.pop()
output[0] = output[0].replace("b'","")
desktops = []
icons = [ "\uf120", "\uf57d", "\uf086", "\uf11b", "\uf001", ]

for index, item in enumerate(output):
	cmd = "bspc query -D -d"
	output = get_output_from_bash_cmd(cmd)
	
	output = str(output).replace("'","").replace("b","").replace("\\n", "")
	
	if item == output:
		desktops.append("%{B#bf616a}%{F#2e3440} " + icons[index] + " %{B-}%{F-}")
	else:
		desktops.append(" " + icons[index] + " ") 
		
print(("\U00000009").join(desktops))

