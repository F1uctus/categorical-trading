## Usage

```bash
docker build . -t categorical-trading
[+] Building 12.6s (10/10) FINISHED                                                                                docker:default
...
 => => unpacking to docker.io/library/categorical-trading:latest                                                            11.1s

docker run -it -v "/home/jovyan:/d/Dev/julia/categorical-trading" -p 127.0.0.1:8888:8888/tcp categorical-trading
Entered start.sh with args: start-notebook.py
Running hooks in: /usr/local/bin/start-notebook.d as uid: 1000 gid: 100
...
Jupyter Server 2.14.0 is running at:
http://...:8888/lab?token=...
http://127.0.0.1:8888/lab?token=...
```
