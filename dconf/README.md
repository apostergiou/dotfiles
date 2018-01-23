## Backup and Restore Instructions

To backup:

```shell
$ dconf dump / > user_backup
```

To restore all your settings:

```shell
$ rm /home/yourusername/.config/dconf/user
$ mv /home/yourusername/.config/dconf/user_backup /home/yourusername/.config/dconf/user
$ sudo reboot
```

Alternatively, to reset to defaults:

```shell
$ dconf reset
```
