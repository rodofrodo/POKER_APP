#include "backend.h"

Backend::Backend(QObject* parent) : QObject(parent), m_socket(new QTcpSocket(this))
{
    m_status = "Ready to connect.";

    // Listen for socket state changes
    connect(m_socket, &QTcpSocket::connected, this, [this]() {
        setStatus("Connected successfully!");
        });

    connect(m_socket, &QTcpSocket::errorOccurred, this, [this](QAbstractSocket::SocketError) {
        setStatus("Error: " + m_socket->errorString());
        });
}

QString Backend::statusMessage() const {
    return m_status;
}

void Backend::setStatus(const QString& msg) {
    if (m_status != msg) {
        m_status = msg;
        emit statusChanged();
    }
}

void Backend::connectToServer(const QString& ip, const QString& port) {
    if (m_socket->state() == QAbstractSocket::ConnectedState) {
        m_socket->disconnectFromHost();
    }

    setStatus("Connecting...");
    // Convert string port to integer
    bool ok;
    int portInt = port.toInt(&ok);

    if (ok) {
        m_socket->connectToHost(ip, portInt);
    }
    else {
        setStatus("Invalid Port Number");
    }
}
