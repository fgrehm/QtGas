#include <QtGui>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDeclarativeComponent>
#include <QScrollArea>

#include "dialog.h"

Dialog::Dialog()
{
    setWindowTitle(tr("QtGas"));

    view = new QDeclarativeView(this);

    view->engine()->setOfflineStoragePath(QDir::currentPath() + "/storage");
    view->rootContext()->setContextProperty("mainDialog", this);

#if !defined(DEBUG)
    view->setSource(QUrl("qrc:/QtGas.qml"));
#else
    view->setSource(QUrl("QtGas.qml"));
#endif

    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);


    QHBoxLayout* layout = new QHBoxLayout();
    layout->setSpacing(0);
    layout->setMargin(0);

    layout->addWidget(view);
    setLayout(layout);

//    connect(btn, SIGNAL(clicked()),
//        this, SIGNAL(myDesktopResized()));
//    connect(QApplication::desktop(), SIGNAL(workAreaResized(int)),
//        this, SLOT(desktopResized(int)));
}
