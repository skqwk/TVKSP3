FROM python:3.9-slim
COPY main.py .
ENV USER=SAM

RUN ["pip", "install", "flask"]
RUN ["useradd", "$USER"]
USER $USER

EXPOSE 5000
ENTRYPOINT ["python", "main.py"]
