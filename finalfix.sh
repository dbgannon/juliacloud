whoami
runuser -l jovyan -c '/bin/bash /home/jovyan/fixonlyjul.jl'
cd /home/jovyan/.ssh
chown jovyan pubkey
echo "got it done! "