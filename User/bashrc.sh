# .bashrc

export PS1="[\u@\h \W]\$ "

ADMIN=

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# >>> conda initialize >>>
__conda_setup="$("$ADMIN/miniconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$ADMIN/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$ADMIN/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="$ADMIN/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

local_logout(){
  exit_code=$?
  if [ $exit_code != 103 ]; then
    if [ -z "$3" ]; then
      echo "[$(now)] Anonymous log-out. (IP: $1; TTY: $2)" >> ~/.login_history
    else
      echo "[$(now)] Log-out of $3. (IP: $1; TTY: $2)" >> ~/.login_history
    fi
  fi
}

trap "local_logout $(ssh_client_ip) $(ssh_tty) $SSH_CLIENT_USER" EXIT

if [ -z "$SSH_CLIENT_IP" ]; then
  export SSH_CLIENT_IP=$(ssh_client_ip)
  readonly SSH_CLIENT_IP
  echo "[$(now)] Anonymous log-in. (IP: $SSH_CLIENT_IP; TTY: $(ssh_tty))" >> ~/.login_history
fi

