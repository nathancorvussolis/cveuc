
#include "eucjis2004.h"
#include "utf8.h"

#define VERSION			L"2.2.0"

#define BUFSIZE			0x800

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
		L"         -e   EUC-JIS-2004 (LF or CR+LF) (default)\n"
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
	BOOL ret;
	UINT line;
	LPCWSTR rflag = RB, wflag = WccsUTF16LE;
	int ai, inenc = in_euc, outenc = out_utf16;
	LPCWSTR infile, outfile;

	setlocale(LC_ALL, "");

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
			rflag = RB;
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
	if(fpi == nullptr)
	{
		fwprintf(stderr, L"error : cannot open %s\n", infile);
		return -1;
	}
	_wfopen_s(&fpo, outfile, wflag);
	if(fpo == nullptr)
	{
		fwprintf(stderr, L"error : cannot open %s\n", outfile);
		fclose(fpi);
		return -1;
	}

	if(inenc == in_utf16)
	{
		for(line = 1; ; line++)
		{
			sbuf.clear();
			wsbuf.clear();

			while((pwb = fgetws(wbuf, _countof(wbuf), fpi)) != nullptr)
			{
				wsbuf.append(wbuf);

				if(!wsbuf.empty() && wsbuf.back() == L'\n')
				{
					break;
				}
			}

			if(pwb == nullptr)
			{
				break;
			}

			ret = TRUE;

			switch(outenc)
			{
			case out_euc:
				sbuf = wstring_to_eucjis2004_string(wsbuf);
				if(sbuf.size() > 0)
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
				if(sbuf.size() > 0)
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

			while((pb = fgets(buf, _countof(buf), fpi)) != nullptr)
			{
				sbuf.append(buf);

				if(!sbuf.empty() && sbuf.back() == '\n')
				{
					break;
				}
			}

			if(pb == nullptr)
			{
				break;
			}

			if(inenc == in_utf8 && sbuf.size() >= 3 && sbuf.substr(0, 3) == "\xEF\xBB\xBF")
			{
				sbuf.erase(0, 3);
			}

			if(sbuf.size() >= 2 && sbuf.substr(sbuf.size() - 2) == "\r\n")
			{
				sbuf.erase(sbuf.size() - 2);
				sbuf.push_back('\n');
			}

			ret = TRUE;

			switch(inenc)
			{
			case in_euc:
				switch(outenc)
				{
				case out_euc:
					fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
					break;
				case in_utf8:
					wsbuf = eucjis2004_string_to_wstring(sbuf);
					if(wsbuf.size() > 0)
					{
						sbuf = wstring_to_utf8_string(wsbuf);
						if(sbuf.size() > 0)
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
					if(wsbuf.size() > 0)
					{
						fwprintf(fpo, L"%s", wsbuf.c_str());
					}
					else
					{
						ret = FALSE;
					}
					break;
				default:
					break;
				}
				break;

			case in_utf8:
				switch(outenc)
				{
				case out_euc:
					wsbuf = utf8_string_to_wstring(sbuf);
					if(wsbuf.size() > 0)
					{
						sbuf = wstring_to_eucjis2004_string(wsbuf);
						if(sbuf.size() > 0)
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
				case in_utf8:
					fwrite(sbuf.c_str(), sbuf.size(), 1, fpo);
					break;
				case out_utf16:
					wsbuf = utf8_string_to_wstring(sbuf);
					if(wsbuf.size() > 0)
					{
						fwprintf(fpo, L"%s", wsbuf.c_str());
					}
					else
					{
						ret = FALSE;
					}
					break;
				default:
					break;
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
