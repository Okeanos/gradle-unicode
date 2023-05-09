# Gradle Unicode Example

This repository simply contains a minimal [Gradle](https://gradle.org) project that showcases Gradle internal
Unicode/UTF-8 support (or lack thereof).

For this example this is specifically limited to parsing and handling `gradle.properties`.

It relates to the following issues:

- [Gradle#19235](https://github.com/gradle/gradle/issues/19235)
- [Gradle#16763](https://github.com/gradle/gradle/issues/16763)
- [Gradle#22292](https://github.com/gradle/gradle/issues/22292)
- [Gradle#2270](https://github.com/gradle/gradle/issues/2270)

Somewhat related other resources:

- [JEP#400](https://openjdk.org/jeps/400) (JDK 18 and above)
- [JEP#226](https://openjdk.org/jeps/226) (not directly related because it technically only affects Resource Bundles)
