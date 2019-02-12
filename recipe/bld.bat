:: Get minor/major version of libgdal
set GDAL_MAJ_MIN=%PKG_VERSION:~0,3%
set "gdalplugins_ver=%LIBRARY_LIB%\gdalplugins\%GDAL_MAJ_MIN%"
if not exist "%gdalplugins_ver%" mkdir "%gdalplugins_ver%"

call "%RECIPE_DIR%\set_bld_opts.bat"

:: Just build the main DLL, but not install
:: NOTE: can also use 'plugin_dir' target to build defined plugins
nmake /f makefile.vc dll %BLD_OPTS%
if errorlevel 1 exit 1


:: Build/install plugins
pushd frmts\mrsid

  nmake /f makefile.vc plugin plugin-install %BLD_OPTS%
  if errorlevel 1 exit 1

popd

pushd frmts\mrsid_lidar

  nmake /f makefile.vc plugin plugin-install %BLD_OPTS%
  if errorlevel 1 exit 1

popd

:: Move to gdalplugins\x.x (major.minor) subdir
pushd "%LIBRARY_LIB%\gdalplugins"

  for %%G in (gdal_MrSID.dll gdal_MG4Lidar.dll) do (
    if exist %%G move %%G "%gdalplugins_ver%\"
  )

popd
