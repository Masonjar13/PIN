#singleInstance force
#persistent
#include *i <Lib_1>
#include <PIN>

pin:="1234" ; test PIN
str:="Hello World" ; str to test with
key:="Test" ; ini key name
pinAuthObj:=new pinAuth ; create new object

pinAuthObj.setPin(pin) ; set pin



pinAuthObj.setStr(str,key) ; set/save string

dStr:=pinAuthObj.getStr(key) ; get saved string

msgbox % dStr ; show decrypted string

pinAuthObj.removeStr(key) ; remove saved string

pinAuthObj.getStr(key) ; check for removed key (throws error)
pinAuthObj:= ; release object


; check explicit paths w/ explicit section
header:="Test" ; INI section name
fileName:="file.ini" ; INI file name

pinAuthObj:=new pinAuth(a_scriptDir,fileName)

pinAuthObj.setPin(pin) ; set pin


pinAuthObj.setStr(str,key,header) ; set/save string

dStr:=pinAuthObj.getStr(key,header) ; get saved string

msgbox % dStr ; show decrypted string

pinAuthObj.removeStr(key,header) ; remove saved string
pinAuthObj.removeStr("",header) ; remove entire section

pinAuthObj:= ; release object
exitApp
