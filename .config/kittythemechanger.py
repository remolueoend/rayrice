'''A config module for the Kitty Theme Changer Tool.'''
from pathlib import Path
import glob

theme_dir = Path('~/.config/kitty/themes').expanduser()
conf_dir = Path('~/.config/kitty').expanduser()
theme_link = conf_dir.joinpath('theme.conf')
light_theme_link = theme_dir.joinpath('light-theme.conf')
dark_theme_link = theme_dir.joinpath('dark-theme.conf')
# ugly hack, works because:
# 1. kitty is started with --single-instance => all windows share same PID
# 2. kitty is configured with listen_on and allow_remote_control in kitty.conf
socket = 'unix:' + glob.glob('/tmp/kitty-socket-*')[0]
