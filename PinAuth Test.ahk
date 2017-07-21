#singleInstance force
#persistent
#include *i <Lib_1>
#include <PIN>
fileName:="test.pin" ; test file
pin:="1234" ; test PIN
key1:="Herro",str1:="Hello World."
key2:="Laterz",str2:="Goodbye World."
key3:="Oh",str3:="Biography here."
key4:="asdf;lkjasdfl;kjawsefjoiw3rhiawefoijadfasdofijwefh",str4:="Monotremes are best."

fileDelete,% fileName
pinAuthObj:=new pinAuth(a_scriptDir . "\" . fileName)
pinAuthObj.setPin(pin)

pinAuthObj.setStr(key4,str4)
pinAuthObj.setStr(key1,str1)
pinAuthObj.setStr(key2,str2)
pinAuthObj.setStr(key3,str3)
msgbox % pinAuthObj.getStr(key3)
msgbox % pinAuthObj.getStr(key1)
pinAuthObj.removeStr(key1)
msgbox % pinAuthObj.getStr(key4)
msgbox % pinAuthObj.getStr(key1)
pinAuthObj:=""
exitApp
