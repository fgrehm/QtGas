#include <QtGui/QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QSqlQueryModel>
#include <QDir>
#include "dialog.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setAutoSipEnabled(true);

    Dialog dialog;
    dialog.showFullScreen();
    return dialog.exec();






    /*
    TODO: try to add support for OpenGL ES

    QDeclarativeView *canvas = new QDeclarativeView(QUrl("qrc:/qml/main.qml"));
    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(false);
    QGLWidget *glWidget = new QGLWidget(format); // make QmlView use OpenGL ES2 backend.
    glWidget->setAutoFillBackground(false);
    canvas->setViewport(glWidget);
    canvas->setUrl(QUrl::fromLocalFile("/home/user/demos/declarative/flickr/flickr-desktop.qml")); // wherever your qml file is.
    canvas->execute();
    canvas->show();*/
}
