#include "backend.h"
#include "general/globals.h"

Backend::Backend(QObject* parent) : QObject(parent), m_socket(new QTcpSocket(this))
{
    m_status = "Ready to connect.";

    // Listen for socket state changes
    connect(m_socket, &QTcpSocket::connected, this, [this]() {
        setStatus("Connected successfully!");
        emit connectedToServer();
        });

    connect(m_socket, &QTcpSocket::disconnected, this, [this]() {
        setStatus("Disconnected from server.");
		});

	connect(m_socket, &QTcpSocket::readyRead, this, &Backend::onReadyRead);

    connect(m_socket, &QTcpSocket::errorOccurred, this, [this](QAbstractSocket::SocketError) {
        setStatus("Error: " + m_socket->errorString());
        });
}

QString Backend::statusMessage() const
{
    return m_status;
}

void Backend::setStatus(const QString& msg)
{
    if (m_status != msg) {
        m_status = msg;
        emit statusChanged();
    }
}

void Backend::connectToServer(const QString& ip, const QString& port)
{
    if (m_socket->state() == QAbstractSocket::ConnectedState)
    {
        m_socket->disconnectFromHost();
    }

    setStatus("Connecting...");
    // Convert string port to integer
    bool ok;
    int portInt = port.toInt(&ok);

    if (ok)
    {
        m_socket->connectToHost(ip, portInt);
        m_ipAddress = ip;
        m_port = port;
        emit connectionDetailsChanged();
    }
    else
    {
        setStatus("Invalid Port Number");
    }
}

void Backend::sendMessage_public(const QString& msg)
{
    sendMessage(msg);
}

void Backend::sendMessage(const QString& msg)
{
    if (m_socket->state() == QAbstractSocket::ConnectedState)
    {
        QByteArray data = msg.toUtf8();
        m_socket->write(data);
    }
    else
    {
        setStatus("Not connected to server.");
    }
}

void Backend::onReadyRead()
{
    QByteArray data = m_socket->readAll();
    //qDebug() << "Received raw data:" << data;
    QString msg = QString::fromUtf8(data);
    if (msg.startsWith("Length"))
    {
        QStringList parts = msg.split("&");
        if (parts.size() == 2)
        {
            bool ok;
            int length = parts[1].toInt(&ok);
            if (ok)
            {
                emit lobbyReady();
            }
        }
	}
    //setStatus(whatToSend);
}

void Backend::updateName(const QString& name)
{
    m_clientName = name;
    emit updatedName();
}
