#!/usr/bin/env bash
set -euo pipefail

yq e -i '(.sources[] | select(.title == env(TITLE1)).name) = env(TEAM1)' settings.yml
yq e -i '(.sources[] | select(.title == env(TITLE1)).authName) = env(BB_USER)' settings.yml
yq e -i '(.sources[] | select(.title == env(TITLE1)).password) = env(BB_PASSWORD)' settings.yml

yq e -i '(.sources[] | select(.title == env(TITLE2)).name) = env(TEAM2)' settings.yml
yq e -i '(.sources[] | select(.title == env(TITLE2)).authName) = env(BB_USER)' settings.yml
yq e -i '(.sources[] | select(.title == env(TITLE2)).password) = env(BB_PASSWORD)' settings.yml

exec dotnet ScmBackup.dll
