#!/bin/sh
SERVICE_NAME=MyJavaService
PATH_TO_JAR=/opt/apps/MyJarFile.jar
PID_PATH_NAME=/tmp/MyJavaService-pid
case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then
            sudo nohup java -jar MyJavaOPS $PATH_TO_JAR  &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is already running ..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stoping ..."
            sudo kill $PID;
            echo "$SERVICE_NAME stopped ..."
            sudo rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            sudo kill $PID;
            echo "$SERVICE_NAME stopped ...";
            sudo rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            sudo nohup java -jar MyJavaOPS  $PATH_TO_JAR  &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
esac
