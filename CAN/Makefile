#
#  Makefile for the Project Generator for ROFL On Rails
#  Copyright 2010, 2011 Adam Oliver
#  Distributed under the terms of the GNU General Public License
#  Function: Compiles the Project Generator
#            and copies the CAN executable and TESTPAEG shell
#            script to /usr/bin/
#

CAN:	CAN.c FGEN.c CGEN.c
	gcc -o $@ CAN.c
	sudo cp CAN /usr/bin/
