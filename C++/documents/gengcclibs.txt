::
:: bat file for creating MATLAB import libraries for gcc
::
dlltool --def libeng.def	--dllname libeng.dll		--output-lib libeng.a
dlltool --def libfixedpoint.def	--dllname libfixedpoint.dll	--output-lib libfixedpoint.a
dlltool --def libmat.def	--dllname libmat.dll		--output-lib libmat.a
dlltool --def libmatlb.def	--dllname libmatlb.dll		--output-lib libmatlb.a
dlltool --def libmex.def	--dllname libmex.dll		--output-lib libmex.a
dlltool --def libmmfile.def	--dllname libmmfile.dll		--output-lib libmmfile.a
dlltool --def libmwmcl.def	--dllname libmwmcl.dll		--output-lib libmwmcl.a
dlltool --def libmwservices.def	--dllname libmwservices.dll	--output-lib libmwservices.a
dlltool --def libmwsglm.def	--dllname libmwsglm.dll		--output-lib libmwsglm.a
dlltool --def libmx.def		--dllname libmx.dll		--output-lib libmx.a
dlltool --def libut.def		--dllname libut.dll		--output-lib libut.a
dlltool --def mclcom.def	--dllname mclcom.dll		--output-lib mclcom.a
dlltool --def mclcommain.def	--dllname mclcommain.dll	--output-lib mclcommain.a
dlltool --def mclxlmain.def	--dllname mclxlmain.dll		--output-lib mclxlmain.a
dlltool --def sgl.def		--dllname sgl.dll		--output-lib sgl.a

md gcclibs
move *.a .\gcclibs