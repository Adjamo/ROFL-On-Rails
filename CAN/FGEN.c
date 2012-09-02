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
#include <stdio.h>
#include <stdlib.h>


int generateFramework(){

  printf("Generating Framework\n");

  // Generate FRAMEWORK

  // Get framework name from user
  char name[50];
  printf("NAEM? ");
  fgets(name, sizeof(name), stdin);

  // Trim off the newline char
  name[strlen(name)-1] = '\0';

  // Create folders first
  mkdir(name,0755);

  char HTMLol[60];
  char Testing[60];
  char Controllers[63];
  char MySQLinfo[60];
  char READMEfile[60];
  char testpage[60];
  char Media[60];

  // Create Media sub-directory
  strcpy(Media, name);
  strcat(Media,"/Media");
  mkdir(Media,0755);

  // Create HTMLol sub-directory
  strcpy(HTMLol, name);
  strcat(HTMLol,"/HTMLol");
  mkdir(HTMLol,0755);

  // Create Controllers sub-directory
  strcpy(Controllers, name);
  strcat(Controllers,"/Controllers");
  mkdir(Controllers,0755);

  // Create Testing sub-directory
  strcpy(Testing, name);
  strcat(Testing,"/DB");
  mkdir(Testing,0755);

  // Next create files

  //Create MySQL config.txt
  strcpy(MySQLinfo, name);
  strcat(MySQLinfo,"/MySQL config.txt");
  FILE *newFile;
  newFile=fopen(MySQLinfo, "w");
  fprintf(newFile, "username: \npassword: \n");

  // Create README.txt
  strcpy(READMEfile, name);
  strcat(READMEfile,"/README.txt");
  newFile=fopen(READMEfile, "w");
  fprintf(newFile, "ROFL On Rails\nVersion 0.1\nA Web Application Framework for LOLCODE\n\nUse of ROFL On Rails (enter into shell):\nTo create Controller files type: CAN HAS CONTROLLR\nTo generate scaffolding type: SCAFFOLD\nTo migrate htmlol files: MIGRATE");

  // Generate TEST

  strcpy(testpage, name);
  strcat(testpage,"/HTMLol/test.htmlol");

  // Use this to help create the contents of the test.htmlol file neatly:
  //strcat(StringA,"/add_this");

  // Create test.htmlol
  newFile=fopen(testpage, "w");
  fprintf(newFile, "#!/usr/bin/ruby /usr/bin/ROR.tab.rb\n<HTML>\n  <HEAD>\n    <TITLE>ROFL On Rails - Test Page</TITLE>\n\n  </HEAD>\n  <BODY>\n<CENTER>\n<?HAI\n\n      VISIBLE \"<H1>LOLCode Works!</H1>\"\n  \nKTHXBYE?>\n\n<img src=\"../Roflcopter.gif\" />\n<H3>LOLCODE: ALL LOLCATS, LOL, ALL CAPS</H3>\n</CENTER>\n  </BODY>\n\n</HTML>");


  // Copy the ROFLCopter from the '/usr/lib/ROR Media/' folder
  // Code taken from http://www.java2s.com/Code/C/File/Copyafile.htm

  FILE *from, *to;
  char ch;

  /* Open source file */
  if((from = fopen("/var/www/Media/Roflcopter.gif", "rb"))==NULL) {
    printf("Cannot open source file.\n");
    exit(1);
  }

  /* Open destination file */
  if((to = fopen(strcat(name,"/Media/Roflcopter.gif"), "wb"))==NULL) {
    printf("Cannot open destination file.\n");
    exit(1);
  }

  /* Copy the file */
  while(!feof(from)) {
    ch = fgetc(from);
    if(ferror(from)) {
      printf("Error reading source file.\n");
      exit(1);
    }
    if(!feof(from)) fputc(ch, to);
    if(ferror(to)) {
      printf("Error writing destination file.\n");
      exit(1);
    }
  }

  if(fclose(from)==EOF) {
    printf("Error closing source file.\n");
    exit(1);
  }

  if(fclose(to)==EOF) {
    printf("Error closing destination file.\n");
    exit(1);
  }


  return 0;

}

