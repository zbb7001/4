

+#d::
send, {F2}^c
Run, "E:\新建5txt覆盖不提示.vbs"         
sleep,2000

b64Encode(string)
{
    VarSetCapacity(bin, StrPut(string, "UTF-8")) && len := StrPut(string, &bin, "UTF-8") - 1 
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", 0, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    VarSetCapacity(buf, size << 1, 0)
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", &buf, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    return StrGet(&buf)
}


 

 
;MsgBox,4 ,F4+d F4+V , ;%  b64decode( clipboard ), 2

FileAppend, %  b64encode( clipboard ) , E:\5.txt 
sleep, 1000
Run, nircmd.exe clipboard readfile "E:\5.txt"

 