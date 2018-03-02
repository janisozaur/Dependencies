REM Install upstream vcpkg

git clone -q https://github.com/janisozaur/vcpkg.git
robocopy /v /fp triplets vcpkg/triplets/
cd vcpkg
call .\bootstrap-vcpkg.bat
git pull

REM Uninstall out of date packages so they are updated
.\vcpkg remove --outdated --recurse

REM Install libraries
.\vcpkg install libzip:%TRIPLET%

.\vcpkg export libzip:%TRIPLET% --zip --nuget --7zip
