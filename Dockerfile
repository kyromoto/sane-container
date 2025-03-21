FROM ubuntu:22.04

# Umgebungsvariablen setzen um interaktive Prompts zu vermeiden
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

# System-Pakete aktualisieren und notwendige Pakete installieren
RUN apt-get update && apt-get install -y \
    scanbd \
    sane \
    sane-utils

# SANED für Netzwerkzugriff konfigurieren
# RUN sed -i 's/^#saned.*/saned:ALL/' /etc/sane.d/saned.conf
# RUN echo "127.0.0.1" > /etc/sane.d/saned.d/remote.conf
# Bei Bedarf weitere erlaubte Clients hinzufügen
# RUN echo "192.168.1.0/24" >> /etc/sane.d/saned.d/remote.conf

# SANED als Service in systemd aktivieren
# RUN echo 'SANED_OPTIONS="-l -d128"' > /etc/default/saned

# Port für SANE-Netzwerkzugriff freigeben
# EXPOSE 6566

# Beim Start des Containers saned ausführen
# -d für Debug-Modus und -l für Listen-Modus
CMD ["saned", "-d128", "-l"]

# Alternativ: Status des USB-Geräts anzeigen und dann saned starten
# ENTRYPOINT ["/bin/bash", "-c", "lsusb && saned -d128 -l"]