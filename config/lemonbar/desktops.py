import subprocess
#import pdb

def get_output_from_bash_cmd(cmd):
	process = subprocess.Popen(cmd.split(), stdout = subprocess.PIPE)
	return process.communicate()

#pdb.set_trace()
cmd = "bspc query -D"
output, error = get_output_from_bash_cmd(cmd)

if error:
	print(error)
	exit()

output = str(output).split("\\n")
output.pop()
output[0] = output[0].replace("b'","")
desktops = []

for index, item in enumerate(output):
	cmd = "bspc query -D -d"
	output, error = get_output_from_bash_cmd(cmd)
	if error:
		print(error)
		exit()
	
	output = str(output).replace("'","").replace("b","").replace("\\n", "")
	if item == output:
		desktops.append("%{+u}" + str(int(index) + 1) + "%{-u}")
	else:
		desktops.append(str(index + 1)) 
		
print(("\U00000009").join(desktops))

