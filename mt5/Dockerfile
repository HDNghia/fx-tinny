FROM msjpq/wine-vnc:bionic

# Set the working directory where Wine expects Windows files
WORKDIR /root/.wine/drive_c/

# Install necessary packages
RUN apt-get update && \
    apt-get install -y sudo supervisor git wget software-properties-common xvfb curl && \
    apt-get remove -y winbind && \
    apt-get install -y winbind && \
    rm -rf /var/lib/apt/lists/*

# Set Wine environment variables, including DISPLAY for Xvfb
ENV WINEPREFIX=/root/.wine \
    WINEDLLOVERRIDES="mscoree=" \
    WINEARCH=win64 \
    DISPLAY=:0

RUN chmod +x /root/.wine/drive_c/install_python.sh && xvfb-run bash install_python.sh

# Prevent Wine from auto-updating by touching the update timestamp file.
RUN touch /root/.wine/.update-timestamp && \
    echo 'disable' > $WINEPREFIX/.update-timestamp

# Start supervisord to manage your processes
CMD ["/usr/bin/supervisord"]
