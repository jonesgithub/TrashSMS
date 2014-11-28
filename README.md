README of TrashSMS
===============

###brief
基于中文分词和训练的本地垃圾短息判断。

###Usage
1. 将TrashSMS目录下的SMS.mm, SMS.h和scws拷贝到你的工程中

2. 链接libscws.dylib

3. Build and run

###Other
libscws.dylib由scws目录下的工程编译得到

####release tips
在发布时应该把libscws.dylib放在/usr/lib/下

dict.utf8.xdb和rules.utf8.ini则应该放在/usr/bin/下(可以在SMS.mm中更改这两个的地址)

####关于TrashData.plist
TrashSMS目录下的TrashData.plist是一个TrashData的示范, NSDictionary

Key是由分词得到的短语, value则是它的权值, 权值越高, 越可能是垃圾短信。

###API
具体的API信息请查看SMS.h

###Thanks
Thanks scws project. 