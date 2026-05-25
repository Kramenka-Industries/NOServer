sudo podman stop $(sudo podman ps -a -q)
sudo podman rm $(sudo podman ps -a -q)
sudo podman image rm $(sudo podman image ls -a -q)