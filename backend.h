#pragma once
#include <QObject>
#include <QTcpSocket>
#include <QString>

class Backend : public QObject
{
    Q_OBJECT
        // A property to show connection status in the UI
        Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusChanged)

public:
    explicit Backend(QObject* parent = nullptr);
    QString statusMessage() const;

    // Q_INVOKABLE allows QML to call this C++ function
    Q_INVOKABLE void connectToServer(const QString& ip, const QString& port);
    Q_INVOKABLE void sendMessage_public(const QString& msg);

signals:
    void statusChanged();
    void connectedToServer();

private:
    QTcpSocket* m_socket;
    QString m_status;
    void setStatus(const QString& msg);

	void sendMessage(const QString& msg);
	void onReadyRead();
};
