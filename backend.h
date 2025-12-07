#pragma once
#include <QObject>
#include <QTcpSocket>
#include <QString>

class Backend : public QObject
{
    Q_OBJECT
        // A property to show connection status in the UI
        Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusChanged)
        Q_PROPERTY(QString ipAddress READ getIpAddress NOTIFY connectionDetailsChanged)
        Q_PROPERTY(QString port READ getPort NOTIFY connectionDetailsChanged)
        Q_PROPERTY(QString clientName READ getName NOTIFY updatedName)

public:
    explicit Backend(QObject* parent = nullptr);
    QString statusMessage() const;

    QString getIpAddress() const { return m_ipAddress; }
    QString getPort() const { return m_port; }
    QString getName() const { return m_clientName; }

    // Q_INVOKABLE allows QML to call this C++ function
    Q_INVOKABLE void connectToServer(const QString& ip, const QString& port);
    Q_INVOKABLE void sendMessage_public(const QString& msg);
    Q_INVOKABLE void updateName(const QString& name);

    QString m_ipAddress;
    QString m_port;
    QString m_clientName;

signals:
    void statusChanged();
    void connectedToServer();
    void lobbyReady();
    void connectionDetailsChanged();
    void updatedName();

private:
    QTcpSocket* m_socket;
    QString m_status;

    void setStatus(const QString& msg);
	void sendMessage(const QString& msg);
	void onReadyRead();
};
