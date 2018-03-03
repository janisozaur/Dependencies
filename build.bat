pushd vcpkg

REM Install libraries
.\vcpkg install curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% openssl:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET%

if errorlevel 1 (
    echo failed with %errorlevel%
    popd
    exit /b 0
)

REM Export libraries
.\vcpkg export curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% openssl:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET% --zip --nuget

popd
