# Gridvis over VNC

from    ubuntu

run     echo 'Acquire::http::Proxy "http://internet.janitza.de:3142";' > /etc/apt/apt.conf.d/01proxy
run     apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
run     apt-get install -y x11vnc xvfb wget
run     mkdir /.vnc
run     http_proxy=http://astaro.srv:8080 wget http://gridvis.janitza.de/download/5.0.1/GridVis-5.0.1-64bit.sh
run     sh GridVis-5.0.1-64bit.sh -q

volume ["/opt/GridVisProjects"]
# Setup a password
run     x11vnc -storepasswd 1234 ~/.vnc/passwd
# Autostart firefox (might not be the best way to do it, but it does the trick)
run     bash -c 'echo "/usr/local/GridVis/bin/gridvis" >> /.bashrc'
cmd     x11vnc -forever -usepw -create
