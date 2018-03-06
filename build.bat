pushd vcpkg

REM Install libraries
.\vcpkg install sdl2:%TRIPLET%

.\vcpkg install curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET%

REM Export libraries
.\vcpkg export curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET% --zip --nuget --7zip

popd
