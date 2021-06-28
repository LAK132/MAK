set BINDIR=bin
set OBJDIR=obj

set INCDIRS=inc inc\lak\inc
set LIBDIR=
set LIBS=

set SOURCE=src\main.cpp inc\lak\src\debug.cpp inc\lak\src\file.cpp inc\lak\src\memmanip.cpp inc\lak\src\strconv.cpp inc\lak\src\unicode.cpp inc\lak\src\unique_pages.cpp
set BINARY=lake.exe

set CXX=cl /nologo /std:c++latest /MT /EHsc /Zc:__cplusplus /Zc:rvalueCast /Zc:wchar_t /Zc:ternary /DLAK_USE_SDL /D_CRT_SECURE_NO_WARNINGS /DNOMINMAX /DUNICODE

if "%mode%"=="debug" goto debug
if "%mode%"=="release" goto release
if "%mode%"=="nolog" goto nolog
goto :eof

:debug
set COMPFLAGS=/Zi /bigobj /Od
set LINKFLAGS=/SUBSYSTEM:CONSOLE /DEBUG
goto common

:release
set COMPFLAGS=/DNDEBUG /bigobj /O2
set LINKFLAGS=/SUBSYSTEM:CONSOLE
goto common

:nolog
set COMPFLAGS=/DNOLOG /DNDEBUG /bigobj /O2
set LINKFLAGS=/SUBSYSTEM:CONSOLE
goto common

:common
for /f %%f in ('git rev-parse --short HEAD') do (set "git_hash=%%f")
for /f %%f in ('git describe --tags --abbrev^=0') do (set "git_tag=%%f")
(
echo #define GIT_HASH "%git_hash%"
echo #define GIT_TAG "%git_tag%"
)>src\git.hpp
goto :eof
