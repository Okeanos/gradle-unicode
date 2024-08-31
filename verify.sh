#!/usr/bin/env bash

echo "Build Projects"
pushd ./iso-8859-1 >/dev/null || exit 1
./gradlew --no-daemon --quiet clean build -x test
popd >/dev/null || exit 1
pushd ./utf-8 >/dev/null || exit 1
./gradlew -Dfile.encoding=UTF-8 --no-daemon --quiet clean build -x test
popd >/dev/null || exit 1
pushd ./maven >/dev/null || exit 1
./mvnw --quiet clean resources:resources >./mvn.log
popd >/dev/null || exit 1

echo ""
echo ""

echo "Java default file encoding"
java -XshowSettings:properties -version 2>&1 | grep file.encoding

echo ""
echo ""

echo "Gradle Properties for gradle-iso-8859-1"
pushd ./iso-8859-1 >/dev/null || exit 1
./gradlew --no-daemon --quiet properties | grep "_property"
popd >/dev/null || exit 1

echo "Encoding of relevant gradle-iso-8859-1 files"
iso_source="iso-8859-1/gradle.properties"
iso_target="iso-8859-1/build/resources/main/target.yml"
file --mime-encoding "${iso_source}"
file --mime-encoding "${iso_target}"

if [[ $(grep -cF 'Square²' "${iso_target}") -ne 2 ]]; then
	echo "::error file=${iso_target}::Properties were improperly parsed, expected target to contain 'Square²' twice"
else
	echo "::notice file=${iso_target}::Properties were properly parsed"
fi

if [[ $(grep -cF '🤯' "${iso_target}") -eq 1 ]]; then
	echo "::notice file=${iso_target}::Emoji was properly processed"
else
	echo "::error file=${iso_target}::Emoji wasn't properly processed, was expecting: 🤯"
fi

echo "gradle-iso-8859-1 source contents: ${iso_source}"
printf "%s" "$(<${iso_source})"
echo "gradle-iso-8859-1 target contents: ${iso_target}"
printf "%s" "$(<${iso_target})"
echo ""
echo ""

echo "Gradle Properties for gradle-utf-8"
pushd ./utf-8 >/dev/null || exit 1
./gradlew -Dfile.encoding=UTF-8 --no-daemon --quiet properties | grep "_property"
popd >/dev/null || exit 1

echo "Encoding of relevant gradle-utf-8 files"
utf8_source="utf-8/gradle.properties"
utf8_target="utf-8/build/resources/main/target.yml"
file --mime-encoding "${utf8_source}"
file --mime-encoding "${utf8_target}"

if [[ $(grep -cF 'Square²' "${utf8_target}") -ne 2 ]]; then
	echo "::error file=${utf8_target}::Properties were improperly parsed, expected target to contain 'Square²' twice"
else
	echo "::notice file=${utf8_target}::Properties were properly parsed"
fi

if [[ $(grep -cF '🤯' "${utf8_target}") -eq 1 ]]; then
	echo "::notice file=${utf8_target}::Emoji was properly processed"
else
	echo "::error file=${utf8_target}::Emoji wasn't properly processed, was expecting: 🤯"
fi

echo "gradle-utf-8 source contents: ${utf8_target}"
printf "%s" "$(<${utf8_target})"
echo "gradle-utf-8 target contents: ${utf8_target}"
printf "%s" "$(<${utf8_target})"
echo ""
echo ""

echo "Encoding of relevant maven files"
maven_target="maven/target/classes/target.yml"
file --mime-encoding maven/pom.xml
file --mime-encoding "${maven_target}"

if [[ $(grep -cF 'Square²' "${maven_target}") -ne 1 ]]; then
	echo "::error file=${maven_target}::Properties were improperly parsed, expected target to contain 'Square²' once"
else
	echo "::notice file=${maven_target}::Properties were properly parsed"
fi

if [[ $(grep -cF '🤯' "${maven_target}") -eq 1 ]]; then
	echo "::notice file=${maven_target}::Emoji was properly processed"
else
	echo "::error ::Emoji wasn't properly processed, was expecting: 🤯"
fi

echo "maven target contents: ${maven_target}"
printf "%s" "$(<${maven_target})"
