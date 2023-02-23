all:

install:
	install -m 0755 dm-cups /usr/lib/cups/backend
	install -m 0644 dm-cups.conf /etc/cups
	test -d /etc/cups/dm-banner || mkdir -p /etc/cups/dm-banner
	install -D -m 0644 banner.tex banner-logo-transparent.png /etc/cups/dm-banner

banner-logo-transparent.png:
	convert banner-logo.png -matte -channel A +level 0,40% +channel banner-logo-transparent.png
