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

#include <string.h>

int generateController(){

  printf("Generating Controllerz\n");

  // Generate CONTROLLER

  // Get framework name from user
  char name[50];

  printf("NAEM? ");
  fgets(name, sizeof(name), stdin);

  // Trim off the newline char
  name[strlen(name)-1] = '\0';

  // Create files

  char controllerName[64];
  char Testing[60];

  // Create Controller File
  strcpy(controllerName, "Controllers/");
  strcat(controllerName,name);
  strcat(controllerName,".boss");

  // Create [name.boss]
  FILE *newFile;
  newFile=fopen(controllerName, "w");
  fprintf(newFile, "HAI\n\n  PAEG index\n    LIST\n  KTHX\n\n  PAEG create\n    NEW\n  KTHX\n\n  PAEG search\n    FIND\n  KTHX\n\nKTHXBYE");

  // Create Test File
  strcpy(Testing, "DB/");
  strcat(Testing,name);
  strcat(Testing,".db");

  // Create [name.test]
  newFile=fopen(Testing, "w");
  
  char dbFile[130];
  strcpy(dbFile,"HAI\n\n  TABEL ");
  strcat(dbFile,name);
  strcat(dbFile,"\n    \"name\", YARN, 20\n    \"age\", NUM\n  KTHX\n\nKTHXBYE");

  fprintf(newFile, "%s", dbFile);

  return 0;

}

