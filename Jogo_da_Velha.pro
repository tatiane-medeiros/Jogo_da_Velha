TEMPLATE = app

QT += qml quick


HEADERS += \
    grid.h

SOURCES += main.cpp \
    grid.cpp

RC_FILE += dialogo.rc

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

