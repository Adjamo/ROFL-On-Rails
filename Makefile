#
#  Makefile for the ROFL On Rails Web Application Framework
#  Copyright 2010, 2011 Adam Oliver
#  Distributed under the terms of the GNU General Public License
#  Function: Installs the ROFL On Rails Web Application Framework
#            by compiling and copying the CAN executable, TESTPAEG
#            shell script, the lexer ROR.rex.rb and the parser
#            ROR.tab.rb to /usr/bin/
#

install:	
	# copy CAN the framework generator to /usr/bin/
	sudo cp CAN/CAN /usr/bin/
	# copy shell script MIGRATE which copies HTMLol files & Media from their directories to /usr/bin/
	sudo cp Resources/MIGRATE /usr/bin/
	# Copy the LOLCODE interpreter for interpretation of HTMLol files
	sudo cp ROR/ROR.tab.rb /usr/bin/
	# Copy the LOLCODE lexical anyliser for interpretation of HTMLol files
	sudo cp ROR/ROR.rex.rb /usr/bin/
	# Copy the Scaffold generator and Table generator to /usr/bin/
	sudo cp Resources/SCAFFOLD.rb /usr/bin/
	sudo cp Resources/TABEL.rb /usr/bin/
	sudo cp Resources/SCAFFOLD /usr/bin/
	# Copy the files delete.php and update.php to /usr/lib/cgi-bin/
	sudo cp Resources/delete.php /usr/lib/cgi-bin/
	sudo cp Resources/update.php /usr/lib/cgi-bin/
	# Only create the "ROR Media" directory and copy file Roflcopter.gif to it if doesnt exist
	if [ ! -d "/var/www/Media" ]; then\
	  sudo mkdir /var/www/Media;\
	  sudo cp CAN/Roflcopter.gif /var/www/Media;\
	fi

uninstall:	
	# Remove CAN the framework generator from /usr/bin/
	sudo rm /usr/bin/CAN
	# Remove shell script MIGRATE from /usr/bin/
	sudo rm /usr/bin/MIGRATE
	# Remove the LOLCODE interpreter for interpretation of HTMLol files
	sudo rm /usr/bin/ROR.tab.rb
	# Remove the LOLCODE lexical anyliser for interpretation of HTMLol files
	sudo rm /usr/bin/ROR.rex.rb
	# Remove the Scaffold generator and Table generator from /usr/bin/
	sudo rm /usr/bin/SCAFFOLD.rb
	sudo rm /usr/bin/TABEL.rb
	sudo rm /usr/bin/SCAFFOLD
	# Remove the files delete.php and update.php from /usr/lib/cgi-bin/
	sudo rm /usr/lib/cgi-bin/delete.php
	sudo rm /usr/lib/cgi-bin/update.php

