DROP TABLE UsersToWords;
DROP TABLE Oauth;
DROP TABLE UsersToPagesUrls;
DROP TABLE UsersToDomainNames;
DROP TABLE Users;
DROP TABLE WordsToArticles;
DROP TABLE PagesUrls;
DROP TABLE DomainNames;
DROP TABLE ArticlesToWords;
DROP TABLE Images;
DROP TABLE Links;
DROP TABLE Paragraphs;
DROP TABLE Articles;

USE BerryBoxDB;

CREATE TABLE IF NOT EXISTS Articles (
	id VARCHAR (50) NOT NULL,
	url VARCHAR(500) NOT NULL,
	article_hash_code VARCHAR(50) NOT NULL,
	article_last_modified_datetime_str VARCHAR(15),
	article_last_modified_datetime_timezone VARCHAR(10),
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	indexing_status VARCHAR(10) DEFAULT 'unindexed',
	indexing_updated TIMESTAMP,
	UNIQUE KEY (article_hash_code),
	KEY (article_hash_code),
	KEY (article_last_modified_datetime_str),
	KEY (indexing_status),
	KEY (indexing_updated),
	KEY (created),
	KEY (updated),
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Paragraphs (
	paragraph_id VARCHAR(50) NOT NULL,
	article_id VARCHAR(50) NOT NULL,
	paragraph_content VARCHAR(500) NOT NULL,
	paragraph_content_hash_code VARCHAR(50) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	UNIQUE KEY (paragraph_content_hash_code),
	KEY (paragraph_content_hash_code),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (article_id) REFERENCES Articles(id),
	PRIMARY KEY (paragraph_id, article_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Links (
	link_id VARCHAR(50) NOT NULL,
	article_id VARCHAR(50) NOT NULL,
	url VARCHAR(500) NOT NULL,
	domain_name VARCHAR(100) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (link_id),
	KEY (article_id),
	KEY (url),
	KEY (domain_name),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (article_id) REFERENCES Articles(id),
	PRIMARY KEY (link_id, article_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Images (
	image_id VARCHAR(50) NOT NULL,
	article_id VARCHAR(50) NOT NULL,
	url VARCHAR(50) NOT NULL,
	width INT NOT NULL,
	height INT NOT NULL,
	image_hash_code VARCHAR(50) NOT NULL,
	important_score INT NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	UNIQUE KEY (image_hash_code),
	KEY (image_hash_code),
	KEY (important_score),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (article_id) REFERENCES Articles(id),
	PRIMARY KEY (image_id, article_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS ArticlesToWords (
	word VARCHAR(5) NOT NULL,
	article_id VARCHAR(50) NOT NULL,
	counter BIGINT DEFAULT 0,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (counter),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (article_id) REFERENCES Articles(id),
	PRIMARY KEY (word, article_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS DomainNames (
	domain_name VARCHAR(50) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (created),
	KEY (updated),
	PRIMARY KEY (domain_name)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS PagesUrls (
	page_url VARCHAR(230) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (created),
	KEY (updated),
	PRIMARY KEY (page_url)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS WordsToArticles (
	word VARCHAR(30) NOT NULL,
	article_id VARCHAR(50) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (word),
	KEY (article_id),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (article_id) REFERENCES Articles(id),
	PRIMARY KEY (word, article_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Users (
	id VARCHAR(50) NOT NULL,
	email VARCHAR(300),
	password_hash_code VARCHAR(50),
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	activated BOOLEAN NOT NULL DEFAULT FALSE,
	activated_updated TIMESTAMP NOT NULL,
	KEY (created),
	KEY (updated),
	KEY (activated),
	KEY (activated_updated),
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS UsersToDomainNames (
	user_id VARCHAR(50) NOT NULL,
	domain_name VARCHAR(50) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (user_id),
	KEY (domain_name),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (user_id) REFERENCES Users(id),
	FOREIGN KEY (domain_name) REFERENCES DomainNames(domain_name),
	PRIMARY KEY (user_id, domain_name)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS UsersToPagesUrls (
	user_id VARCHAR(50) NOT NULL,
	page_url VARCHAR(230) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (user_id),
	KEY (page_url),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (user_id) REFERENCES Users(id),
	FOREIGN KEY (page_url) REFERENCES PagesUrls(page_url),
	PRIMARY KEY (user_id, page_url)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Oauth (
	user_id VARCHAR(50) NOT NULL,
	oauth_domain_name VARCHAR(50) NOT NULL,
	oauth_user_id VARCHAR(50) NOT NULL,
	oauth_access_token VARCHAR(230) NOT NULL,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (user_id),
	KEY (oauth_domain_name),
	KEY (oauth_user_id),
	KEY (oauth_access_token),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (user_id) REFERENCES Users(id),
	PRIMARY KEY (user_id, oauth_domain_name)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS UsersToWords (
	user_id VARCHAR(50) NOT NULL,
	word VARCHAR(30) NOT NULL,
	counter BIGINT NOT NULL DEFAULT 0,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	KEY (user_id),
	KEY (word),
	KEY (counter),
	KEY (created),
	KEY (updated),
	FOREIGN KEY (user_id) REFERENCES Users(id),
	PRIMARY KEY (user_id, word)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;










