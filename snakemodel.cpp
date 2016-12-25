#include <QDebug>
#include <QQmlEngine>
#include "snakemodel.h"



SnakeModel::SnakeModel(QObject *parent) : QObject(parent), m_gen(m_rd()), m_dis(0, 40)
{

}

void SnakeModel::onStart()
{
    m_xSpeed = 1;
    m_ySpeed = 0;
    m_growUntil = 5;
    for (const auto& e: m_snake)
    {
        emit tileColorChanged(e.first, e.second, "yellow");
    }
    m_snake.clear();
    m_snakeTiles.clear();
    emit tileColorChanged(m_apple.first, m_apple.second, "yellow");

    growSnake(0,0);
    generateApple();


}

void SnakeModel::onTimer()
{
    int newX = m_snake.front().first + m_xSpeed;
        int newY = m_snake.front().second + m_ySpeed;
    if (newX == m_apple.first && newY == m_apple.second)
    {
        m_growUntil += 5;
    }
    else
    {
        if (0 == m_growUntil)
        {
            emit tileColorChanged(m_snake.back().first, m_snake.back().second, "yellow");
            m_snakeTiles.erase({m_snake.back().first, m_snake.back().second});
            m_snake.pop_back();
        }
    }

    if (newX == 40 || newX < 0 ||
            newY == 40 || newY < 0 ||
            (m_snakeTiles.end() != m_snakeTiles.find({newX,newY}))
             )
    {
        onStart();
    }
    else
    {
        growSnake(newX, newY);

        if (0 < m_growUntil)
        {
            m_growUntil--;
        }

        if (newX == m_apple.first && newY == m_apple.second)
        {
            generateApple();
        }
    }
}

void SnakeModel::onUserInput(int newXSpeed, int newYSpeed)
{
    if (0 == newXSpeed || (m_xSpeed != (-1)*newXSpeed))
    {
        m_xSpeed = newXSpeed;
    }
    if (0 == newYSpeed || (m_ySpeed != (-1)*newYSpeed))
    {
        m_ySpeed = newYSpeed;
    }
    onTimer();
}

void SnakeModel::generateApple()
{
    bool generateAgain = false;
    do {
        m_apple.first = m_dis(m_gen);
        m_apple.second = m_dis(m_gen);
        auto found = m_snakeTiles.find({m_apple.first,m_apple.second});
        if (m_snakeTiles.end() != found)
        {
            generateAgain = true;
        }
        else
        {
            generateAgain = false;
        }
    }while (generateAgain);

    qDebug() << "generated apple:" << m_apple.first << "," << m_apple.second;

    emit tileColorChanged(m_apple.first, m_apple.second, "red");
}

void SnakeModel::growSnake(int x, int y)
{
    m_snake.push_front({x,y});
    m_snakeTiles.insert({x,y});
    emit tileColorChanged(x, y, "green");
}
