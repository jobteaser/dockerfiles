# Plugins pbuild
FROM openjdk:8 as builder
RUN git clone https://github.com/jenkinsci/job-dsl-plugin.git
RUN cd job-dsl-plugin && ./gradlew jpi
RUN pwd

# Jenkins build
FROM jenkins/jenkins:lts
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Manualy override verride job-dsl plugin
COPY --from=builder /job-dsl-plugin/job-dsl-plugin/build/libs/job-dsl.hpi /var/jenkins_home/plugins/job-dsl.jpi
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
