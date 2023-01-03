#!/bin/bash
set -x
cd example-java-maven-lib-3
mvn -B -ntp clean verify

echo " "
echo "Validation..."
[ ! -f target/pmd.xml ] && echo "target/pmd.xml does not exist." && exit 1
[ ! -f target/my-app-1.0.jar ] && echo "target/my-app-1.0.jar does not exist." && exit 1
[ ! -f target/jacoco.exec ] && echo "target/jacoco.exec does not exist." && exit 1
[ ! -f target/surefire-reports/TEST-com.mycompany.app.AppTest.xml ] && echo "target/surefire-reports/TEST-com.mycompany.app.AppTest.xml does not exist." && exit 1
echo "Validation Done"