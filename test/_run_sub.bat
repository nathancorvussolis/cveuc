@echo off
pushd %~dp0
setlocal enabledelayedexpansion

if not defined CVEUC exit /b 1
if not defined TXTDIR exit /b 1
if not defined OUTDIR exit /b 1

if exist %OUTDIR% (
  rd /s /q %OUTDIR%
)
mkdir %OUTDIR%
pushd %OUTDIR%
del /s /q *
popd



echo.
echo Šî–{‹@”\
echo.

%CVEUC% -e -E "%TXTDIR%\euc_lf.txt" "%OUTDIR%\XE_euc_lf.txt"
%CVEUC% -e -W "%TXTDIR%\euc_lf.txt" "%OUTDIR%\XW_euc_lf.txt"
%CVEUC% -e -U "%TXTDIR%\euc_lf.txt" "%OUTDIR%\XU_euc_lf.txt"

%CVEUC% -e -E "%TXTDIR%\euc_crlf.txt" "%OUTDIR%\XE_euc_crlf.txt"
%CVEUC% -e -W "%TXTDIR%\euc_crlf.txt" "%OUTDIR%\XW_euc_crlf.txt"
%CVEUC% -e -U "%TXTDIR%\euc_crlf.txt" "%OUTDIR%\XU_euc_crlf.txt"

%CVEUC% -u -E "%TXTDIR%\utf8_lf.txt" "%OUTDIR%\XE_utf8_lf.txt"
%CVEUC% -u -W "%TXTDIR%\utf8_lf.txt" "%OUTDIR%\XW_utf8_lf.txt"
%CVEUC% -u -U "%TXTDIR%\utf8_lf.txt" "%OUTDIR%\XU_utf8_lf.txt"

%CVEUC% -u -E "%TXTDIR%\utf8_crlf.txt" "%OUTDIR%\XE_utf8_crlf.txt"
%CVEUC% -u -W "%TXTDIR%\utf8_crlf.txt" "%OUTDIR%\XW_utf8_crlf.txt"
%CVEUC% -u -U "%TXTDIR%\utf8_crlf.txt" "%OUTDIR%\XU_utf8_crlf.txt"

%CVEUC% -u -E "%TXTDIR%\utf8_bom_lf.txt" "%OUTDIR%\XE_utf8_bom_lf.txt"
%CVEUC% -u -W "%TXTDIR%\utf8_bom_lf.txt" "%OUTDIR%\XW_utf8_bom_lf.txt"
%CVEUC% -u -U "%TXTDIR%\utf8_bom_lf.txt" "%OUTDIR%\XU_utf8_bom_lf.txt"

%CVEUC% -u -E "%TXTDIR%\utf8_bom_crlf.txt" "%OUTDIR%\XE_utf8_bom_crlf.txt"
%CVEUC% -u -W "%TXTDIR%\utf8_bom_crlf.txt" "%OUTDIR%\XW_utf8_bom_crlf.txt"
%CVEUC% -u -U "%TXTDIR%\utf8_bom_crlf.txt" "%OUTDIR%\XU_utf8_bom_crlf.txt"

%CVEUC% -w -E "%TXTDIR%\utf16_lf.txt" "%OUTDIR%\XE_utf16_lf.txt"
%CVEUC% -w -W "%TXTDIR%\utf16_lf.txt" "%OUTDIR%\XW_utf16_lf.txt"
%CVEUC% -w -U "%TXTDIR%\utf16_lf.txt" "%OUTDIR%\XU_utf16_lf.txt"

%CVEUC% -w -E "%TXTDIR%\utf16_crlf.txt" "%OUTDIR%\XE_utf16_crlf.txt"
%CVEUC% -w -W "%TXTDIR%\utf16_crlf.txt" "%OUTDIR%\XW_utf16_crlf.txt"
%CVEUC% -w -U "%TXTDIR%\utf16_crlf.txt" "%OUTDIR%\XU_utf16_crlf.txt"

%CVEUC% -w -E "%TXTDIR%\utf16_bom_lf.txt" "%OUTDIR%\XE_utf16_bom_lf.txt"
%CVEUC% -w -W "%TXTDIR%\utf16_bom_lf.txt" "%OUTDIR%\XW_utf16_bom_lf.txt"
%CVEUC% -w -U "%TXTDIR%\utf16_bom_lf.txt" "%OUTDIR%\XU_utf16_bom_lf.txt"

%CVEUC% -w -E "%TXTDIR%\utf16_bom_crlf.txt" "%OUTDIR%\XE_utf16_bom_crlf.txt"
%CVEUC% -w -W "%TXTDIR%\utf16_bom_crlf.txt" "%OUTDIR%\XW_utf16_bom_crlf.txt"
%CVEUC% -w -U "%TXTDIR%\utf16_bom_crlf.txt" "%OUTDIR%\XU_utf16_bom_crlf.txt"

set ERRORCOUNT=0
for %%f in ( ^
    "%OUTDIR%\XE_euc_lf.txt" ^
    "%OUTDIR%\XE_euc_crlf.txt" ^
    "%OUTDIR%\XE_utf8_lf.txt" ^
    "%OUTDIR%\XE_utf8_crlf.txt" ^
    "%OUTDIR%\XE_utf8_bom_lf.txt" ^
    "%OUTDIR%\XE_utf8_bom_crlf.txt" ^
    "%OUTDIR%\XE_utf16_lf.txt" ^
    "%OUTDIR%\XE_utf16_crlf.txt" ^
    "%OUTDIR%\XE_utf16_bom_lf.txt" ^
    "%OUTDIR%\XE_utf16_bom_crlf.txt" ^
  ) do (
  fc /n "%TXTDIR%\euc_lf.txt" %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
  )
)
if !ERRORCOUNT! equ 0 (
  echo -E : Succeeded.
) else (
  echo -E : Failed.
)

