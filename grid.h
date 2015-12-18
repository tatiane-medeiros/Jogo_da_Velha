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
    //linha onde está a sequencia que ganha o jogo
    int linePosition;
    Q_INVOKABLE int line();
    //esvazia o array
    Q_INVOKABLE void clear();
    //altera um valor no array
    Q_INVOKABLE void setValue(int pos, int value);
    //verifica se todas as casas ja foram preenchidas
    Q_INVOKABLE bool isFull();
    //verifica se há vencedor
    Q_INVOKABLE int win();
    //retorna o valor em uma posição do array
    Q_INVOKABLE int atPos(int index);   

signals:
    void dataChanged();
public slots:
    void setData(QVector<int> &d);
private:
    QVector<int> m_data;

};

#endif // GRID_H
