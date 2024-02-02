kill -9 $(ps aux | grep 'python' | grep 'startchat' | grep -v 'grep' | awk '{print $2}')
