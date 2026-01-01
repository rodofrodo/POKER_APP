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
        m_bgImg = "macao";
		m_cardBack = "back";
        m_cardDeck = "modern";
		m_color = "#FF007B";
		m_hasSeenTutorial = false;
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
    if (json.contains("cardBack"))
		m_cardBack = json["cardBack"].toString();
    if (json.contains("cardDeck"))
        m_cardDeck = json["cardDeck"].toString();
    if (json.contains("color"))
        m_color = json["color"].toString();
    if (json.contains("hasSeenTutorial"))
		m_hasSeenTutorial = json["hasSeenTutorial"].toBool();

    file.close();
}

void SettingsManager::saveSettings()
{
    QJsonObject json;
    json["bgImg"] = m_bgImg;
	json["cardBack"] = m_cardBack;
    json["cardDeck"] = m_cardDeck;
	json["color"] = m_color;
	json["hasSeenTutorial"] = m_hasSeenTutorial;

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

void SettingsManager::setCardBack(const QString& back)
{
    if (m_cardBack != back)
    {
        m_cardBack = back;
        emit cardBackChanged();
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

void SettingsManager::setColor(const QString& color)
{
    if (m_color != color)
    {
        m_color = color;
        emit colorChanged();
        saveSettings();
    }
}

void SettingsManager::setHasSeenTutorial(bool seen)
{
    if (m_hasSeenTutorial != seen)
    {
        m_hasSeenTutorial = seen;
        emit hasSeenTutorialChanged();
        saveSettings();
    }
}

QString SettingsManager::getBgImg() const { return m_bgImg; }
QString SettingsManager::getCardBack() const { return m_cardBack; }
QString SettingsManager::getCardDeck() const { return m_cardDeck; }
QString SettingsManager::getColor() const { return m_color; }
bool SettingsManager::getHasSeenTutorial() const { return m_hasSeenTutorial; }
