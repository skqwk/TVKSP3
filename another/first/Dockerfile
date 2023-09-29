FROM alpine:3.14
LABEL author="Семен Есаев"
ONBUILD RUN echo 'Образ собран'

ENV DIR='work'

RUN mkdir $DIR
ADD log-event.sh $DIR
WORKDIR $DIR
VOLUME $DIR

RUN ["./log-event.sh", "image created"]
ENTRYPOINT ["./log-event.sh"]
CMD ["image running"]