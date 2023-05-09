#!/usr/bin/env bash

./gradlew -Dfile.encoding=UTF-8 --quiet clean build -x test

java -XshowSettings:properties -version 2>&1 | grep file.encoding
file --mime-encoding gradle.properties
file --mime-encoding build/resources/main/target.yml

echo "Gradle Properties"
./gradlew -Dfile.encoding=UTF-8 --quiet properties | grep "_property"

if [[ $(grep -cF 'Square²' build/resources/main/target.yml) -ne 2 ]]; then
	echo "Properties were improperly parsed, expected target to contain 'Square²' twice but got:"
	cat build/resources/main/target.yml
	exit 1
fi
