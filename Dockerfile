# ДВУХЭТАПНАЯ СБОРКА ПРОЕКТА В DOCKER

ARG BUILD_IMAGE=maven:3.8.3-openjdk-17
ARG RUNTIME_IMAGE=openjdk:18

#############################################################################################
###                 Этап подтягивания Docker'ом всех необходимых зависимостей             ###
#############################################################################################
FROM ${BUILD_IMAGE} as dependencies

COPY ./pom.xml ./

RUN mvn -B dependency:go-offline
#############################################################################################


#############################################################################################
###              Этап построения образа на основе подтянутых зависимостей                 ###
#############################################################################################
FROM dependencies as build
COPY ./src ./src
ENV STUDENT='Есаев Семен Антонович'
ENV IMAGE_PATH='MIREA_Gerb.png'
ENV IMAGE_URL='https://www.mirea.ru/upload/medialibrary/80f/MIREA_Gerb_Colour.png'

RUN curl $IMAGE_URL > "src/main/resources/$IMAGE_PATH"

RUN mvn -B clean package -DskipTests

ONBUILD RUN echo "Автор - $STUDENT"
#############################################################################################


#############################################################################################
###                Этап запуска сервиса, сформированного на предыдующем шаге              ###
#############################################################################################
FROM ${RUNTIME_IMAGE}

ARG STUDENT='Есаев Семен Антонович'
ARG GROUP='ИКБО-01-20'

ENV IMAGE_PATH='MIREA_Gerb.png'
LABEL student=$STUDENT group=$GROUP

ARG JAR_FILE=target/practice3-0.0.1-SNAPSHOT.jar
COPY --from=build ${JAR_FILE} app.jar
RUN echo "#!/bin/bash" >> entrypoint.sh && \
    echo "sleep \$ENTRY_DELAY" >> entrypoint.sh && \
    echo "java -jar app.jar" >> entrypoint.sh   && \
    chmod +x entrypoint.sh
RUN echo $IMAGE_PATH
ENTRYPOINT ["/entrypoint.sh"]
#############################################################################################
