#ifndef GRID_H
#define GRID_H
#include <QDebug>
#include <QObject>
#include <QVector>
#include <QTimer>

class Grid : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<int> data READ data WRITE setData NOTIFY dataChanged)
public:
    explicit Grid(QObject *parent = 0);
    ~Grid();
    const QVector<int> data();
    int linePosition;
    Q_INVOKABLE int line();
    Q_INVOKABLE void clear();
    Q_INVOKABLE void setValue(int pos, int value);
    Q_INVOKABLE bool isFull();
    Q_INVOKABLE int win();
    Q_INVOKABLE int atPos(int index);   

signals:
    void dataChanged();
public slots:
    void setData(QVector<int> &d);
private:
    QVector<int> m_data;

};

#endif // GRID_H
