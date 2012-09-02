#
#  Scaffold Generator for ROFL On Rails
#  Copyright 2010, 2011 Adam Oliver
#  Distributed under the terms of the GNU General Public License
#  Function: Create "scaffold" (HTMLol files) based on the controller files
#


def check(expectedString, thisToken)

  if expectedString != thisToken
    puts "Error: Found " + thisToken
    puts expectedString + " Expected"
  end

end

def parseFile(tokenArray, fileName, dblineArray)

  index = 0

  # tokenArray is an array of all tokens one per element.
  check("HAI", tokenArray[index]); index += 1
  # save the name of this htmlol file
  htmlol_name = ""

  while tokenArray[index] == "PAEG"

    htmlText = "#!/usr/bin/ruby /usr/bin/ROR.tab.rb\n<HTML>\n"
    htmlText2 = ""

    # First token already checked, so move on to next token
    index += 1
    htmlol_name = tokenArray[index]

    # Save file name and boss name
    newFile = fileName + "_" + htmlol_name + ".htmlol"
    newFile2 = fileName + "_display.htmlol"

    index += 1
    htmlSave = htmlText
    htmlText = ""
    link_var = 0

    while tokenArray[index] != "KTHX"

      if tokenArray[index] == "LIST"

        index += 1

        # Use LOLCODE to list Tabel entries
        htmlText += "CAN HAS MYSQL\n"
        htmlText += "UZE LOL\n"
        htmlText += "GIMMEH * FROM #{fileName}\n"
        htmlText += "KTHX\n"
        htmlText +="\n"

      elsif tokenArray[index] == "NEW"

        index += 1

        htmlText += "VISIBLE \"<form action='./#{fileName}_postnew.php' method='post'>\"\nVISIBLE \"<table>\"\n";

        dblineArray.length.times {|i| 
          htmlText += "VISIBLE \"<tr><td>"+dblineArray[i]+":</td><td><input type='text' name='"+dblineArray[i]+"_val' value='' size=16 /></td></tr>\"\n";
        }

        htmlText += "VISIBLE \"</table>\"\n"
        htmlText += "VISIBLE \"<input type='Submit' value='Submit'></form><BR />\"\n";
        htmlText += "VISIBLE \"</form><br>\"\n";
        htmlText +="\n"

      elsif tokenArray[index] == "FIND"

        index += 1

        htmlText += "VISIBLE \"<table>\"\n"

        dblineArray.length.times {|i| 
          htmlText += "VISIBLE \"<form action='./#{fileName}_display.htmlol' method='get'>\"\n"
          htmlText += "VISIBLE \"<tr><td>\"\n"
          htmlText += "VISIBLE \""+dblineArray[i]+": </td><td><input type='text' name='"+dblineArray[i]+"' value='' size=16 />\"\n";
          htmlText += "VISIBLE \"<input type='Submit' value='Submit'></form>\"\n"
          htmlText += "VISIBLE \"</td></tr></form>\"\n"
        }

        htmlText += "VISIBLE \"</table>\"\n"
        htmlText +="\n"

        htmlText2 += "#!/usr/bin/ruby /usr/bin/ROR.tab.rb\n<HTML>\n"

        if link_var == 1
        link_index = 0
          
          # get all page names
          while tokenArray[link_index] != "KTHXBYE"
            link_index += 1
            if tokenArray[link_index] == "PAEG"
              link_index += 1
              # no point in linking a page to itself
              if tokenArray[link_index] != htmlol_name
                htmlText2 += "<a href='"+fileName+"_"+tokenArray[link_index]+".htmlol'>"+tokenArray[link_index]+"</a> \n"
              end
            end
          end

        end

        htmlText2 += "<H1>display</H1>\n<?HAI\n"
        htmlText2 += "CAN HAS MYSQL\n"
        htmlText2 += "UZE LOL\n"
        htmlText2 += "GIMMEH * FROM #{fileName} WHERE GET_PARAMS\n"
        htmlText2 += "KTHX\n"
        htmlText2 += "KTHXBYE?>\n</HTML>"

        link_var = 0

      elsif tokenArray[index] == "LINK"

        index += 1
        link_index = 0
        link_var = 1

        # get all page names
        while tokenArray[link_index] != "KTHXBYE"
          link_index += 1
          if tokenArray[link_index] == "PAEG"
            link_index += 1
            # no point in linking a page to itself
            if tokenArray[link_index] != htmlol_name
              htmlSave += "<a href='"+fileName+"_"+tokenArray[link_index]+".htmlol'>"+tokenArray[link_index]+"</a> \n"
            end
          end
        end

        htmlText +="\n"

      else
        puts "Unexpected token #{tokenArray[index]}"
        index += 1
      end
    end

    htmlText += "KTHXBYE?>\n</HTML>"

    htmlSave += "<H1>" + htmlol_name + "</H1>\n"
    htmlSave += "<?HAI\n"
    htmlSave += htmlText

    # generate HTMLol file(s)
    File.open("./HTMLol/"+newFile, 'w') {|f| f.write(htmlSave) }
    if htmlText2 != ""
      File.open("./HTMLol/"+newFile2, 'w') {|f| f.write(htmlText2) }
    end

    check("KTHX", tokenArray[index]); index += 1

  end
  
  check("KTHXBYE", tokenArray[index]); index += 1

end

