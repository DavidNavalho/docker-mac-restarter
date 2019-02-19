## Launch daemon to monitor and restart Docker for Mac

Use this daemon to restart Docker for Mac if connection to one of its containers drops unexpectedly.

### How to install

First of all you must clone this repository:

```bash
git clone https://github.com/ruverav/docker-mac-restarter
```

Once cloned, you must go inside the repository folder:

```bash
cd docker-mac-restarter
```

You must give execution permissions to every script in this folder:

```bash
chmod u+x *.sh
```

Now you need to run the install script without sudo or root permissions:

```bash
./install.sh
```

You will be now asked for the hostname and port you want to test. The most common scenario is to check the connection towards a web server running in Docker, so the default values are `localhost` for the hostname and `80` for the port, but you can set those values as you want.

The only thing you need to have in mind is that you must specify a port exposed by a running container which has the `--restart` flag set to `always`, so the launch daemon can know when Docker is up and running again. You also need to specify the interval of seconds between connection tests (`300` seconds by default) and press y on your keyboard to finish the installation.

### How to check installation status

You can check if the launch daemon is already installed:

```bash
./check_install.sh
```

### How to view the logs

You can view the logs of the launch daemon if you want to make sure it's actually doing its job:

```bash
./logs_view.sh
```

You can also specify how many lines you want to view from these logs (20 lines by default):

```bash
./logs_view.sh 10
```

Finally you can also clear the logs (if log files become too large):

```bash
./logs_clear.sh
```

### How to uninstall

If you don't want this launch daemon installed anymore you can remove it:

```bash
./uninstall.sh
```

Easy as pie.

Enjoy!
