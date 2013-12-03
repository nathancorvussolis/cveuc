
-------------------------------------------------------------------------------

   cveuc 1.1.0

-------------------------------------------------------------------------------

文字コード変換コマンドラインプログラムです。
EUC-JIS-2004(改行LF)、UTF-16(LE、BOMあり、改行CR+LF)、UTF-8(BOMなし、改行LF) を
相互に変換します。

変換テーブルは cygwin の iconv 1.14 と同等としています。

実行方法

   cveuc.exe [-uUW] <input file> <output file>

オプション

   -u : 入力ファイル UTF-8
   -U : 出力ファイル UTF-8
   -W : 出力ファイル UTF-16

使用例

 1) EUC-JIS-2004 → UTF-16
   cveuc.exe euc.txt utf16.txt

 2) EUC-JIS-2004 → UTF-16
   cveuc.exe -W euc.txt utf16.txt

 3) EUC-JIS-2004 → UTF-8
   cveuc.exe -U euc.txt utf8.txt

 4) UTF-16 → EUC-JIS-2004
   cveuc.exe utf16.txt euc.txt

 5) UTF-16 → UTF-8
   cveuc.exe -U utf16.txt utf8.txt

 6) UTF-8 → EUC-JIS-2004
   cveuc.exe -u utf8.txt euc.txt

 7) UTF-8 → UTF-16
   cveuc.exe -u -W utf8.txt utf16.txt

 8) UTF-16 → UTF-16 (単なるコピーと同じ)
   cveuc.exe -W utf16.txt utf16_2.txt

 9) UTF-8 → UTF-8 (単なるコピーと同じ)
   cveuc.exe -u -U utf8.txt utf8_2.txt



-------------------------------------------------------------------------------

   LICENSE

-------------------------------------------------------------------------------

cveuc

The MIT License

Copyright (c) 2012-2013 Nathan Corvus Solis

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

-------------------------------------------------------------------------------

EUC-JIS-2004 (JIS X 0213:2004 Appendix 3) vs Unicode mapping table

Date: 3 May 2009
License:
 Copyright (C) 2001 earthian@tama.or.jp, All Rights Reserved.
 Copyright (C) 2001 I'O, All Rights Reserved.
 Copyright (C) 2006, 2009 Project X0213, All Rights Reserved.
 You can use, modify, distribute this table freely.

-------------------------------------------------------------------------------
