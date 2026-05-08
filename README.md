# dropbox-gallery
image gallery on raspberry pi

## setup
* ssh raspi@192.168.8.19
* git clone https://github.com/vinceTTs/dropbox-gallery.git
* bash dropbox-gallery/setup.sh

## ansible sudo error
If you see `sudo: a password is required`, run Ansible with a sudo password prompt:

* `ansible-playbook ansible/auto_update.yml -i inventory-remote.ini -K`
* `ansible-playbook ansible/auto_update_run.yml -i inventory-remote.ini -K`

## install ssh + static ip
Run the SSH setup playbook:

* `ansible-playbook ansible/ssh.yml -i inventory-remote.ini -K`

This installs/enables SSH and configures static IP `192.168.1.99`.
For internet access, configure router port-forwarding TCP `22` to `192.168.1.99`.

`-K` (`--ask-become-pass`) prompts for your sudo password used by `become: yes`.

## dropbox credentials
Required files (text files) in `credentials/`:

* `dropbox_key.txt` (client_id)
* `dropbox_secret.txt` (client_secret)
* `dropbox_access_token.txt` (access token)

Update token:

1. Overwrite `credentials/dropbox_access_token.txt` with the new token.
2. Run `ansible-playbook ansible/dropbox.yml -i inventory-remote.ini -K` again.


