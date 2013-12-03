
#include "eucjis2004.h"

#define VERSION		L"1.1.0"

#define BUFSIZE 0x8000

#define RccsUTF8 L"r,ccs=UTF-8"
#define WccsUTF8 L"w,ccs=UTF-8"
#define WccsUTF16LE L"w,ccs=UTF-16LE"
#define RB L"rb"
#define WB L"wb"
#define BOM 0xFEFF

enum enum_outenc {
	out_euc,
	out_utf16,
	out_utf8
};

void print_usage(void)
{
	fwprintf(stderr, L"\ncveuc %s\n\n", VERSION);
	fwprintf(stderr, L"usage : cveuc [option] <input file> <output file>\n");
	fwprintf(stderr, L"   option :\n");
	fwprintf(stderr, L"      -u   input file in UTF-8\n");
	fwprintf(stderr, L"      -U   output file in UTF-8 (LF, without BOM)\n");
	fwprintf(stderr, L"      -W   output file in UTF-16 (CR+LF, LE with BOM)\n");
	fwprintf(stderr, L"\ndefault file encodings : EUC-JIS-2004 and UTF-16(CR+LF, LE with BOM)\n");
}

int wmain(int argc, wchar_t* argv[])
{
	FILE *fpi, *fpo;
	WCHAR bom = L'\0';
	CHAR buf[BUFSIZE*2];
	WCHAR wbuf[BUFSIZE];
	size_t ds;
	BOOL ret;
	UINT line;
	int ai;
	LPCWSTR rflag = RB;
	LPCWSTR wflag = WB;
	int outenc = out_euc;
	LPCWSTR infile, outfile;

	_wsetlocale(LC_ALL, L"JPN");

	if(argc < 3)
	{
		print_usage();
		return -1;
	}

	for(ai=1; ai<3; ai++)
	{
		if(wcscmp(argv[ai], L"-u") == 0)
		{
			bom = BOM;
			rflag = RccsUTF8;
		}
		else if(wcscmp(argv[ai], L"-U") == 0)
		{
			outenc = out_utf8;
		}
		else if(wcscmp(argv[ai], L"-W") == 0)
		{
			outenc = out_utf16;
			wflag = WccsUTF16LE;
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
	outfile = argv[ai+1];

	if(bom == L'\0')
	{
		_wfopen_s(&fpi, infile, RB);
		if(fpi == NULL)
		{
			fwprintf(stderr, L"error : cannot open %s.\n", infile);
			return -1;
		}
		fread(&bom, 2, 1, fpi);
		fclose(fpi);
		if(bom == BOM)
		{
			rflag = RccsUTF8;
		}
		else
		{
			if(outenc == out_euc)
			{
				outenc = out_utf16;
				wflag = WccsUTF16LE;
			}
		}
	}

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

	switch(bom)
	{
	case BOM:
		line = 1;
		while(fgetws(wbuf, _countof(wbuf), fpi) != NULL)
		{
			switch(outenc)
			{
			case out_euc:
				ds = _countof(buf);
				ret = WideCharToEucJis2004(wbuf, NULL, buf, &ds);
				if(ds > 0)
				{
					fwrite(buf, ds - 1, 1, fpo);
				}
				break;
			case out_utf16:
				fwprintf(fpo, L"%s", wbuf);
				break;
			case out_utf8:
				ds = WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, sizeof(buf), NULL, NULL);
				if(ds > 0)
				{
					fwrite(buf, ds - 1, 1, fpo);
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
			line++;
		}

		fclose(fpi);
		fclose(fpo);
		break;

	default:
		line = 1;
		while(fgets(buf, _countof(buf), fpi) != NULL)
		{
			switch(outenc)
			{
			case out_euc:
				ds = strlen(buf);
				fwrite(buf, ds, 1, fpo);
				break;
			case out_utf16:
				ds = _countof(wbuf);
				ret = EucJis2004ToWideChar(buf, NULL, wbuf, &ds);
				if(ds > 0)
				{
					fwprintf(fpo, L"%s", wbuf);
				}
				break;
			case out_utf8:
				ds = _countof(wbuf);
				ret = EucJis2004ToWideChar(buf, NULL, wbuf, &ds);
				if(ds > 0)
				{
					ds = WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, sizeof(buf), NULL, NULL);
					if(ds > 0)
					{
						fwrite(buf, ds - 1, 1, fpo);
					}
					else
					{
						ret = FALSE;
					}
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
			line++;
		}

		fclose(fpi);
		fclose(fpo);
		break;
	}

	return 0;
}
