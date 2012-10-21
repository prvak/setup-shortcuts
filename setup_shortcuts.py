#/usr/bin/python
import os
import time
import string

# constants
home = os.path.expandvars("$HOME") # users home directory
template_file = "mateconf.xml.template"
keybindings_directory = home + "/.mateconf/desktop/mate/keybindings/"
shortcut_directory = keybindings_directory + "custom%d/"
shortcut_file = "%mateconf.xml" # the name actually starts with the %
configuration_file = "shortcuts.cfg"

# Read configuration file, this file defines all shortcuts.
with open(configuration_file) as cf:
    lines = cf.readlines()

# Read all shortcut configurations in advance. If there is an error in 
# the configuration file it will be reported before any file is created.
configurations = []
now = int(time.time())
for line in lines:
    line = line.strip()
    if not line or line[0] == "#":
        continue
    (script, shortcut, comment) = line.split("#")
    script = os.path.expandvars(script)
    shortcut = shortcut.replace("<", "&lt;")
    shortcut = shortcut.replace(">", "&gt;")
    comment = comment.strip()
    parameters = {  'script': script,       'comment':comment,
                    'shortcut': shortcut,   'time': now }
    configurations.append(parameters)

# Read template file.
with open(template_file) as tf:
    template = string.Template(tf.read())

# Create shortuct files.
shortcuts_created = 0
i = 0
for config in configurations:
    for i in xrange(i, 12): # There are 12 slots for custom shortcuts in MATE.
        shortcut_path = shortcut_directory % (i) + shortcut_file
        if os.path.exists(shortcut_path):
            continue # Shortcut with index 'i' is already used.
        if not os.path.exists(shortcut_directory % (i)):
            os.makedirs(shortcut_directory % (i))
        with open(shortcut_path, "w") as sf:
            sf.write(template.substitute(config)) # Fill in the template.
            shortcuts_created += 1
            break # Continue with the next shortcut.

# Create empty configuration file in the keybindings directory. Without
# it the shortcuts will not be recognized.
keybindikgs_config_path = keybindings_directory + shortcut_file
if not os.path.exists(keybindikgs_config_path):
    with open(keybindikgs_config_path, "w") as sf:
        pass

# Make sure that all shortcuts were created. Otherwise warn the user.
if shortcuts_created < len(configurations):
    print "Warning: No more slots. Created %d out of %d shortcuts." % (
            shortcuts_created, len(configurations))
else:
    print "Created %d shortcuts." % (len(configurations))
