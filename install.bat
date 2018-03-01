REM Install upstream vcpkg

git clone -q https://github.com/Microsoft/vcpkg.git
cd vcpkg
call .\bootstrap-vcpkg.bat
git pull

REM Uninstall out of date packages so they are updated
.\vcpkg remove --outdated --recurse

REM Install libraries
.\vcpkg install breakpad:%TRIPLET% curl:%TRIPLET% discord-rpc:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% openssl:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET%

REM Export libraries
.\vcpkg export breakpad:%TRIPLET% curl:%TRIPLET% discord-rpc:%TRIPLET% freetype:%TRIPLET% jansson:%TRIPLET% libpng:%TRIPLET% libzip:%TRIPLET% openssl:%TRIPLET% sdl2:%TRIPLET% speexdsp:%TRIPLET% zlib:%TRIPLET% --zip --nuget
