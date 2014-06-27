# Gridvis over VNC

from    ubuntu

run     apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
run     apt-get install -y x11vnc xvfb wget
run     mkdir /.vnc
run     wget -O GridVis.sh http://gridvis.janitza.de/download/5.0.1/GridVis-5.0.1-64bit.sh && sh GridVis.sh -q && rm GridVis.sh && ln -s /opt/GridVisData/license2-pc.lic /usr/local/GridVis/license2.lic

volume ["/opt/GridVisProjects"]
# Setup a password
run     x11vnc -storepasswd 1234 ~/.vnc/passwd
# Autostart firefox (might not be the best way to do it, but it does the trick)
run     bash -c 'echo "/usr/local/GridVis/bin/gridvis" >> /.bashrc'
cmd     x11vnc -forever -usepw -create