def make_postnew (fileName, dblineArray, tokenArray)

  posthtml = "<html><body onload=\"window.location='"+fileName+"_index.htmlol'\">\n<?php\n"
  posthtml += "  // Connect to MySQL\n"
  posthtml += "  $conn = mysql_connect(\"localhost\",\"root\",\"pass\") or die ('Failed to connect to MySQL<br />');\n"
  posthtml += "  // Connect to the database\n"
  posthtml += "  mysql_select_db(\"LOL\", $conn);\n"
  posthtml += "  // Insert new data\n"
  posthtml += "  if(mysql_query(\"insert into "+fileName+" ("

  dblineArray.size.times{ |i| 
  posthtml += dblineArray[i] 
  if i != dblineArray.size-1
    posthtml += ", " 
  end
  }

  posthtml += ") values ("

  dblineArray.size.times{ |i| 
  posthtml += "'$_POST[" + dblineArray[i] + "_val]'"
  if i != dblineArray.size-1
    posthtml += ", " 
  end
  }

  posthtml += ")\"))\n"
  posthtml += "  { echo \"Submission okai<br />\"; }else{ echo \"Errorz<br />\"; }\n"
  posthtml += "  echo \"<a href='"+ fileName +"_index.htmlol'>Return</a>\";\n"
  posthtml += "  //Close connection\n"
  posthtml += "  mysql_close($conn);\n"
  posthtml += "?></body></html>"

  File.open("./HTMLol/"+fileName+"_postnew.php", 'w') {|f| f.write(posthtml) }

  # Create a local copy of the file "edit.php"
  edit = "<html>\n"
  edit += "<head>\n"
  edit += "</head>\n"
  edit += "<body>\n"
  edit += "<?php\n"
  edit += "  $colNames_var = $_POST[colNames];\n"
  edit += "  $table_var = $_POST[table];\n"
  edit += "  $iddata_var = $_POST[iddata];\n"
  edit += "  $datadata_var = $_POST[datadata];\n"
  edit += "  $filename_var = $_POST[filename];\n"
  edit += "  $id = substr($iddata_var, 0, strpos($iddata_var, \"\t\"));\n"
  edit += "  // Put the results of the MySQL query into an array\n"
  edit += "  $values_array = explode(\"\t\", $datadata_var);\n"
  edit += "  $colNames_array = explode(\"\t\", $colNames_var);\n"

  link_index = 0

  # get all page names
  while tokenArray[link_index] != "KTHXBYE"
    link_index += 1
    if tokenArray[link_index] == "PAEG"
      link_index += 1
      edit += "echo \"<a href='"+fileName+"_"+tokenArray[link_index]+".htmlol'>"+tokenArray[link_index]+"</a> \";\n"
    end
  end

  edit += "  echo \"<h1>edit</h1>\";\n"
  edit += "  echo \"<form action='./update.php' method='post'>\";\n"
  edit += "  echo \"<input type='hidden' value='$table_var' name='table'/>\";\n"
  edit += "  echo \"<input type='hidden' value='$iddata_var' name='id' />\";\n"
  edit += "  echo \"<input type='hidden' value='$filename_var' name='filename' />\";\n"
  edit += "  echo \"<input type='hidden' value='\";\n"
  edit += "  echo count($values_array);\n"
  edit += "  echo \"' name='loop_size' />\";\n"
  edit += "  echo \"<table>\";\n"
  edit += "  // Create a textbox for each value\n"
  edit += "  for ($i = 0; $i < count($values_array)-1; $i++ )\n"
  edit += "  {\n"
  edit += "    echo \"<tr><td>\";\n"
  edit += "    echo $colNames_array[$i+1];\n"
  edit += "    echo \"</td><td>\";\n"
  edit += "    echo \": <input type='hidden' value='\";\n"
  edit += "    echo $colNames_array[$i+1];\n"
  edit += "    echo \"' name='col_$i' / ><input type='text' value='\";\n"
  edit += "    echo $values_array[$i+1];\n"
  edit += "    echo \"' name='data_$i' /> </tr></td>\";\n"
  edit += "  }\n"
  edit += "  echo \"</table>\";\n"
  edit += "  echo\"<input type='Submit' value='Save' />\";\n"
  edit += "  echo \"</form>\";\n"
  edit += "?>\n"
  edit += "</body>\n"
  edit += "</html>"

  File.open("./HTMLol/edit.php", 'w') {|f| f.write(edit) }

end

def mainMethod


  Dir.chdir("./Controllers/")
  bossfiles = Dir.glob("*")
  bossfiles.sort! { |a,b| a.downcase <=> b.downcase }
  Dir.chdir("../")

  file_num = bossfiles.length
  itr = 0

  while itr < file_num

    # Get the names of the columns
    Dir.chdir("./DB/")
    dbfiles = Dir.glob("*")
    dbfiles.sort! { |a,b| a.downcase <=> b.downcase }
    dbFile = File.new(dbfiles[itr], "r")
    dblineArray=[]
    dbindex = 0
    dbFile.each do |dbline|
      dbline = dbline.split
      dbline.each do | dbtoken |
        if dbtoken [0..0] == "\""
          dblineArray[dbindex] = dbtoken[1..dbtoken.length-3]
          dbindex +=1
        end
      end
    end
    Dir.chdir("../")

    Dir.chdir("./Controllers/")
    # Open the first controller file for reading
    aFile = File.new(bossfiles[itr], "r")

    Dir.chdir("../")
    lineArray=[]
    index = 0

    aFile.each do |line|

      line = line.split

      line.each do | token |
        lineArray[index] = token
        index +=1
      end

    end

    # Generate the HTMLol files
    parseFile(lineArray, bossfiles[itr].gsub(".boss",""), dblineArray)

    # Generate the php file to submit MySQL enteries
    make_postnew(bossfiles[itr].gsub(".boss",""), dblineArray, lineArray)

    itr = itr + 1

  end

end

mainMethod

