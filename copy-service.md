# Copy Movies and TV Shows Separately
## Movies Script and Service
### Create the movies script:

    sudo vim /opt/copy-movies.sh

Copy and paste into the script:

    #!/bin/bash
    while true
    do
    # Purpose of sleep starting is so rclone has time to startup and kick in
    sleep 30
    cp -R /mnt/torrents/remote/m-gd/. /mnt/rclone-move/movies/
    done

Change permissions so the script is executable by `copy-movies.service`:

    sudo chmod 755 /opt/copy-movies.sh

### Create copy-movies.service

    sudo vim /etc/systemd/system/copy-movies.service
    
Copy and paste into the script:

    [Unit]
    Description=Movies Copy Service Daemon
    After=multi-user.target

    [Service]
    Type=simple
    User=root
    Group=root
    ExecStart=/bin/bash /opt/copy-movies.sh
    TimeoutStopSec=360
    KillMode=process
    RemainAfterExit=yes
    Restart=always

    [Install]
    WantedBy=multi-user.target

### Enable and start the service

    sudo systemctl daemon-reload
    sudo systemctl enable copy-movies.service
    sudo systemctl start copy-movies.service
    sudo systemctl status copy-movies.service

---

## TV Script and Service
### Create the TV script:

    sudo vim /opt/copy-tv.sh

Copy and paste into the script:

    #!/bin/bash
    while true
    do
    # Purpose of sleep starting is so rclone has time to startup and kick in
    sleep 30
    cp -R /mnt/torrents/remote/tv-gd/. /mnt/rclone-move/tv/
    done

Change permissions so the script is executable by `copy-tv.service`:

    sudo chmod 755 /opt/copy-tv.sh

### Create copy-movies.service

    sudo vim /etc/systemd/system/copy-tv.service
    
Copy and paste into the script:

    [Unit]
    Description=TV Copy Service Daemon
    After=multi-user.target

    [Service]
    Type=simple
    User=root
    Group=root
    ExecStart=/bin/bash /opt/copy-tv.sh
    TimeoutStopSec=360
    KillMode=process
    RemainAfterExit=yes
    Restart=always

    [Install]
    WantedBy=multi-user.target

### Enable and start the service

    sudo systemctl daemon-reload
    sudo systemctl enable copy-tv.service
    sudo systemctl start copy-tv.service
    sudo systemctl status copy-tv.service