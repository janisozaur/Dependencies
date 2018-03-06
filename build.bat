pushd vcpkg

REM Install libraries
.\vcpkg install sdl2:%TRIPLET%

type C:\projects\dependencies\vcpkg\buildtrees\sdl2\install-arm-windows-dbg-out.log

appveyor PushArtifact C:\projects\dependencies\vcpkg\buildtrees\sdl2\install-arm-windows-dbg-out.log

#.\vcpkg install curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET%

REM Export libraries
#.\vcpkg export curl:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET% --zip --nuget

popd
