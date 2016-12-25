#ifndef SNAKEMODEL_H
#define SNAKEMODEL_H

#include <QObject>
#include <QString>
#include <deque>
#include <utility>
#include <set>
#include <random>

class SnakeModel : public QObject
{
    Q_OBJECT
public:
    explicit SnakeModel(QObject *parent = 0);


signals:
    void tileColorChanged(int col, int row, QString color);
public slots:
    void onStart();
    void onTimer();
    void onUserInput(int newXSpeed, int newYSpeed);
private:
    void generateApple();
    void growSnake(int x, int y);
private:
    std::deque<std::pair<int,int>> m_snake;
    std::set<std::pair<int,int>> m_snakeTiles;
    std::random_device m_rd;
    std::mt19937 m_gen;
    std::uniform_int_distribution<> m_dis;
    std::pair<int,int> m_apple;
    int m_xSpeed {1};
    int m_ySpeed {0};
    int m_growUntil {5};
};

#endif // SNAKEMODEL_H
