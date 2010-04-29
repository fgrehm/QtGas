#include <QtGui>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDeclarativeComponent>
#include <QScrollArea>

#include "dialog.h"

Dialog::Dialog()
{
    desktopGeometry = QApplication::desktop()->availableGeometry(0);

    setWindowTitle(tr("QtGas"));

//    QScrollArea *scrollArea = new QScrollArea(this);

    view = new QDeclarativeView(this);

    view->engine()->setOfflineStoragePath(QDir::currentPath() + "/storage");

    view->rootContext()->setContextProperty("fontFamily", "DejaVuSans");
    view->rootContext()->setContextProperty("inputFontSize", 26);
    view->rootContext()->setContextProperty("buttonFontSize", 33);
    view->rootContext()->setContextProperty("headingButtonFontSize", 23);
    view->rootContext()->setContextProperty("headingFontSize", 40);
    view->rootContext()->setContextProperty("mainDialog", this);

    view->setSource(QUrl("qrc:/QtGas.qml"));
    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);


    QHBoxLayout* layout = new QHBoxLayout();
    layout->setSpacing(0);
    layout->setMargin(0);

    layout->addWidget(view);
    setLayout(layout);

//    connect(btn, SIGNAL(clicked()),
//        this, SIGNAL(myDesktopResized()));
    connect(QApplication::desktop(), SIGNAL(workAreaResized(int)),
        this, SLOT(desktopResized(int)));
}

void Dialog::desktopResized(int screen)
{
    if (screen != 0)
        return;
    reactToSIP();
}

// TODO: Layout is not ok after closing keyboard, the main qml window goes
//       under WM bottom bar.
void Dialog::reactToSIP()
{
    QRect availableGeometry = QApplication::desktop()->availableGeometry(0);

    if (desktopGeometry != availableGeometry) {
        if (windowState() | Qt::WindowMaximized)
            setWindowState(windowState() & ~Qt::WindowMaximized);

        setGeometry(availableGeometry);
        geometry();
    }

    desktopGeometry = availableGeometry;
}
