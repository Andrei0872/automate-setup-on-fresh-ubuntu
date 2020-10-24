# Automate setup on fresh ubuntu

A script that installs all the tools I need on a fresh Ubuntu distro. Getting to start working on awesome things as soon as possible :sunglasses:

*Note: this has been tested for Ubuntu 20.04.*

## Prerequisite

Add this to `/etc/resolve.conf`(before anything else): `nameserver 8.8.8.8 `

---

## How to use it

1. Open a terminal instance
2. Run 
  ```bash
  touch setup && gedit $_
  ```

3. Paste the content of the `setup.sh` file
4. Before running the script, make sure you adjust your credentials in `installGit` function
5. Run
  ```bash
  sudo bash setup $HOME
  ```
6. Run
  ```bash
  sudo su - $USER
  ```
7. Log out and log in again(CTRL + SHIFT + DEL)

---

## Other Tweaks

Minimize window when its icon is clicked

```bash
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
```