### Install
```
sudo apt update
sudo apt install tmux htop

wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
bash Anaconda3-2022.10-Linux-x86_64.sh

conda create -n startchat python=3.9
conda activate startchat

git clone https://github.com/khulnasoft-lab/StartChat.git
cd StartChat
pip3 install -e .
```


### Launch servers
```
cd startchat_logs/controller
python3 -m startchat.serve.controller --host 0.0.0.0 --port 21001
python3 -m startchat.serve.register_worker --controller http://localhost:21001 --worker-name https://
python3 -m startchat.serve.test_message --model vicuna-13b --controller http://localhost:21001

cd startchat_logs/server0

python3 -m startchat.serve.huggingface_api_worker --model-info-file ~/elo_results/register_hf_api_models.json

export OPENAI_API_KEY=
export ANTHROPIC_API_KEY=
export GCP_PROJECT_ID=

python3 -m startchat.serve.gradio_web_server_multi --controller http://localhost:21001 --concurrency 50 --add-chatgpt --add-claude --add-palm --elo ~/elo_results/elo_results.pkl --leaderboard-table-file ~/elo_results/leaderboard_table.csv --register ~/elo_results/register_oai_models.json --show-terms

python3 backup_logs.py
```


### Check the launch time
```
for i in $(seq 0 11); do cat startchat_logs/server$i/gradio_web_server.log | grep "Running on local URL" | tail -n 1; done
```


### Increase the limit of max open files
One process (do not need reboot)
```
sudo prlimit --nofile=1048576:1048576 --pid=$id

for id in $(ps -ef | grep gradio_web_server | awk '{print $2}'); do echo $id; prlimit --nofile=1048576:1048576 --pid=$id; done
```

System (need reboot): Add the lines below to `/etc/security/limits.conf`
```
* hard nofile 65535
* soft nofile 65535
```


### Gradio edit  (3.35.2)
1. gtag and canvas
```
vim /home/vicuna/anaconda3/envs/startchat/lib/python3.9/site-packages/gradio/templates/frontend/index.html
```

```
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-K6D24EE9ED"></script><script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-K6D24EE9ED');
  window.__gradio_mode__ = "app";
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
```

2. deprecation warnings
```
vim /home/vicuna/anaconda3/envs/startchat/lib/python3.9/site-packages/gradio/deprecation.py
```

```
def check_deprecated_parameters(
```

3. Loading
```
vim /home/vicuna/anaconda3/envs/startchat/lib/python3.9/site-packages/gradio/templates/frontend/assets/index-188ef5e8.js
```

```
%s/"Loading..."/"Loading...(Please refresh if it takes more than 30 seconds)"/g
```
