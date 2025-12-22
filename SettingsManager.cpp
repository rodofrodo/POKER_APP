#include "SettingsManager.h"
#include <QFile>
#include <QJsonDocument>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>

SettingsManager::SettingsManager(QObject* parent) : QObject(parent)
{
    // e.g., C:/Users/You/AppData/Local/PokerApp/settings.json
    QString folderPath = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation);

    QDir dir(folderPath);
    if (!dir.exists())
    {
        dir.mkpath(".");
        qDebug() << "Created config folder:" << folderPath;
    }

    m_filePath = folderPath + "/settings.json";
    QFile file(m_filePath);

    if (file.exists())
    {
        qDebug() << "Found settings file. Loading...";
        loadSettings();
    }
    else
    {
        m_bgImg = "green";
        m_cardDeck = "default";
        qDebug() << "No settings file found. Creating new one with defaults.";
        saveSettings();
    }
}

void SettingsManager::loadSettings()
{
    QFile file(m_filePath);
    if (!file.open(QIODevice::ReadOnly))
    {
        qWarning() << "No settings file found, using defaults.";
        return;
    }

    QByteArray data = file.readAll();
    QJsonDocument doc = QJsonDocument::fromJson(data);
    QJsonObject json = doc.object();

    if (json.contains("bgImg"))
        m_bgImg = json["bgImg"].toString();
    if (json.contains("cardDeck"))
        m_cardDeck = json["cardDeck"].toString();

    file.close();
}

void SettingsManager::saveSettings()
{
    QJsonObject json;
    json["bgImg"] = m_bgImg;
    json["cardDeck"] = m_cardDeck;

    QJsonDocument doc(json);
    QFile file(m_filePath);
    if (file.open(QIODevice::WriteOnly))
    {
        file.write(doc.toJson());
        file.close();
        qDebug() << "Settings saved successfully.";
    }
    else
    {
        qWarning() << "Could not save settings! Check permissions.";
    }
}

void SettingsManager::setBgImg(const QString& img)
{
    if (m_bgImg != img)
    {
        m_bgImg = img;
        emit bgImgChanged();
        saveSettings();
    }
}

void SettingsManager::setCardDeck(const QString& deck)
{
    if (m_cardDeck != deck)
    {
        m_cardDeck = deck;
        emit cardDeckChanged();
        saveSettings();
    }
}

QString SettingsManager::getBgImg() const { return m_bgImg; }
QString SettingsManager::getCardDeck() const { return m_cardDeck; }
