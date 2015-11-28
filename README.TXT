
-------------------------------------------------------------------------------

   cveuc 2.1.1

-------------------------------------------------------------------------------

文字コード変換コマンドラインプログラムです。
EUC-JIS-2004、UTF-16、UTF-8 を相互に変換します。

変換テーブルは cygwin の iconv 1.14 と同等としています。

実行方法

   cveuc.exe [-euwEUW] <input file> <output file>

オプション

   入力ファイル文字コード指定

      -e : EUC-JIS-2004 (改行LFまたはCR+LF) (デフォルト)
      -u : UTF-8 (BOMなしまたはBOMあり、改行LFまたはCR+LF)
      -w : UTF-16 (LE、BOMなしまたはBOMあり、改行LFまたはCR+LF)

   出力ファイル文字コード指定

      -E : EUC-JIS-2004 (改行LF)
      -U : UTF-8 (BOMなし、改行LF)
      -W : UTF-16 (LE、BOMあり、改行CR+LF) (デフォルト)

使用例

 1) EUC-JIS-2004 → EUC-JIS-2004

   cveuc.exe -E euc.txt euc_2.txt
   cveuc.exe -e -E euc.txt euc_2.txt

 2) EUC-JIS-2004 → UTF-8

   cveuc.exe -U euc.txt utf8.txt
   cveuc.exe -e -U euc.txt utf8.txt

 3) EUC-JIS-2004 → UTF-16

   cveuc.exe euc.txt utf16.txt
   cveuc.exe -e euc.txt utf16.txt
   cveuc.exe -W euc.txt utf16.txt
   cveuc.exe -e -W euc.txt utf16.txt

 4) UTF-16 → EUC-JIS-2004

   cveuc.exe -w -E utf16.txt euc.txt

 5) UTF-16 → UTF-8

   cveuc.exe -w -U utf16.txt utf8.txt

 6) UTF-16 → UTF-16

   cveuc.exe -w utf16.txt utf16_2.txt
   cveuc.exe -w -W utf16.txt utf16_2.txt

 7) UTF-8 → EUC-JIS-2004

   cveuc.exe -u -E utf8.txt euc.txt

 8) UTF-8 → UTF-8

   cveuc.exe -u -U utf8.txt utf8_2.txt

 9) UTF-8 → UTF-16

   cveuc.exe -u utf8.txt utf16.txt
   cveuc.exe -u -W utf8.txt utf16.txt



-------------------------------------------------------------------------------

   LICENSE

-------------------------------------------------------------------------------

cveuc

The MIT License

Copyright (C) 2012-2015 SASAKI Nobuyuki

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
