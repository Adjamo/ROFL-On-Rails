#
#  Table Generator for ROFL On Rails
#  Copyright 2010, 2011 Adam Oliver
#  Distributed under the terms of the GNU General Public License
#  Function: Create "table" (in a MySQL database) based on the DB files
#


def check(expectedString, thisToken)

  if expectedString != thisToken
    puts "Error: Found " + thisToken
    puts expectedString + " Expected"
  end

end

def checkNum(thisToken)

  if !thisToken.isnumeric
    puts "Error: Found " + thisToken
    puts "Integer Expected"
  end

end

def parseFile(tokenArray, fileName)

  index = 0

  # tokenArray is an array of all tokens one per element.

  check("HAI", tokenArray[index]); index += 1

  while tokenArray[index] == "TABEL"

    # First token "TABEL" already checked, so move on to next token
    index += 1

    # generate tabel with the name tokenArray[index]
    stream = "use LOL\n";
    stream += "create table if not exists #{tokenArray[index]} ("
    index += 1
    onetime = true

    while tokenArray[index] != "KTHX"

      if onetime
        onetime = false
        stream += "id MEDIUMINT NOT NULL AUTO_INCREMENT, "
      end

      if tokenArray[index+1] == "YARN,"
        # Second token used to make a column, so move on to next token
        stream += "#{tokenArray[index][1..tokenArray[index].length-3]} VARCHAR(#{tokenArray[index+2]}), "
        index += 1
        check("YARN,", tokenArray[index]);
        index += 2;
      end

      if tokenArray[index+1] == "NUM"
        # Second token used to make a column, so move on to next token
        stream += "#{tokenArray[index][1..tokenArray[index].length-3]} INT, "
        index += 1
        check("NUM", tokenArray[index]);
        index += 1;
      end

    end

    stream += " PRIMARY KEY (id))"
    check("KTHX", tokenArray[index]); index += 1

  end


  # Execute MySQL Commands
  IO.popen("mysql -u root -ppass", 'w') { |io| io.puts stream }

  check("KTHXBYE", tokenArray[index]); index += 1

end


def mainMethod

  # Get the MySQL username and password
  username_and_password = File.new("MySQL config.txt", "r")

  user_and_pass=[]
  iter = 0

  username_and_password.each do |line|
    user_and_pass[iter] = line
    iter = iter + 1
  end

  mysql_username = user_and_pass[0][10..user_and_pass[0].length-2]
  mysql_password = user_and_pass[1][10..user_and_pass[1].length-2]

  # Create the LOL database:
  make_db = <<-end
    create database if not exists LOL;
    grant all on website_db.* to #{`id -un`.strip}@localhost;
  end

  # Execute MySQL Commands
  IO.popen("mysql -u #{mysql_username} -p#{mysql_password}", 'w') { |io| io.puts make_db }

  Dir.chdir("./DB/")
  files = Dir.glob("*")

  file_num = files.length
  itr = 0

  while itr < file_num

    # Open the first controller file for reading
    aFile = File.new(files[itr], "r")

    lineArray=[]
    index = 0

    aFile.each do |line|

      line = line.split

      line.each do | token |
        lineArray[index] = token
        index +=1
      end

    end

    parseFile(lineArray, files[itr].gsub(".db",""))

    itr = itr + 1

  end

  Dir.chdir("../")

end

mainMethod

