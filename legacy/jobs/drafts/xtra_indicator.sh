sudo i2cset -y 1 0x20 0x00 0x00
sudo i2cset -y 1 0x20 0x01 0x00

while true;
	do
		sudo i2cset -y 1 0x20 0x14 0x02
		sudo i2cset -y 1 0x20 0x14 0x04
		sudo i2cset -y 1 0x20 0x14 0x08
		sudo i2cset -y 1 0x20 0x14 0x10
		sudo i2cset -y 1 0x20 0x14 0x20
		sudo i2cset -y 1 0x20 0x14 0x40
		sudo i2cset -y 1 0x20 0x14 0x80
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x01
		sudo i2cset -y 1 0x20 0x15 0x02
		sudo i2cset -y 1 0x20 0x15 0x04
		sudo i2cset -y 1 0x20 0x15 0x08
		sudo i2cset -y 1 0x20 0x15 0x10
		sudo i2cset -y 1 0x20 0x15 0x20
		sudo i2cset -y 1 0x20 0x15 0x40
		sudo i2cset -y 1 0x20 0x15 0x80
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0xFF
		sudo i2cset -y 1 0x20 0x15 0xFF
		sudo i2cset -y 1 0x20 0x14 0x00
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x15 0x40
		sudo i2cset -y 1 0x20 0x15 0x20
		sudo i2cset -y 1 0x20 0x15 0x10
		sudo i2cset -y 1 0x20 0x15 0x08
		sudo i2cset -y 1 0x20 0x15 0x04
		sudo i2cset -y 1 0x20 0x15 0x02
		sudo i2cset -y 1 0x20 0x15 0x00
		sudo i2cset -y 1 0x20 0x14 0x80
		sudo i2cset -y 1 0x20 0x14 0x40
		sudo i2cset -y 1 0x20 0x14 0x20
		sudo i2cset -y 1 0x20 0x14 0x10
		sudo i2cset -y 1 0x20 0x14 0x08
		sudo i2cset -y 1 0x20 0x14 0x04
		sudo i2cset -y 1 0x20 0x14 0x02
	done
