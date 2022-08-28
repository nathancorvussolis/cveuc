
#include "eucjis2004.h"
#include "eucjp.h"
#include "utf8.h"

#define VERSION			L"2.5.0"

#define BUFSIZE			0x200

LPCWSTR modeRccsUTF16LE = L"rt,ccs=UTF-16LE";
LPCWSTR modeWccsUTF16LE = L"wt,ccs=UTF-16LE";
LPCWSTR modeRccsUTF8 = L"rt,ccs=UTF-8";
LPCWSTR modeRT = L"rt";
LPCWSTR modeWB = L"wb";

enum enum_inenc {
	in_enc_none,
	in_euc_jis_2004,
	in_euc_jp,
	in_utf16,
	in_utf8
};

enum enum_outenc {
	out_enc_none,
	out_euc_jis_2004,
	out_euc_jp,
	out_utf16,
	out_utf8
};

void print_usage(void)
{
	fwprintf(stderr, L"\ncveuc %s\n\n", VERSION);
	fwprintf(stderr, L"usage : cveuc [-ejuw] [-EJUW] <input file name> <output file name>\n"
		L"  option :\n"
		L"    input file encoding :\n"
		L"      -e  EUC-JIS-2004 (LF or CR+LF)\n"
		L"      -j  EUC-JP (LF or CR+LF)\n"
		L"      -u  UTF-8 (with or without BOM, LF or CR+LF)\n"
		L"      -w  UTF-16 (LE, with or without BOM, LF or CR+LF)\n"
		L"    output file encoding :\n"
		L"      -E  EUC-JIS-2004 (LF)\n"
		L"      -J  EUC-JP (LF)\n"
		L"      -U  UTF-8 (without BOM, LF)\n"
		L"      -W  UTF-16 (LE, with BOM, CR+LF)\n"
		);
}

BOOL encode_from_unicode(FILE *fpi, enum_inenc inenc, FILE *fpo, enum_outenc outenc);
BOOL encode_from_euc(FILE *fpi, enum_inenc inenc, FILE *fpo, enum_outenc outenc);

int wmain(int argc, wchar_t *argv[])
{
	BOOL ret = TRUE;
	enum_inenc inenc = in_enc_none;
	enum_outenc outenc = out_enc_none;
	LPCWSTR rmode = modeRT;
	LPCWSTR wmode = modeWB;

	_wsetlocale(LC_ALL, L"");

	if (argc < 5)
	{
		print_usage();
		return -1;
	}

	LPCWSTR inopt = argv[1];
	if (inopt[0] == L'-' || inopt[0] == L'/')
	{
		switch (inopt[1])
		{
		case L'e':
			inenc = in_euc_jis_2004;
			rmode = modeRT;
			break;
		case L'j':
			inenc = in_euc_jp;
			rmode = modeRT;
			break;
		case L'u':
			inenc = in_utf8;
			rmode = modeRccsUTF8;
			break;
		case L'w':
			inenc = in_utf16;
			rmode = modeRccsUTF16LE;
			break;
		default:
			break;
		}
	}

	if (inenc == in_enc_none)
	{
		print_usage();
		return -1;
	}

	LPCWSTR outopt = argv[2];
	if (outopt[0] == L'-' || outopt[0] == L'/')
	{
		switch (outopt[1])
		{
		case L'E':
			outenc = out_euc_jis_2004;
			wmode = modeWB;
			break;
		case L'J':
			outenc = out_euc_jp;
			wmode = modeWB;
			break;
		case L'U':
			outenc = out_utf8;
			wmode = modeWB;
			break;
		case L'W':
			outenc = out_utf16;
			wmode = modeWccsUTF16LE;
			break;
		default:
			break;
		}
	}

	if (outenc == out_enc_none)
	{
		print_usage();
		return -1;
	}

	LPCWSTR infile = argv[3];
	FILE *fpi = nullptr;
	_wfopen_s(&fpi, infile, rmode);
	if (fpi == nullptr)
	{
		fwprintf(stderr, L"error : cannot open %s\n", infile);
		return -1;
	}

	LPCWSTR outfile = argv[4];
	FILE *fpo = nullptr;
	_wfopen_s(&fpo, outfile, wmode);
	if (fpo == nullptr)
	{
		fwprintf(stderr, L"error : cannot open %s\n", outfile);
		fclose(fpi);
		return -1;
	}

	switch (inenc)
	{
	case in_utf16:
	case in_utf8:
		ret = encode_from_unicode(fpi, inenc, fpo, outenc);
		break;
	case in_euc_jis_2004:
	case in_euc_jp:
		ret = encode_from_euc(fpi, inenc, fpo, outenc);
		break;
	default:
		break;
	}

	fclose(fpi);
	fclose(fpo);

	return (ret == TRUE ? 0 : -1);
}

