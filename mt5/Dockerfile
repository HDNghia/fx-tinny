FROM msjpq/wine-vnc:bionic

WORKDIR /root/.wine/drive_c/
RUN apt-get update && apt-get install -y sudo supervisor git wget software-properties-common xvfb && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get remove winbind && apt-get install -y winbind && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

ENV WINEPREFIX=/root/.wine \
    WINEDLLOVERRIDES="mscoree=" \
    WINEARCH=win64

COPY ./mt5/install_python.sh /root/.wine/drive_c/
RUN chmod +x /root/.wine/drive_c/install_python.sh && xvfb-run bash install_python.sh

COPY ./mt5/install_and_run_mt5ubuntu.sh /root/.wine/drive_c/fx/
RUN chmod +x /root/.wine/drive_c/fx/install_and_run_mt5ubuntu.sh

COPY ./mt5/*.sh ./mt5/*.py /root/.wine/drive_c/fx/
COPY ./mt5/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Download the Exness MetaTrader 5 setup file
RUN wget https://download.metatrader.com/cdn/web/exness.technologies.ltd/mt5/exness5setup.exe -O /root/.wine/drive_c/fx/exness5setup.exe

# Run the installation of MetaTrader 5 Exness
RUN xvfb-run bash /root/.wine/drive_c/fx/install_and_run_mt5ubuntu.sh || true

RUN touch /root/.wine/.update-timestamp
RUN echo 'disable' > $WINEPREFIX/.update-timestamp

CMD ["/usr/bin/supervisord"]
