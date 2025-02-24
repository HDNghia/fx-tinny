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

# Copy and run install_python.sh inside a virtual X server
COPY ./mt5/install_python.sh /root/.wine/drive_c/
RUN chmod +x /root/.wine/drive_c/install_python.sh && xvfb-run bash install_python.sh

# Copy the script that installs and runs MT5 (update this script as needed)
COPY ./mt5/install_and_run_mt5ubuntu.sh /root/.wine/drive_c/fx/
RUN chmod +x /root/.wine/drive_c/fx/install_and_run_mt5ubuntu.sh

# Copy additional scripts and configuration
COPY ./mt5/*.sh ./mt5/*.py /root/.wine/drive_c/fx/
COPY ./mt5/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# **Updated:** Copy the mt5.exe installer (ensure this file is in your repository)
COPY mt5/mt5.exe /root/.wine/drive_c/fx/

# Run the MT5 installer using Wine in a virtual frame buffer.
# Adjust /silent or other command-line options as needed for a silent install.
RUN xvfb-run wine /root/.wine/drive_c/fx/mt5.exe /silent || true

# Prevent Wine from auto-updating by touching the update timestamp file.
RUN touch /root/.wine/.update-timestamp && \
    echo 'disable' > $WINEPREFIX/.update-timestamp

# Start supervisord to manage your processes
CMD ["/usr/bin/supervisord"]
