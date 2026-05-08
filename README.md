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
* `dropbox_refresh_token.txt` (refresh token)

Token behavior:

1. Access-Tokens are short-lived (typically a few hours).
2. The setup now refreshes Access-Tokens automatically via `refresh_token` without user interaction.

Update refresh token (only when revoked/invalid):

1. Overwrite `credentials/dropbox_refresh_token.txt` with the new refresh token.
2. Run `ansible-playbook ansible/dropbox.yml -i inventory-remote.ini -K` again.

## dropbox and gallery split
The setup is split into two playbooks:

* `ansible/dropbox.yml` for Dropbox/rclone download and sync service
* `ansible/gallery.yml` for gallery player/autostart setup

Run both (recommended order):

1. `ansible-playbook ansible/dropbox.yml -i inventory-remote.ini -K`
2. `ansible-playbook ansible/gallery.yml -i inventory-remote.ini -K`

## shared folders for both playbooks
Shared folder variables are defined in `ansible/vars/shared_paths.yml` and loaded by both playbooks.

Current shared paths:

* `dropbox_download_dir` (`/opt/dropbox-download`)
* `dropbox_slideshow_dir` (`/opt/digital-frame`)
* `dropbox_slideshow_media_dir`
* `dropbox_playlist_file`

If you change folders, update only `ansible/vars/shared_paths.yml`.


