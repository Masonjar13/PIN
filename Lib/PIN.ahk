#include <AHK_CNG_hashObj>
;#include <AHK_CNG_cryptObj>
#include <db>
#include <crypt>

class pinAuth extends db {
    
    setPath:=a_appData . "\..\Local\PIN\strs.pin"
    
    setPin(pin){
        if(!pin)
            this.key:="",this.kkey:=""
        else
            this._genTempKey(bcrypt.pbkdf2(pin,bcrypt.hash(pin,"MD5"),"SHA512",this._getIterations(pin),500))
    }
    
    setStr(key,str){
        this.put(key,this._encryptStr(str),1)
    }
    
    getStr(key){
        local str,nStr
        str:=this.get(key)
        if(!str){
            errorlevel:="String not found."
            return
        }
        return (nStr:=this._decryptStr(str))=-1?"Password incorrect":nStr
    }

    _encryptStr(str){
        ; BCrypt
        ;return bcrypt.encrypt(str,a_tickCount,this.key) . "_" . a_tickCount

        ; Crypt
        return crypt.Encrypt.StrEncrypt(str,this._decryptTempKey(),7,6)
    }
    
    _decryptStr(str){
        ; BCrypt
        ;str:=subStr(str,1,regexMatch(str,"_.*",iv))
        ;return bcrypt.decrypt(str,iv,this.key)
        
        ; Crypt
        try
            return crypt.Encrypt.StrDecrypt(str,this._decryptTempKey(),7,6)
        catch
            return -1
    }
    
    _getIterations(str){
        nStr:=0
        loop,parse,str
            nStr+=ord(a_loopField)
        return nStr
    }
    
    _genTempKey(str){
        this.key:=crypt.Encrypt.StrEncrypt(str,this.kkey:=bcrypt.hash(a_tickCount*a_now,"MD5"),7,6)
    }
    
    _decryptTempKey(){
        this._genTempKey(t:=crypt.Encrypt.StrDecrypt(this.key,this.kkey,7,6))
        return t
    }
}
