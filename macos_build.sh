#!/bin/zsh

# exit on error
set -e

rsync -ah x64-osx-openrct2/* universal-osx-openrct2
for lib in x64-osx-openrct2/lib/*.dylib; do
    if [ -f "$lib" ] && [ ! -L $lib ]; then
      lib_filename=$(basename "$lib")
      lib_name=$(echo $lib_filename | cut -d'.' -f 1)
      echo "Creating universal (fat) $lib_name"
      if [ "$lib_name" = "libzip" ]; then
        # libzip embeds the full rpath in LC_RPATH
        # they will be different for arm64 and x86_64
        # this will cause issues, and is unnecessary
        echo Fixing libzip rpath
        install_name_tool -delete_rpath `pwd`"/vcpkg/packages/${lib_name}_x64-osx-openrct2/lib" "x64-osx-openrct2/lib/$lib_filename"
        install_name_tool -delete_rpath `pwd`"/vcpkg/installed/x64-osx-openrct2/x64-osx-openrct2/lib" "x64-osx-openrct2/lib/$lib_filename"
        install_name_tool -delete_rpath `pwd`"/vcpkg/packages/${lib_name}_arm64-osx-openrct2/lib" "arm64-osx-openrct2/lib/$lib_filename"
        install_name_tool -delete_rpath `pwd`"/vcpkg/installed/arm64-osx-openrct2/arm64-osx-openrct2/lib" "arm64-osx-openrct2/lib/$lib_filename"
      fi
      if [[ "$lib_name" = libbrotli* ]]; then
        echo Fixing $lib_name LC_ID_DYLIB
        echo   \> install_name_tool -id "@rpath/$lib_filename" "x64-osx-openrct2/lib/$lib_filename"
        install_name_tool -id "@rpath/$lib_filename" "x64-osx-openrct2/lib/$lib_filename"
      fi
      if otool -L $lib | grep -q /Users/runner/work/; then
        echo Fixing absolute paths in $lib
        if otool -L $lib | grep -q /Users/runner/work; then
          echo "Absolute paths found in $lib. Load commands:"
          otool -L $lib
        fi
        set -x
        # Some packages (currently only brotli) have absolute paths in the LC_LOAD_DYLIB command.
        # This is not supported by the universal build and needs to be changes to @rpath.
        install_name_tool -change /Users/runner/work/Dependencies/Dependencies/vcpkg/packages/brotli_x64-osx-openrct2/lib/libbrotlicommon.1.dylib "@rpath/libbrotlicommon.1.dylib" $lib
        otool -L $lib | grep /Users/runner/work || true
        install_name_tool -change /Users/runner/work/Dependencies/Dependencies/vcpkg/packages/brotli_x64-osx-openrct2/lib/libbrotlidec.1.dylib "@rpath/libbrotlidec.1.dylib" $lib
        otool -L $lib | grep /Users/runner/work || true
        install_name_tool -change /Users/runner/work/Dependencies/Dependencies/vcpkg/packages/brotli_x64-osx-openrct2/lib/libbrotlienc.1.dylib "@rpath/libbrotlienc.1.dylib" $lib
        otool -L $lib | grep /Users/runner/work || true
        # Once done, check that it was the only absolute path in the LC_LOAD_DYLIB command.
        set +x
        if otool -L $lib | grep -q /Users/runner/work; then
          echo "Absolute paths still exist in $lib. Load commands:"
          otool -L $lib
          exit 1
        fi
      fi
      lipo -create "x64-osx-openrct2/lib/$lib_filename" "arm64-osx-openrct2/lib/$lib_filename" -output "universal-osx-openrct2/lib/$lib_filename"
    fi
done

(
  cd universal-osx-openrct2 &&
  zip -rXy ../openrct2-libs-v${version}-universal-macos-dylibs.zip * -x '*/.*'
)
