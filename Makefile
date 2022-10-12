all:

install:
	install -m 0755 dm-cups /usr/lib/cups/backend
	install -m 0644 dm-cups.conf /etc/cups

