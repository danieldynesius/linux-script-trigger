# Linux Trigger

### Step 1:
Uses linux .service & .trigger:
/etc/systemd/system/WakeUpToRunScript.service
/etc/systemd/system/WakeUpToRunScript.timer
(path to script is coded inside)

### Step 2:
to trigger the wakeup_and_run.sh
which in turn triggers python scripts (paths to scripts are coded inside)

Thats it.
