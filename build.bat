pushd vcpkg

REM Install libraries
.\vcpkg install curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET%

REM Export libraries
.\vcpkg export curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET% --zip --nuget

popd
