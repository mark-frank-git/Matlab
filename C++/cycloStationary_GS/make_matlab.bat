::
:: Batch file for compiling Matlab m files to C library
::
mcc -W lib:scdlib -T link:lib PlotSCD.m dfsm_pace.m
dlltool --def scdlib.exp --dllname scdlib.dll --output-lib scdlib.a
cp scdlib.a C:\Applications\Matlab\extern\include\gcclibs\scdlib.a
cp scdlib.dll C:\Applications\Matlab\extern\include\gcclibs\scdlib.dll

