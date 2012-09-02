/*
 *  ROFL On Rails - the Web Application Framework for LOLCODE.
 *  Copyright (C) 2010, 2011  Adam Oliver
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdio.h>
#include <stdlib.h>
#include "FGEN.c"
#include "CGEN.c"

int main(int argc, char *argv[])
{

  //if there are no arguments, the program halts
  if(argc == 1)
  {
    printf("No arguments given\n");
    return 0;
  }

  //string comparison, checking if HAS is the 1st argument
  if(strcmp(argv[1], "--version") == 0)
  {
    printf("Version 0.1\nGNU GPL\nNo Warranty\n");
    return 0;
  }

  //string comparison, checking if HAS is the 1st argument
  if(strcmp(argv[1], "HAS") != 0)
  {
    printf("Invalid arguments\n");
    return 0;
  }

  //ensure that there is at least a 2nd argument
  if(argc > 2)
  {
    //string comparison, checking if FRAMEWORK is the 2nd argument
    if(strcmp(argv[2], "FRAMEWORK") == 0)
    {
      return generateFramework();
    }

    //string comparison, checking if FRAMEWORK is the 2nd argument
    if(strcmp(argv[2], "CONTROLLR") == 0)
    {
      return generateController();
    }

  }

  //if the program runs to here, arguments have been invalid
  printf("Invalid arguments\n");

}

