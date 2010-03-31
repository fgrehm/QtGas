#include <QtGui/QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QSqlQueryModel>
#include <QDir>
#include "mainwindow.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);


//    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setDatabaseName("qtgas.db");
//    bool ok = db.open();

//    QSqlQueryModel model;
//    model.setQuery("SELECT * FROM records");

    QDeclarativeView view;

//    QDeclarativeContext ctxt = view.rootContext();
//    ctxt.setContextProperty("MyModel", QVariant::fromValue(model));

    view.engine()->setOfflineStoragePath(QDir::currentPath() + "/storage");
    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.showMaximized();
    //view.show();






    /*QDeclarativeView *canvas = new QDeclarativeView(QUrl("qrc:/qml/main.qml"));
    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(false);
    QGLWidget *glWidget = new QGLWidget(format); // make QmlView use OpenGL ES2 backend.
    glWidget->setAutoFillBackground(false);
    canvas->setViewport(glWidget);
    canvas->setUrl(QUrl::fromLocalFile("/home/user/demos/declarative/flickr/flickr-desktop.qml")); // wherever your qml file is.
    canvas->execute();
    canvas->show();*/




    return a.exec();
}
