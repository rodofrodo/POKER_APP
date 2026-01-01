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
Q_PROPERTY(QString color READ getColor WRITE setColor NOTIFY colorChanged)
Q_PROPERTY(bool hasSeenTutorial READ getHasSeenTutorial WRITE setHasSeenTutorial NOTIFY hasSeenTutorialChanged)

public:
	explicit SettingsManager(QObject* parent = nullptr);

	// getters
	QString getBgImg() const;
	QString getCardBack() const;
	QString getCardDeck() const;
	QString getColor() const;
	bool getHasSeenTutorial() const;

	// setters
	Q_INVOKABLE void setBgImg(const QString& img);
	Q_INVOKABLE void setCardBack(const QString& back);
	Q_INVOKABLE void setCardDeck(const QString& deck);
	Q_INVOKABLE void setColor(const QString& color);
	Q_INVOKABLE void setHasSeenTutorial(bool seen);

	// file operations
	void loadSettings();
	void saveSettings();

signals:
	void bgImgChanged();
	void cardBackChanged();
	void cardDeckChanged();
	void colorChanged();
	void hasSeenTutorialChanged();

private:
	QString m_filePath;
	QString m_bgImg;
	QString m_cardBack;
	QString m_cardDeck;
	QString m_color;
	bool m_hasSeenTutorial;
};

#endif
