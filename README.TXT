
-------------------------------------------------------------------------------

  cveuc 2.5.0

-------------------------------------------------------------------------------

文字コード変換コマンドラインプログラムです。
EUC-JIS-2004、EUC-JP、UTF-16、UTF-8 のファイルを相互に変換します。


実行方法

  cveuc.exe [-ejuw] [-EJUW] <input file name> <output file name>


オプション

  入力ファイル文字コード指定

    -e : EUC-JIS-2004 (改行LFまたはCR+LF)
    -j : EUC-JP (改行LFまたはCR+LF)
    -u : UTF-8 (BOMなしまたはBOMあり、改行LFまたはCR+LF)
    -w : UTF-16 (LE、BOMなしまたはBOMあり、改行LFまたはCR+LF)

  出力ファイル文字コード指定

    -E : EUC-JIS-2004 (改行LF)
    -J : EUC-JP (改行LF)
    -U : UTF-8 (BOMなし、改行LF)
    -W : UTF-16 (LE、BOMあり、改行CR+LF)


使用例

  1) EUC-JIS-2004 → UTF-8

    cveuc.exe -e -U euc.txt utf8.txt

  2) EUC-JIS-2004 → UTF-16

    cveuc.exe -e -W euc.txt utf16.txt

  3) EUC-JP → UTF-8

    cveuc.exe -j -U eucjp.txt utf8.txt

  4) EUC-JP → UTF-16

    cveuc.exe -j -W eucjp.txt utf16.txt

  5) UTF-16 → EUC-JIS-2004

    cveuc.exe -w -E utf16.txt euc.txt

  6) UTF-16 → EUC-JP

    cveuc.exe -w -J utf16.txt eucjp.txt

  7) UTF-16 → UTF-8

    cveuc.exe -w -U utf16.txt utf8.txt

  8) UTF-8 → EUC-JIS-2004

    cveuc.exe -u -E utf8.txt euc.txt

  9) UTF-8 → EUC-JP

    cveuc.exe -u -J utf8.txt eucjp.txt

  10) UTF-8 → UTF-16

    cveuc.exe -u -W utf8.txt utf16.txt


互換性

  変換テーブルは基本的に iconv 1.16 と同等としています。

  EUC-JP は、ASCII、JIS X 0208、JIS X 0201 片仮名、JIS X 0212 を実装する
  いわゆる IANA の EUC-JP となっています。

  以下の符号は iconv の EUC-JP では U+2015 へ変換されますが、
  EUC-JIS-2004 と同様に U+2014 としています。

    0xA1BD  U+2014  # EM DASH  Windows: U+2015

  UTF-8 / UTF-16 から EUC-JIS-2004 への変換では、
  以下の符号を多対一の対応としています。

    U+FFE3 or U+203E -> 0xA1B1  # OVERLINE  Windows: U+FFE3
      nkf 2.1.5 : 0xA1B1 -> U+203E

    U+FFE5 or U+00A5 -> 0xA1EF  # YEN SIGN  Windows: U+FFE5
      nkf 2.1.5 : 0xA1EF -> U+00A5

  UTF-8 / UTF-16 から EUC-JP への変換では、
  以下の符号を多対一の対応としています。

    U+FFE3 or U+203E -> 0xA1B1  # OVERLINE  Windows: U+FFE3
      nkf 2.1.5 : 0xA1B1 -> U+203E

    U+FFE5 or U+00A5 -> 0xA1EF  # YEN SIGN  Windows: U+FFE5
      nkf 2.1.5 : 0xA1EF -> U+00A5

    U+2014 or U+2015 -> 0xA1BD  # EM DASH  Windows: U+2015
      iconv 1.16 : 0xA1BD -> U+2015
      icu 69.1 : 0xA1BD -> U+2015

    U+301C or U+FF5E -> 0xA1C1  # WAVE DASH Windows: U+FF5E
      icu 69.1 : 0xA1C1 -> U+FF5E

    U+2016 or U+2225 -> 0xA1C2  # DOUBLE VERTICAL LINE  Windows: U+2225
      icu 69.1 : 0xA1C2 -> U+2225

    U+2212 or U+FF0D -> 0xA1DD  # MINUS SIGN  Windows: U+FF0D
      icu 69.1 : 0xA1DD -> U+FF0D

    U+00A2 or U+FFE0 -> 0xA1F1  # CENT SIGN  Windows: U+FFE0
      icu 69.1 : 0xA1F1 -> U+FFE0

    U+00A3 or U+FFE1 -> 0xA1F2  # POUND SIGN  Windows: U+FFE1
      icu 69.1 : 0xA1F2 -> U+FFE1

    U+00AC or U+FFE2 -> 0xA2CC  # NOT SIGN  [1983]  Windows: U+FFE2
      icu 69.1 : 0xA2CC -> U+FFE2


-------------------------------------------------------------------------------

  LICENSE

-------------------------------------------------------------------------------

cveuc

The MIT License

Copyright (C) 2012-2021 SASAKI Nobuyuki

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

JIS X 0208 (1990) to Unicode
© 2015 Unicode®, Inc.

JIS X 0212 (1990) to Unicode
© 2015 Unicode®, Inc.

COPYRIGHT AND PERMISSION NOTICE

Copyright © 1991-2021 Unicode, Inc. All rights reserved.
Distributed under the Terms of Use in https://www.unicode.org/copyright.html.

Permission is hereby granted, free of charge, to any person obtaining
a copy of the Unicode data files and any associated documentation
(the "Data Files") or Unicode software and any associated documentation
(the "Software") to deal in the Data Files or Software
without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, and/or sell copies of
the Data Files or Software, and to permit persons to whom the Data Files
or Software are furnished to do so, provided that either
(a) this copyright and permission notice appear with all copies
of the Data Files or Software, or
(b) this copyright and permission notice appear in associated
Documentation.

THE DATA FILES AND SOFTWARE ARE PROVIDED "AS IS", WITHOUT WARRANTY OF
ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT OF THIRD PARTY RIGHTS.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN THIS
NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL
DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THE DATA FILES OR SOFTWARE.

Except as contained in this notice, the name of a copyright holder
shall not be used in advertising or otherwise to promote the sale,
use or other dealings in these Data Files or Software without prior
written authorization of the copyright holder.

-------------------------------------------------------------------------------
