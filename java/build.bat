@echo off

setlocal

if x%ANDROID% == x set ANDROID="F:\Android\SDK"
set ANDROID_PLATFORM=%ANDROID%\platforms\android-27
set DX_LIB=%ANDROID%\build-tools\27.0.0\lib
set EMBO_DEX="F:\Delphi10.1.2\19\lib\android\debug\classes.dex"
set PROJ_DIR=%CD%
set VERBOSE=0

echo.
echo Compiling the Java service activity source files
echo.
mkdir output 2> nul
mkdir output\classes 2> nul
if x%VERBOSE% == x1 SET VERBOSE_FLAG=-verbose
javac %VERBOSE_FLAG% -Xlint:deprecation -cp %ANDROID_PLATFORM%\android.jar -d output\classes src\com\GCMReceiver.java

echo.
echo Creating jar containing the new classes
echo.
mkdir output\jar 2> nul
if x%VERBOSE% == x1 SET VERBOSE_FLAG=v
jar c%VERBOSE_FLAG%f output\jar\test_classes.jar -C output\classes com

echo.
echo Converting from jar to dex...
echo.
mkdir output\dex 2> nul
if x%VERBOSE% == x1 SET VERBOSE_FLAG=--verbose
call dx --dex %VERBOSE_FLAG% --output=%PROJ_DIR%\output\dex\test_classes.dex --positions=lines %PROJ_DIR%\output\jar\test_classes.jar

echo.
echo Merging dex files
echo.
java -cp %DX_LIB%\dx.jar com.android.dx.merge.DexMerger %PROJ_DIR%\output\dex\classes.dex %PROJ_DIR%\output\dex\test_classes.dex %EMBO_DEX%

echo Tidying up
echo.
del output\classes\com\GCMReceiver.class
rmdir output\classes\com\delphi
rmdir output\classes\com\
rmdir output\classes\com
rmdir output\classes
del output\dex\test_classes.dex
del output\jar\test_classes.jar
rmdir output\jar

echo.
echo Now we have the end result, which is output\dex\classes.dex

:Exit

endlocal
