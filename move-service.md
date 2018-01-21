# Move Movies and TV Shows Separately
## Movies Script and Service
### Create the movies script:

    sudo vim /opt/rclone-move-movies.sh

Copy and paste into the script:

    #!/bin/bash
    while true
    do
    # Purpose of sleep starting is so rclone has time to startup and kick in
    sleep 30
    # Anything above 8M will result in a google ban if uploading above 8M for 24 hours
    rclone move --tpslimit 4 --max-size 99G --log-level INFO --stats 15s local:/mnt/rclone-move/movies gdrive:/remote/m-gd/
    done

Change permissions so the script is executable by `move-movies.service`:

    sudo chmod 755 /opt/rclone-move-movies.sh

### Create move-movies.service

    sudo vim /etc/systemd/system/move-movies.service
    
Copy and paste into the script:

    [Unit]
    Description=Move Service Daemon
    After=multi-user.target

    [Service]
    Type=simple
    User=root
    Group=root
    ExecStart=/bin/bash /opt/rclone-move-movies.sh
    TimeoutStopSec=20
    KillMode=process
    RemainAfterExit=yes
    Restart=always

    [Install]
    WantedBy=multi-user.target

### Enable and start the service

    sudo systemctl daemon-reload
    sudo systemctl enable move-movies.service
    sudo systemctl start move-movies.service
    sudo systemctl status move-movies.service

---

## TV Script and Service
### Create the tv script:

    sudo vim /opt/rclone-move-tv.sh

Copy and paste into the script:

    #!/bin/bash
    while true
    do
    # Purpose of sleep starting is so rclone has time to startup and kick in
    sleep 30
    # Anything above 8M will result in a google ban if uploading above 8M for 24 hours
    rclone move --tpslimit 4 --max-size 99G --log-level INFO --stats 15s local:/mnt/rclone-move/tv gdrive:/remote/tv-gd/
    done

Change permissions so the script is executable by `move-tv.service`:

    sudo chmod 755 /opt/rclone-move-tv.sh

### Create move-movies.service:

    sudo vim /etc/systemd/system/move-tv.service
    
Copy and paste into the script:

    [Unit]
    Description=Move Service Daemon
    After=multi-user.target

    [Service]
    Type=simple
    User=root
    Group=root
    ExecStart=/bin/bash /opt/rclone-move-tv.sh
    TimeoutStopSec=20
    KillMode=process
    RemainAfterExit=yes
    Restart=always

    [Install]
    WantedBy=multi-user.target

### Enable and start the service

    sudo systemctl daemon-reload
    sudo systemctl enable move-tv.service
    sudo systemctl start move-tv.service
    sudo systemctl status move-tv.service

---