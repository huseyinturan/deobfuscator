# deobfuscator
This script parses the clearly decompiled java files like C1234a pattern which are generated from JADX or  http://www.javadecompilers.com/ and replace obfuscated class names with the /\*compiled from : MyClass\*/ pattern original name. So the code becomes more readable for static analysis.

Obfuscation really enforces reverse engineers while making static analysis. But there are some clues about the obfuscated classes in itself. One of them is the ".source MyClass" statements which generally exists in obfuscated classes for debugging purposes in release mode. When app crashes developer can easily detects it crash source by this statement.
On the other hand it is a big clue for reverse engineers about the purpose of the class.
I have developed this little script to replace the obfuscated class names with its real name and replace all its occurance in the code.

This script mainly parse all the decompiled java code which must have pattern like "C1234ab" which can decompiled in http://www.javadecompilers.com/ for example.
And if it has its original source name in /\*compiled from : MyClass\*/, it replaces file name and all its occurances in all the other classes.
At the end we can have more readable code to staticly analyze.

###Example Decompiled Java Class###
```
//file: com/example/myapp/C1234a.java

package com.example.myapp;

import android.content.Context;
import com.example.myapp.p123.C5678b;

/* renamed from: com.example.myapp.a */
/* compiled from: MyClass */
public class C1234a extends C5678b {
```


###After the Deobfuscater Script###
```
//file: com/example/myapp/MyClass.java

package com.example.myapp;

import android.content.Context;
import com.example.myapp.p123.MyParent;

/* renamed from: com.example.myapp.a */
/* compiled from: MyClass */
public class MyClass extends MyParent {
```

Usage:
Change the DIR variable in the script to the folder where the decompiled java classes exists and then run the script ./deobfuscator.sh

IMPORTANT: Please backup your original compiled source, otherwise script changes your original files

