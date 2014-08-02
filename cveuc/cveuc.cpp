
#include "eucjis2004.h"
#include "utf8.h"

#define VERSION			L"2.0.0"

#define BUFSIZE			0x800

#define RccsUTF8		L"r,ccs=UTF-8"
#define WccsUTF8		L"w,ccs=UTF-8"
#define RccsUTF16LE		L"r,ccs=UTF-16LE"
#define WccsUTF16LE		L"w,ccs=UTF-16LE"
#define RB				L"rb"
#define WB				L"wb"

enum enum_inenc {
	in_euc,
	in_utf16,
	in_utf8
};

enum enum_outenc {
	out_euc,
	out_utf16,
	out_utf8
};

void print_usage(void)
{
	fwprintf(stderr, L"\ncveuc %s\n\n", VERSION);
	fwprintf(stderr, L"usage : cveuc [option] <input file> <output file>\n"
		L"   option :\n"
		L"      input file encoding :\n"
		L"         -e   EUC-JIS-2004 (LF) (default)\n"
		L"         -u   UTF-8 (with or without BOM, LF or CR+LF)\n"
		L"         -w   UTF-16 (LE, with or without BOM, LF or CR+LF)\n"
		L"      output file encoding :\n"
		L"         -E   EUC-JIS-2004 (LF)\n"
		L"         -U   UTF-8 (without BOM, LF)\n"
		L"         -W   UTF-16 (LE, with BOM, CR+LF) (default)\n"
		);
}

int wmain(int argc, wchar_t* argv[])
{
	FILE *fpi, *fpo;
	CHAR buf[BUFSIZE * sizeof(WCHAR)];
	LPSTR pb;
	WCHAR wbuf[BUFSIZE];
	LPWSTR pwb;
	std::string sbuf;
	std::wstring wsbuf;
	size_t ds;
	BOOL ret;
	UINT line;
	LPCWSTR rflag = RB, wflag = WccsUTF16LE;
	int ai, inenc = in_euc, outenc = out_utf16;
	LPCWSTR infile, outfile;

	_wsetlocale(LC_ALL, L"JPN");

	if(argc < 3)
	{
		print_usage();
		return -1;
	}

	for(ai = 1; ai < 3; ai++)
	{
		if(wcscmp(argv[ai], L"-e") == 0)
		{
		}
		else if(wcscmp(argv[ai], L"-u") == 0)
		{
			inenc = in_utf8;
			rflag = RccsUTF8;
		}
		else if(wcscmp(argv[ai], L"-w") == 0)
		{
			inenc = in_utf16;
			rflag = RccsUTF16LE;
		}
		else if(wcscmp(argv[ai], L"-E") == 0)
		{
			outenc = out_euc;
			wflag = WB;
		}
		else if(wcscmp(argv[ai], L"-U") == 0)
		{
			outenc = out_utf8;
			wflag = WB;
		}
		else if(wcscmp(argv[ai], L"-W") == 0)
		{
		}
		else
		{
			if(argv[ai][0] == L'-')
			{
				print_usage();
				return -1;
			}
			break;
		}
	}

	if(argc < ai + 2)
	{
		print_usage();
		return -1;
	}

	infile = argv[ai];
	outfile = argv[ai + 1];

	_wfopen_s(&fpi, infile, rflag);
	if(fpi == NULL)
	{
		fwprintf(stderr, L"error : cannot open %s\n", infile);
		return -1;
	}
	_wfopen_s(&fpo, outfile, wflag);
	if(fpo == NULL)
	{
		fwprintf(stderr, L"error : cannot open %s\n", outfile);
		fclose(fpi);
		return -1;
	}

	if(inenc == in_utf8 || inenc == in_utf16)
	{
		for(line = 1; ; line++)
		{
			sbuf.clear();
			wsbuf.clear();

			while((pwb = fgetws(wbuf, _countof(wbuf), fpi)) != NULL)
			{
				wsbuf.append(wbuf);

				if(!wsbuf.empty() && wsbuf.back() == L'\n')
				{
					break;
				}
			}

			if(pwb == NULL)
			{
				break;
			}

			ret = TRUE;

			switch(outenc)
			{
			case out_euc:
				ds = -1;
				ret = WideCharToEucJis2004(wsbuf.c_str(), NULL, NULL, &ds);
				if(ds > 0)
				{
					sbuf = wstring_to_eucjis2004_string(wsbuf);
					fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
				}
				break;
			case out_utf16:
				fwprintf(fpo, L"%s", wsbuf.c_str());
				break;
			case out_utf8:
				sbuf = wstring_to_utf8_string(wsbuf);
				fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
				break;
			default:
				break;
			}

			if(!ret)
			{
				fwprintf(stderr, L"error : cannot convert line %u\n", line);
				break;
			}
		}

		fclose(fpi);
		fclose(fpo);
	}
	else
	{
		for(line = 1; ; line++)
		{
			sbuf.clear();
			wsbuf.clear();

			while((pb = fgets(buf, _countof(buf), fpi)) != NULL)
			{
				sbuf.append(buf);

				if(!sbuf.empty() && sbuf.back() == '\n')
				{
					break;
				}
			}

			if(pb == NULL)
			{
				break;
			}

			ret = TRUE;

			switch(outenc)
			{
			case out_euc:
				fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
				break;
			case out_utf16:
				ds = -1;
				ret = EucJis2004ToWideChar(sbuf.c_str(), NULL, NULL, &ds);
				if(ds > 0)
				{
					wsbuf = eucjis2004_string_to_wstring(sbuf);
					fwprintf(fpo, L"%s", wsbuf.c_str());
				}
				break;
			case out_utf8:
				ds = -1;
				ret = EucJis2004ToWideChar(sbuf.c_str(), NULL, NULL, &ds);
				if(ds > 0)
				{
					wsbuf = eucjis2004_string_to_wstring(sbuf);
					sbuf = wstring_to_utf8_string(wsbuf);
					fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
				}
				break;
			default:
				break;
			}

			if(!ret)
			{
				fwprintf(stderr, L"error : cannot convert line %u\n", line);
				break;
			}
		}

		fclose(fpi);
		fclose(fpo);
	}

	return 0;
}
