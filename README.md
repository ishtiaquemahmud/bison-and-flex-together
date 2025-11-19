flex filename.l

bison -d -t bisonfilename.y

gcc lex.yy.c filename.tab.c

./a.exe
