#ifndef SETTINGSMANAGER_H
#define SETTINGSMANAGER_H

#include <QObject>
#include <QJsonObject>
#include <QString>

class SettingsManager : public QObject
{
Q_OBJECT
Q_PROPERTY(QString bgImg READ getBgImg WRITE setBgImg NOTIFY bgImgChanged)
Q_PROPERTY(QString cardBack READ getCardBack WRITE setCardBack NOTIFY cardBackChanged)
Q_PROPERTY(QString cardDeck READ getCardDeck WRITE setCardDeck NOTIFY cardDeckChanged)

public:
	explicit SettingsManager(QObject* parent = nullptr);

	// getters
	QString getBgImg() const;
	QString getCardBack() const;
	QString getCardDeck() const;

	// setters
	Q_INVOKABLE void setBgImg(const QString& img);
	Q_INVOKABLE void setCardBack(const QString& back);
	Q_INVOKABLE void setCardDeck(const QString& deck);

	// file operations
	void loadSettings();
	void saveSettings();

signals:
	void bgImgChanged();
	void cardBackChanged();
	void cardDeckChanged();

private:
	QString m_filePath;
	QString m_bgImg;
	QString m_cardBack;
	QString m_cardDeck;
};

#endif
