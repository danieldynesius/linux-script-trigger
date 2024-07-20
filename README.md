# Linux Trigger

### Step 1:
Uses linux .service & .trigger:
´/etc/systemd/system/WakeUpToRunScript.service´
´/etc/systemd/system/WakeUpToRunScript.timer´
(path to script is coded inside)

### Step 2:
to trigger the ´wakeup_and_run.sh´
which in turn triggers python scripts (paths to scripts are coded inside)

### Step 3:
```
chmod +x wakeup_and_run.sh
sudo systemctl daemon-reload
sudo systemctl enable WakeUpToRunScript.timer
sudo systemctl start WakeUpToRunScript.timer
```

Thats it.