set ERRORCOUNT=0
for %%f in ( ^
    "%OUTDIR%\XW_euc_lf.txt" ^
    "%OUTDIR%\XW_euc_crlf.txt" ^
    "%OUTDIR%\XW_utf8_lf.txt" ^
    "%OUTDIR%\XW_utf8_crlf.txt" ^
    "%OUTDIR%\XW_utf8_bom_lf.txt" ^
    "%OUTDIR%\XW_utf8_bom_crlf.txt" ^
    "%OUTDIR%\XW_utf16_lf.txt" ^
    "%OUTDIR%\XW_utf16_crlf.txt" ^
    "%OUTDIR%\XW_utf16_bom_lf.txt" ^
    "%OUTDIR%\XW_utf16_bom_crlf.txt" ^
  ) do (
  fc /n /u "%TXTDIR%\utf16_bom_crlf.txt" %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
  )
)
if !ERRORCOUNT! equ 0 (
  echo -W : Succeeded.
) else (
  echo -W : Failed.
)

set ERRORCOUNT=0
for %%f in ( ^
    "%OUTDIR%\XU_euc_lf.txt" ^
    "%OUTDIR%\XU_euc_crlf.txt" ^
    "%OUTDIR%\XU_utf8_lf.txt" ^
    "%OUTDIR%\XU_utf8_crlf.txt" ^
    "%OUTDIR%\XU_utf8_bom_lf.txt" ^
    "%OUTDIR%\XU_utf8_bom_crlf.txt" ^
    "%OUTDIR%\XU_utf16_lf.txt" ^
    "%OUTDIR%\XU_utf16_crlf.txt" ^
    "%OUTDIR%\XU_utf16_bom_lf.txt" ^
    "%OUTDIR%\XU_utf16_bom_crlf.txt" ^
  ) do (
  fc /n "%TXTDIR%\utf8_lf.txt" %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
  )
)
if !ERRORCOUNT! equ 0 (
  echo -U : Succeeded.
) else (
  echo -U : Failed.
)



echo.
echo Unicode ¨ EUC-JIS-2004 ŒÝŠ·«
echo.

