from subprocess import call

num_desktops = call("bspc query -D | wc -1")

print(num_desktops)
