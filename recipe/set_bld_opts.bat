setlocal EnableDelayedExpansion

if "%ARCH%"=="64" (
    set WIN64="WIN64=YES"
) else (
    set WIN64=
)

:: Work out MSVC_VER - needed for build process.
:: Currently guess from Python version
if  %vc% LEQ 9 set MSVC_VER=1500
if  %vc% GTR 9 set MSVC_VER=1900

:: Need consistent flags between build and install.
:: Minimal drivers build, to focus on plugin driver build
set BLD_OPTS=%WIN64% ^
    MSVC_VER=%MSVC_VER% ^
    GDAL_HOME=%LIBRARY_PREFIX% ^
    BINDIR=%LIBRARY_BIN% ^
    PLUGINDIR=%LIBRARY_LIB%\gdalplugins ^
    LIBDIR=%LIBRARY_LIB% ^
    INCDIR=%LIBRARY_INC% ^
    DATADIR=%LIBRARY_PREFIX%\share\gdal ^
    GEOS_CFLAGS="-I%LIBRARY_INC% -DHAVE_GEOS" ^
    GEOS_DIR=%LIBRARY_PREFIX% ^
    GEOS_LIB=%LIBRARY_LIB%\geos_c.lib ^
    JPEGDIR=%LIBRARY_INC% ^
    JPEG_EXTERNAL_LIB=1 ^
    JPEG_LIB=%LIBRARY_LIB%\libjpeg.lib ^
    PNGDIR=%LIBRARY_INC% ^
    PNG_EXTERNAL_LIB=1 ^
    PNG_LIB=%LIBRARY_LIB%\libpng.lib ^
    PROJ_FLAGS=-DPROJ_STATIC ^
    PROJ_INCLUDE="-I%LIBRARY_INC%" ^
    PROJ_LIBRARY=%LIBRARY_LIB%\proj.lib ^
    TIFF_INC="-I%LIBRARY_INC%" ^
    TIFF_LIB=%LIBRARY_LIB%\tiff.lib ^
    TIFF_OPTS=-DBIGTIFF_SUPPORT ^
    GEOTIFF_INC="-I%LIBRARY_INC%" ^
    GEOTIFF_LIB=%LIBRARY_LIB%\geotiff_i.lib ^
    LIBICONV_INCLUDE="-I%LIBRARY_INC% -DICONV_CONST= " ^
    LIBICONV_LIBRARY="%LIBRARY_LIB%\iconv.lib" ^
    MRSID_DIR="%SRC_DIR%\MrSID_DSDK" ^
    MRSID_JP2=YES ^
    MRSID_PLUGIN=YES ^
    MRSID_LIDAR_PLUGIN=YES ^
    MRSID_CONFIG=Release ^
    MRSID_SHOW_CONFIG=YES


endlocal && set BLD_OPTS=%BLD_OPTS%
