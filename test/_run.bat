@pushd %~dp0
setlocal

set OUTDIR=obj
mkdir %OUTDIR%

set CVEUC="..\Release\cveuc.exe"

%CVEUC% -e -E euc_lf.txt %OUTDIR%\XE_euc_lf.txt
%CVEUC% -e -W euc_lf.txt %OUTDIR%\XW_euc_lf.txt
%CVEUC% -e -U euc_lf.txt %OUTDIR%\XU_euc_lf.txt

%CVEUC% -e -E euc_crlf.txt %OUTDIR%\XE_euc_crlf.txt
%CVEUC% -e -W euc_crlf.txt %OUTDIR%\XW_euc_crlf.txt
%CVEUC% -e -U euc_crlf.txt %OUTDIR%\XU_euc_crlf.txt

%CVEUC% -u -E utf8_lf.txt %OUTDIR%\XE_utf8_lf.txt
%CVEUC% -u -W utf8_lf.txt %OUTDIR%\XW_utf8_lf.txt
%CVEUC% -u -U utf8_lf.txt %OUTDIR%\XU_utf8_lf.txt

%CVEUC% -u -E utf8_crlf.txt %OUTDIR%\XE_utf8_crlf.txt
%CVEUC% -u -W utf8_crlf.txt %OUTDIR%\XW_utf8_crlf.txt
%CVEUC% -u -U utf8_crlf.txt %OUTDIR%\XU_utf8_crlf.txt

%CVEUC% -u -E utf8_bom_lf.txt %OUTDIR%\XE_utf8_bom_lf.txt
%CVEUC% -u -W utf8_bom_lf.txt %OUTDIR%\XW_utf8_bom_lf.txt
%CVEUC% -u -U utf8_bom_lf.txt %OUTDIR%\XU_utf8_bom_lf.txt

%CVEUC% -u -E utf8_bom_crlf.txt %OUTDIR%\XE_utf8_bom_crlf.txt
%CVEUC% -u -W utf8_bom_crlf.txt %OUTDIR%\XW_utf8_bom_crlf.txt
%CVEUC% -u -U utf8_bom_crlf.txt %OUTDIR%\XU_utf8_bom_crlf.txt

%CVEUC% -w -E utf16_lf.txt %OUTDIR%\XE_utf16_lf.txt
%CVEUC% -w -W utf16_lf.txt %OUTDIR%\XW_utf16_lf.txt
%CVEUC% -w -U utf16_lf.txt %OUTDIR%\XU_utf16_lf.txt

%CVEUC% -w -E utf16_crlf.txt %OUTDIR%\XE_utf16_crlf.txt
%CVEUC% -w -W utf16_crlf.txt %OUTDIR%\XW_utf16_crlf.txt
%CVEUC% -w -U utf16_crlf.txt %OUTDIR%\XU_utf16_crlf.txt

%CVEUC% -w -E utf16_bom_lf.txt %OUTDIR%\XE_utf16_bom_lf.txt
%CVEUC% -w -W utf16_bom_lf.txt %OUTDIR%\XW_utf16_bom_lf.txt
%CVEUC% -w -U utf16_bom_lf.txt %OUTDIR%\XU_utf16_bom_lf.txt

%CVEUC% -w -E utf16_bom_crlf.txt %OUTDIR%\XE_utf16_bom_crlf.txt
%CVEUC% -w -W utf16_bom_crlf.txt %OUTDIR%\XW_utf16_bom_crlf.txt
%CVEUC% -w -U utf16_bom_crlf.txt %OUTDIR%\XU_utf16_bom_crlf.txt

%CVEUC% -e -U euc-jis-2004-with-char.txt %OUTDIR%\_EU_euc-jis-2004-with-char.txt

REM cannot convert line 204
REM 0xA1B1 U+203E # OVERLINE Windows: U+FFE3
%CVEUC% -u -E euc-jis-2004-with-char-u8.txt %OUTDIR%\_UE_euc-jis-2004-with-char-u8.txt

endlocal
@popd

pause
