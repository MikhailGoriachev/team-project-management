drop table if exists dbo.Subscribes;
drop table if exists dbo.Publications;
drop table if exists dbo.PubTypes;
drop table if exists dbo.Subscribers;
drop table if exists dbo.Addresses;
drop table if exists dbo.Districts;
drop table if exists dbo.Streets;
drop table if exists dbo.Postmans;
drop table if exists dbo.Persons;

-- таблица личных данных
create table dbo.Persons (
	Id          int          not null primary key identity (1, 1),
	[Name]      nvarchar(60) not null,    -- Имя персоны
	Surname     nvarchar(60) not null,    -- Фамилия персоны
	Patronymic  nvarchar(60) not null,    -- Отчество персоны
);
go

-- таблица данных почтальонов
create table dbo.Postmans (
	Id          int		not null primary key identity (1, 1),
	IdPerson	int		not null,		  -- данные почтальона

	constraint FK_Postmans_Persons foreign key (IdPerson) references dbo.Persons(Id)
);
go

-- таблица названий улиц
create table dbo.Streets (
	Id          int				not null primary key identity (1, 1),
	Name		nvarchar(50)	not null,
);
go

-- таблица соотношений почтальонов к участкам (у разных участков может быть один почтальон)
create table dbo.Districts (
	Id          int		not null primary key identity (1, 1),
	IdPostman	int		not null	-- id, ключ к таблице почтальонов

	constraint FK_Disctricts_Postmans foreign key (IdPostman) references dbo.Postmans(Id)
);
go

-- таблица адресов (справочник всех адресов улица-дом с указанием участка)
create table dbo.Addresses(
	Id          int			not null primary key identity (1, 1),
	IdStreet	int			not null,    -- id, ключ к таблице списка улиц
	Building	nvarchar(5)	not null,    -- номер дома
	IdDistrict	int			not null	 -- id, ключ к таблице участков

	constraint FK_Addresses_Streets		foreign key (IdStreet) references dbo.Streets(Id),
	constraint FK_Addresses_Districts	foreign key (IdDistrict) references dbo.Districts(Id)
);
go

-- таблица данных подписчиков
create table dbo.Subscribers (
	Id          int		not null primary key identity (1, 1),
	IdPerson	int		not null,   -- id, ключ к таблице персон
	IdAddress	int		not null,	-- id, ключ таблице адресов
	SubAddress	int		not null    -- дополнительный личный адрес - номер квартиры

	constraint FK_Subscribers_Persons	foreign key (IdPerson) references dbo.Persons(Id),
	constraint FK_Subscribers_Addresses	foreign key (IdAddress) references dbo.Addresses(Id)
);
go

-- таблица типов изданий
create table dbo.PubTypes (
	Id          int				not null primary key identity (1, 1),
	[Name]		nvarchar(10)	not null
);
go

-- таблица изданий
create table dbo.Publications (
	Id          int				not null primary key identity (1, 1),
	Title		nvarchar(150)	not null,  -- название издания,
	IdPubType	int				not null,  -- id, ключ к таблицы типов изданий
	PubIndex	nvarchar(15)	not null,  -- индекс издания
	Price		int				not null   -- стоимость подписки

	constraint FK_Publications_Pubtypes	foreign key (IdPubType) references dbo.PubTypes(Id)
);
go

-- таблица подписок на издания
create table dbo.Subscribes (
	Id				int		not null primary key identity (1, 1),
	IdSubscriber	int		not null,	-- id, ключ к таблицам подписчиков
	IdPublication	int		not null,	-- id, ключ к таблице изданий
	StartDate		Date	not null,	-- дата начала подписки
	Duration		int		not null	-- длительность подписки

	constraint FK_Subscribes_Subscribers	foreign key (IdSubscriber) references dbo.Subscribers(Id),
	constraint FK_Subscribes_Publications	foreign key (IdPublication) references dbo.Publications(Id)
);
go

