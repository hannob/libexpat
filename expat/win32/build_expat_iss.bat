REM HIGHLY EXPERIMENTAL :)
REM BUILT TO BE CALLED FROM PARENT FOLDER
REM
SET GENERATOR=Visual Studio 15 2017

REM Note that expat.iss has path "win32\bin\Release" hard-coded
SET CONFIGURATION=Release

DEL expat.sln || EXIT /b 1
MD win32\Bin || EXIT /b 1


MD build_shared_char || EXIT /b 1
CD build_shared_char || EXIT /b 1
cmake -G"%GENERATOR%" -DCMAKE_BUILD_TYPE=%CONFIGURATION% .. || EXIT /b 1
msbuild expat.sln || EXIT /b 1
DIR %CONFIGURATION% || EXIT /b 1
COPY %CONFIGURATION%\expat.dll ..\win32\Bin\expat.dll || EXIT /b 1
COPY %CONFIGURATION%\expat.lib ..\win32\Bin\expat.lib || EXIT /b 1
COPY xmlwf\%CONFIGURATION%\xmlwf.exe ..\win32\Bin\xmlwf.exe || EXIT /b 1
CD .. || EXIT /b 1


MD build_static_char || EXIT /b 1
CD build_static_char || EXIT /b 1
cmake -G"%GENERATOR%" -DCMAKE_BUILD_TYPE=%CONFIGURATION% -DBUILD_shared=OFF -DMSVC_USE_STATIC_CRT=ON .. || EXIT /b 1
msbuild expat.sln || EXIT /b 1
DIR %CONFIGURATION% || EXIT /b 1
COPY %CONFIGURATION%\expat.lib ..\win32\Bin\expatMT.lib || EXIT /b 1
CD .. || EXIT /b 1


MD build_shared_wchar_t || EXIT /b 1
CD build_shared_wchar_t || EXIT /b 1
cmake -G"%GENERATOR%" -DCMAKE_BUILD_TYPE=%CONFIGURATION% -DXML_UNICODE=ON -DXML_UNICODE_WCHAR_T=ON -DBUILD_tools=OFF .. || EXIT /b 1
msbuild expat.sln || EXIT /b 1
DIR %CONFIGURATION% || EXIT /b 1
COPY %CONFIGURATION%\expatw.dll ..\win32\Bin\expatw.dll || EXIT /b 1
COPY %CONFIGURATION%\expatw.lib ..\win32\Bin\expatw.lib || EXIT /b 1
CD .. || EXIT /b 1


MD build_static_wchar_t || EXIT /b 1
CD build_static_wchar_t || EXIT /b 1
cmake -G"%GENERATOR%" -DCMAKE_BUILD_TYPE=%CONFIGURATION% -DBUILD_shared=OFF -DMSVC_USE_STATIC_CRT=ON -DXML_UNICODE=ON -DXML_UNICODE_WCHAR_T=ON -DBUILD_tools=OFF .. || EXIT /b 1
msbuild expat.sln || EXIT /b 1
DIR %CONFIGURATION% || EXIT /b 1
COPY %CONFIGURATION%\expat.lib ..\win32\Bin\expatwMT.lib || EXIT /b 1
CD .. || EXIT /b 1


DIR win32\Bin || EXIT /b 1
iscc win32\expat.iss || EXIT /b 1
