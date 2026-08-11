if [ -z "$__ORIG_PATH" ]; then
  export __ORIG_PATH="$PATH"
fi
PATH="/mujbin:/home/hasan/.local/bin:/opt/intel/oneapi/vtune/latest/bin64:$__ORIG_PATH:/mujbin/commitizen/bin:/mujbin/deno/bin"

export ANDROID_HOME=/opt/android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

export CHROME_EXECUTABLE=/snap/bin/chromium
PATH="$PATH:/opt/flutter/bin"

export SCONSFLAGS="-Q -u -j$(( $(nproc) / 2 ))"
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=00;90:quote=01"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

export RIPGREP_CONFIG_PATH=~/.ripgreprc

# stop GTK complaining about accessibility features
export NO_AT_BRIDGE=1

export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/gcr/ssh
export SSH_ASKPASS=/usr/lib/openssh/gnome-ssh-askpass
export SSH_ASKPASS_REQUIRE=prefer

export QT_AUTO_SCREEN_SCALE_FACTOR=1

if [ -f ~/.profile.local ]; then
  source ~/.profile.local
fi
