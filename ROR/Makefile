#
#  Makefile for the ROFL On Rails LOLCODE interpreter
#  Copyright 2010, 2011 Adam Oliver
#  Distributed under the terms of the GNU General Public License
#  Function: Compiles LOLCODE lexical anyliser & parser, copies the output to /usr/bin/ and executes a test
#

ROR:	ROR.racc ROR.rex
	racc ROR.racc
	rex ROR.rex
	sudo cp ROR.tab.rb /usr/bin/
	sudo cp ROR.rex.rb /usr/bin/

