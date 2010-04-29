#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <QDeclarativeView>

//! [Dialog header]
class Dialog : public QDialog
{
    Q_OBJECT

public:
    Dialog();
    void reactToSIP();

private:
    QRect desktopGeometry;
    QDeclarativeView *view;

public slots:
    void desktopResized(int screen);
};
//! [Dialog header]

#endif