%CVEUC% -u -E "%TXTDIR%\euc-jis-2004-with-char-u8.txt" "%OUTDIR%\_ECC_euc-jis-2004-with-char-u8.txt"

%CVEUC% -e -U                       "%TXTDIR%\euc-jis-2004-with-char.txt"   "%OUTDIR%\_EC_euc-jis-2004-with-char.txt"
iconv -f EUC-JIS-2004 -t UTF-8      "%TXTDIR%\euc-jis-2004-with-char.txt" > "%OUTDIR%\_EI_euc-jis-2004-with-char.txt"
nkf --ic=EUC-JIS-2004 --oc=UTF-8 -x "%TXTDIR%\euc-jis-2004-with-char.txt" > "%OUTDIR%\_EN_euc-jis-2004-with-char.txt"

%CVEUC% -u -E "%OUTDIR%\_EC_euc-jis-2004-with-char.txt" "%OUTDIR%\_ECC_euc-jis-2004-with-char.txt"
%CVEUC% -u -E "%OUTDIR%\_EI_euc-jis-2004-with-char.txt" "%OUTDIR%\_EIC_euc-jis-2004-with-char.txt"
%CVEUC% -u -E "%OUTDIR%\_EN_euc-jis-2004-with-char.txt" "%OUTDIR%\_ENC_euc-jis-2004-with-char.txt"

set ERRORCOUNT=0
for %%f in ( ^
    "%OUTDIR%\_ECC_euc-jis-2004-with-char-u8.txt" ^
    "%OUTDIR%\_ECC_euc-jis-2004-with-char.txt" ^
    "%OUTDIR%\_EIC_euc-jis-2004-with-char.txt" ^
    "%OUTDIR%\_ENC_euc-jis-2004-with-char.txt" ^
  ) do (
  fc /n "%TXTDIR%\euc-jis-2004-with-char.txt" %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
    echo Failed. %%f
  )
)
if !ERRORCOUNT! equ 0 (
  echo Succeeded.
) else (
  echo Failed.
)



echo.
echo Unicode ¨ EUC-JP ŒÝŠ·«
echo.

%CVEUC% -j -U                 "%TXTDIR%\euc-jp.txt"    "%OUTDIR%\_JC_euc-jp.txt"
iconv -f EUC-JP -t UTF-8      "%TXTDIR%\euc-jp.txt" >  "%OUTDIR%\_JI_euc-jp.txt"
nkf --ic=EUC-JP --oc=UTF-8 -x "%TXTDIR%\euc-jp.txt" >  "%OUTDIR%\_JN_euc-jp.txt"
uconv -f EUC-JP -t UTF-8      "%TXTDIR%\euc-jp.txt" >  "%OUTDIR%\_JU_euc-jp.txt"

%CVEUC% -u -J "%OUTDIR%\_JC_euc-jp.txt" "%OUTDIR%\_JCC_euc-jp.txt"
%CVEUC% -u -J "%OUTDIR%\_JI_euc-jp.txt" "%OUTDIR%\_JIC_euc-jp.txt"
%CVEUC% -u -J "%OUTDIR%\_JN_euc-jp.txt" "%OUTDIR%\_JNC_euc-jp.txt"
%CVEUC% -u -J "%OUTDIR%\_JU_euc-jp.txt" "%OUTDIR%\_JUC_euc-jp.txt"

set ERRORCOUNT=0
for %%f in ( ^
    "%OUTDIR%\_JIC_euc-jp.txt" ^
    "%OUTDIR%\_JNC_euc-jp.txt" ^
    "%OUTDIR%\_JUC_euc-jp.txt" ^
  ) do (
  fc /n "%OUTDIR%\_JCC_euc-jp.txt" %%f > nul
  if !ERRORLEVEL! neq 0 (
    set /a ERRORCOUNT = !ERRORCOUNT! + 1
    echo Failed. %%f
  )
)
if !ERRORCOUNT! equ 0 (
  echo Succeeded.
) else (
  echo Failed.
)



endlocal
popd