BOOL encode_from_unicode(FILE *fpi, enum_inenc inenc, FILE *fpo, enum_outenc outenc)
{
	BOOL ret = TRUE;
	WCHAR wbuf[BUFSIZE / sizeof(WCHAR)];
	std::string sbuf;
	std::wstring wsbuf;

	for (UINT line = 1; ; line++)
	{
		sbuf.clear();
		wsbuf.clear();

		while (fgetws(wbuf, _countof(wbuf), fpi) != nullptr)
		{
			wsbuf.append(wbuf);

			if (!wsbuf.empty() && wsbuf.back() == L'\n')
			{
				break;
			}
		}

		if (ferror(fpi) != 0)
		{
			ret = FALSE;
			fwprintf(stderr, L"error : file read line %u\n", line);
			break;
		}

		if (wsbuf.empty())
		{
			break;
		}

		switch (outenc)
		{
		case out_euc_jis_2004:
			sbuf = wstring_to_eucjis2004_string(wsbuf);
			if (sbuf.size() > 0)
			{
				fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
			}
			else
			{
				ret = FALSE;
			}
			break;
		case out_euc_jp:
			sbuf = wstring_to_eucjp_string(wsbuf);
			if (sbuf.size() > 0)
			{
				fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
			}
			else
			{
				ret = FALSE;
			}
			break;
		case out_utf16:
			fwprintf(fpo, L"%s", wsbuf.c_str());
			break;
		case out_utf8:
			sbuf = wstring_to_utf8_string(wsbuf);
			if (sbuf.size() > 0)
			{
				fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
			}
			else
			{
				ret = FALSE;
			}
			break;
		default:
			break;
		}

		if (!ret)
		{
			fwprintf(stderr, L"error : cannot convert line %u\n", line);
			break;
		}
	}

	return ret;
}

BOOL encode_from_euc(FILE *fpi, enum_inenc inenc, FILE *fpo, enum_outenc outenc)
{
	BOOL ret = TRUE;
	CHAR buf[BUFSIZE];
	std::string sbuf;
	std::wstring wsbuf;

	for (UINT line = 1; ; line++)
	{
		sbuf.clear();
		wsbuf.clear();

		while (fgets(buf, _countof(buf), fpi) != nullptr)
		{
			sbuf.append(buf);

			if (!sbuf.empty() && sbuf.back() == '\n')
			{
				break;
			}
		}

		if (ferror(fpi) != 0)
		{
			ret = FALSE;
			fwprintf(stderr, L"error : file read line %u\n", line);
			break;
		}

		if (sbuf.empty())
		{
			break;
		}

		switch (inenc)
		{
		case in_euc_jis_2004:
			switch (outenc)
			{
			case out_euc_jis_2004:
				fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
				break;
			case out_euc_jp:
				wsbuf = eucjis2004_string_to_wstring(sbuf);
				if (wsbuf.size() > 0)
				{
					sbuf = wstring_to_eucjp_string(wsbuf);
					if (sbuf.size() > 0)
					{
						fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
					}
					else
					{
						ret = FALSE;
					}
				}
				else
				{
					ret = FALSE;
				}
				break;
			case out_utf8:
				wsbuf = eucjis2004_string_to_wstring(sbuf);
				if (wsbuf.size() > 0)
				{
					sbuf = wstring_to_utf8_string(wsbuf);
					if (sbuf.size() > 0)
					{
						fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
					}
					else
					{
						ret = FALSE;
					}
				}
				else
				{
					ret = FALSE;
				}
				break;
			case out_utf16:
				wsbuf = eucjis2004_string_to_wstring(sbuf);
				if (wsbuf.size() > 0)
				{
					fwprintf(fpo, L"%s", wsbuf.c_str());
				}
				else
				{
					ret = FALSE;
				}
				break;
			default:
				ret = FALSE;
				break;
			}
			break;

		case in_euc_jp:
			switch (outenc)
			{
			case out_euc_jis_2004:
				wsbuf = eucjp_string_to_wstring(sbuf);
				if (wsbuf.size() > 0)
				{
					sbuf = wstring_to_eucjis2004_string(wsbuf);
					if (sbuf.size() > 0)
					{
						fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
					}
					else
					{
						ret = FALSE;
					}
				}
				else
				{
					ret = FALSE;
				}
				break;
			case out_euc_jp:
				fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
				break;
			case out_utf8:
				wsbuf = eucjp_string_to_wstring(sbuf);
				if (wsbuf.size() > 0)
				{
					sbuf = wstring_to_utf8_string(wsbuf);
					if (sbuf.size() > 0)
					{
						fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
					}
					else
					{
						ret = FALSE;
					}
				}
				else
				{
					ret = FALSE;
				}
				break;
			case out_utf16:
				wsbuf = eucjp_string_to_wstring(sbuf);
				if (wsbuf.size() > 0)
				{
					fwprintf(fpo, L"%s", wsbuf.c_str());
				}
				else
				{
					ret = FALSE;
				}
				break;
			default:
				ret = FALSE;
				break;
			}
			break;

		default:
			break;
		}

		if (!ret)
		{
			fwprintf(stderr, L"error : cannot convert line %u\n", line);
			break;
		}
	}

	return ret;
}
