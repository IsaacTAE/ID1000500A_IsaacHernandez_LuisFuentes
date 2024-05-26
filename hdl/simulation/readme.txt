In ID1000500ATB.sv file, in order to work propertly, change the definition 'PATH' to your path ../../sw/ as an abosulte filesystem path. 
Do the same with the file ../../sw/convo.c and change the variable static char 'ruta' to its own path, that is  ../../sw/.
Afterwords, compile with "gcc -o convo convo.c".
