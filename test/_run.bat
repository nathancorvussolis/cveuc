@pushd %~dp0
setlocal

set OUTDIR=obj
mkdir %OUTDIR%
pushd %OUTDIR%
del /f /q *
popd

set CVEUC="..\Win32\Release\cveuc.exe"



REM Šî–{‹@”\

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



REM Unicode -> EUC-JIS-2004 ŒÝŠ·«

%CVEUC% -u -E euc-jis-2004-with-char-u8.txt %OUTDIR%\_UE_euc-jis-2004-with-char-u8.txt

%CVEUC% -e -U                       euc-jis-2004-with-char.txt   %OUTDIR%\_EC_euc-jis-2004-with-char.txt
iconv -f EUC-JIS-2004 -t UTF-8      euc-jis-2004-with-char.txt > %OUTDIR%\_EI_euc-jis-2004-with-char.txt
nkf --ic=EUC-JIS-2004 --oc=UTF-8 -x euc-jis-2004-with-char.txt > %OUTDIR%\_EN_euc-jis-2004-with-char.txt

%CVEUC% -u -E %OUTDIR%\_EC_euc-jis-2004-with-char.txt %OUTDIR%\_ECC_euc-jis-2004-with-char.txt
%CVEUC% -u -E %OUTDIR%\_EI_euc-jis-2004-with-char.txt %OUTDIR%\_EIC_euc-jis-2004-with-char.txt
%CVEUC% -u -E %OUTDIR%\_EN_euc-jis-2004-with-char.txt %OUTDIR%\_ENC_euc-jis-2004-with-char.txt



REM Unicode -> EUC-JP ŒÝŠ·«

%CVEUC% -j -U                 euc-jp.txt    %OUTDIR%\_JC_euc-jp.txt
iconv -f EUC-JP -t UTF-8      euc-jp.txt >  %OUTDIR%\_JI_euc-jp.txt
nkf --ic=EUC-JP --oc=UTF-8 -x euc-jp.txt >  %OUTDIR%\_JN_euc-jp.txt
uconv -f EUC-JP -t UTF-8      euc-jp.txt >  %OUTDIR%\_JU_euc-jp.txt

%CVEUC% -u -J %OUTDIR%\_JC_euc-jp.txt %OUTDIR%\_JCC_euc-jp.txt
%CVEUC% -u -J %OUTDIR%\_JI_euc-jp.txt %OUTDIR%\_JIC_euc-jp.txt
%CVEUC% -u -J %OUTDIR%\_JN_euc-jp.txt %OUTDIR%\_JNC_euc-jp.txt
%CVEUC% -u -J %OUTDIR%\_JU_euc-jp.txt %OUTDIR%\_JUC_euc-jp.txt



endlocal
@popd

pause
