#
#   ROTR.rex - the lexical scanner for ROTR.racc
#   Copyright (C) 2010, 2011  Adam Oliver
# 
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as
#   published by the Free Software Foundation, either version 3 of the
#   License, or (at your option) any later version.
# 
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
# 
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

class ROTR
macro
  BLANK         \s+
rule
  {BLANK}
  :PARSE {BLANK}
  (#!.+)                               { [:HASHBANG, text] }
  (<\?HAI)             { state = :PARSE; [:HAI, text] }
  :PARSE (VISIBLE)                     { [:VISIBLE, text] }
  :PARSE (KTHXBYE\?>)     { state = nil; [:KTHXBYE, text] }
  :PARSE (CAN\sHAS\sMYSQL)             { [:MYSQL, text] }
  :PARSE (MAEK\sDB)                    { [:MAEKDB, text] }
  :PARSE (UZE)                         { [:UZE, text] }
  :PARSE (MAEK\sTABELZ)                { [:MAEKTABELZ, text] }
  :PARSE [(]                           { [:OP, text] }
  :PARSE [)]                           { [:CP, text] }
  :PARSE (IZ)                          { [:IZ, text] }
  :PARSE (YARN)                        { [:YARN, text] }
  :PARSE (EDIT)                        { [:EDIT, text] }
  :PARSE (DEL)                         { [:DEL, text] }
  :PARSE (NUMBR)                       { [:NUMBR, text] }
  :PARSE [0-9]+                        { [:POSINT, text] }
  :PARSE (GIMMEH)                      { [:GIMMEH, text] }
  :PARSE (FROM)                        { [:FROM, text] }
  :PARSE [*]                           { [:ASTERISK, text] }
  :PARSE [,]                           { [:COMMA, text] }
  :PARSE (ADDZ)                        { [:ADDZ, text] }
  :PARSE (BIGGR\sTHAN)                 { [:BIGGRTHAN, text] }
  :PARSE (SMALLR\sTHAN)                { [:SMALLRTHAN, text] }
  :PARSE (BOTH\sSAEM)                  { [:BOTHSAEM, text] }
  :PARSE (YARLY)                       { [:YARLY, text] }
  :PARSE (NOWAI)                       { [:NOWAI, text] }
  :PARSE (WHERE)                       { [:WHERE, text] }
  :PARSE (GET_PARAMS)                  { [:GET_PARAMS, text] }
  :PARSE (>)                           { [:GT, text] }
  :PARSE (=)                           { [:EQ, text] }
  :PARSE (<)                           { [:LT, text] }
  :PARSE (LIEK)                        { [:LIEK, text] }
  :PARSE (I\sHAS\sA)                   { [:IHASA, text] }
  :PARSE (ITZ)                         { [:ITZ, text] }
  :PARSE (BTW).*                       

  :PARSE (KTHX)                        { [:KTHX, text] }
  :PARSE ([A-Za-z]+)                   { [:WORD, text] }
  :PARSE ["][^"]+["]                   { [:STRING, text] }
  .*                                   { [:NONLOL, text] }

inner
end
