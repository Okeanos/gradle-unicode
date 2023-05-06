#!/usr/bin/env bash

file --mime-encoding gradle.properties
file --mime-encoding build/resources/main/target.yml

./gradlew -Dfile.encoding=UTF-8 clean build -x test

if [[ $(grep -cF 'Square²' build/resources/main/target.yml) -ne 2 ]]; then
	echo "Properties were improperly parsed, expected target to contain 'Square²' twice but got:"
	cat build/resources/main/target.yml
	exit 1
fi
