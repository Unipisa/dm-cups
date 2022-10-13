#!/bin/bash
#

set -e

echo -n "Installing the required packages (sqlite3, ghoscript, cups) ... "
sudo apt-get -q update > /dev/null 2>&1
sudo apt-get -q -y install sqlite3 ghostscript cups > /dev/null 2>&1
echo "done"

echo "Downloading the dm-cups backend"
sudo wget -q -O /usr/lib/cups/backend/dm-cups https://raw.githubusercontent.com/Unipisa/dm-cups/main/dm-cups
sudo chmod a+x /usr/lib/cups/backend/dm-cups

echo "Installing the configuration file in /etc/cups/dm-cups.conf"
sudo wget -q -O /etc/cups/dm-cups.conf https://github.com/Unipisa/dm-cups/blob/main/dm-cups-portatili.conf

echo "Installing the printers cdcpt, cdcpp, cdcsd, cdclf"
for printer in cdcpt cdcpp cdcsd cdclf cdc11; do
  if ! lpq -P$printer > /dev/null; then
    sudo /usr/sbin/lpadmin -p $printer -E -v "dm-cups://$printer" -m drv:///sample.drv/generic.ppd
    sudo lpadmin -p $printer -o Duplex=DuplexNoTumble -o Option1=True
    echo " $printer installed"
  else
    echo "> $printer present on the system, skipping"
  fi
done
