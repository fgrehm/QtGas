#-------------------------------------------------
#
# Project created by QtCreator 2010-03-25T00:00:26
#
#-------------------------------------------------

QT       += core gui declarative sql

TARGET = QtGas
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

RESOURCES += \
    resources.qrc

OTHER_FILES += \
    qml/main.qml \
    qml/GradientBar.qml \
    qml/GradientButton.qml \
    scripts/database.js \
    images/service.png \
    images/gas.png
