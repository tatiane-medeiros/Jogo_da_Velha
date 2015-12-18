#include "grid.h"

Grid::Grid(QObject *parent) : QObject(parent)
{
    m_data.fill(0,9);
    linePosition = 0;
}

Grid::~Grid()
{}

const QVector<int> Grid::data()
{
    return m_data;
}

int Grid::line()
{
    return linePosition;
}

void Grid::clear()
{
    m_data.clear();
    m_data.fill(0,9);
    linePosition = 0;
}

void Grid::setValue(int pos, int value)
{
    m_data.replace(pos, value);
}

bool Grid::isFull()
{
    for(int i=0; i<9; ++i){
        if(m_data[i] == 0) return false;
    }
    return true;
}

int Grid::win()
{
    if(m_data[0]!=0 && m_data[0]==m_data[1] && m_data[0] == m_data[2]){ linePosition = 1; return m_data[0];}
    else if(m_data[3]!=0 && m_data[3]==m_data[4] && m_data[3] == m_data[5]){ linePosition = 2; return m_data[3];}
    else if(m_data[6]!=0 && m_data[6]==m_data[7] && m_data[6] == m_data[8]){linePosition=3; return m_data[6];}
    else if(m_data[0]!=0 && m_data[0]==m_data[3] && m_data[0] == m_data[6]){linePosition=4; return m_data[0];}
    else if(m_data[1]!=0 && m_data[1]==m_data[4] && m_data[4] == m_data[7]){linePosition=5; return m_data[1];}
    else if(m_data[2]!=0 && m_data[2]==m_data[5] && m_data[5] == m_data[8]){linePosition=6; return m_data[2];}
    else if(m_data[0]!=0 && m_data[4]==m_data[0] && m_data[4] == m_data[8]){linePosition=7; return m_data[0];}
    else if(m_data[2]!=0 && m_data[2]==m_data[4] && m_data[6] == m_data[4]){linePosition=8; return m_data[2];}
    else return 0;
}

int Grid::atPos(int index)
{
    return m_data.at(index);
}


void Grid::setData(QVector<int> &d)
{
    m_data = d;
    emit dataChanged();
}

