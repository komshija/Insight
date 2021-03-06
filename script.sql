USE [master]
GO
/****** Object:  Database [insight]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE DATABASE [insight]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'insight', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\insight.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'insight_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\insight_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [insight] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [insight].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [insight] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [insight] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [insight] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [insight] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [insight] SET ARITHABORT OFF 
GO
ALTER DATABASE [insight] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [insight] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [insight] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [insight] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [insight] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [insight] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [insight] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [insight] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [insight] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [insight] SET  DISABLE_BROKER 
GO
ALTER DATABASE [insight] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [insight] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [insight] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [insight] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [insight] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [insight] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [insight] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [insight] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [insight] SET  MULTI_USER 
GO
ALTER DATABASE [insight] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [insight] SET DB_CHAINING OFF 
GO
ALTER DATABASE [insight] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [insight] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [insight] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [insight] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [insight] SET QUERY_STORE = OFF
GO
/****** Object:  Login [NT SERVICE\Winmgmt]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\SQLWriter]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\SQLTELEMETRY$SQLEXPRESS]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [NT SERVICE\SQLTELEMETRY$SQLEXPRESS] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT Service\MSSQL$SQLEXPRESS]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [NT Service\MSSQL$SQLEXPRESS] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [milan]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [milan] WITH PASSWORD=N'WYegJ4gDhqeCCJYjo/imzfv1hYDzKeBVTIWPtiuyecc=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
ALTER LOGIN [milan] DISABLE
GO
/****** Object:  Login [DESKTOP-R943K1D\agoso]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [DESKTOP-R943K1D\agoso] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [BUILTIN\Users]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [BUILTIN\Users] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=N'/HkDnY2nESzb09pud3xh+RyIs5Uq4na0X0SH+kkT6uc=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 19-Dec-21 15:56:53 ******/
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=N'JihiKTiek8piF7a0VMqNzApakab5RSFTIJkVm2XmJKA=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] DISABLE
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\Winmgmt]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLWriter]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT Service\MSSQL$SQLEXPRESS]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [securityadmin] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [serveradmin] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [setupadmin] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [processadmin] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [diskadmin] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [bulkadmin] ADD MEMBER [milan]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [DESKTOP-R943K1D\agoso]
GO
USE [insight]
GO
/****** Object:  Table [dbo].[events]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](20) NOT NULL,
	[type] [int] NOT NULL,
	[dateStart] [datetime] NULL,
	[dateEnd] [datetime] NULL,
	[createdBy] [int] NOT NULL,
	[lan] [float] NOT NULL,
	[lot] [float] NOT NULL,
 CONSTRAINT [PK_events] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[types]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[types](
	[id_type] [int] IDENTITY(1,1) NOT NULL,
	[name_type] [nchar](20) NOT NULL,
 CONSTRAINT [PK_types] PRIMARY KEY CLUSTERED 
(
	[id_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](40) NOT NULL,
	[pass] [nvarchar](40) NOT NULL,
	[nickname] [nchar](10) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[events] ON 

INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (5, N'procx               ', 2, CAST(N'2021-12-12T00:00:00.000' AS DateTime), CAST(N'2021-12-12T00:00:00.000' AS DateTime), 1, 43.321799999999996, 21.888721820069748)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (7, N'bb                  ', 4, CAST(N'2021-12-18T12:25:00.000' AS DateTime), CAST(N'2021-12-20T12:25:00.000' AS DateTime), 1, 43.3196, 21.8891)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (8, N'nghj                ', 5, CAST(N'2021-12-18T12:26:00.000' AS DateTime), CAST(N'2021-12-21T12:26:00.000' AS DateTime), 1, 43.3168, 21.8925)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (19, N'bnvbnvbn            ', 4, CAST(N'2021-12-19T13:02:00.000' AS DateTime), CAST(N'2021-12-19T13:02:00.000' AS DateTime), 1, 43.3138, 21.8793)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (20, N'bbbb                ', 2, CAST(N'2021-12-18T16:56:00.000' AS DateTime), CAST(N'2021-12-23T16:56:00.000' AS DateTime), 1, 43.3121, 21.9126)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (22, N'bbbbbbbbb           ', 1, CAST(N'2021-12-19T14:15:00.000' AS DateTime), CAST(N'2021-12-19T17:15:00.000' AS DateTime), 1, 43.3123, 21.894)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (23, N'test                ', 3, CAST(N'2021-12-19T15:39:00.000' AS DateTime), CAST(N'2021-12-19T18:39:00.000' AS DateTime), 1, 43.3206, 21.9006)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (24, N'bbbb                ', 2, CAST(N'2021-12-19T15:43:00.000' AS DateTime), CAST(N'2021-12-19T20:43:00.000' AS DateTime), 1, 43.3173, 21.898)
INSERT [dbo].[events] ([id], [name], [type], [dateStart], [dateEnd], [createdBy], [lan], [lot]) VALUES (25, N'sport               ', 5, CAST(N'2021-12-19T15:39:00.000' AS DateTime), CAST(N'2021-01-19T15:39:00.000' AS DateTime), 1, 43.3159, 21.8838)
SET IDENTITY_INSERT [dbo].[events] OFF
GO
SET IDENTITY_INSERT [dbo].[types] ON 

INSERT [dbo].[types] ([id_type], [name_type]) VALUES (1, N'Party')
INSERT [dbo].[types] ([id_type], [name_type]) VALUES (2, N'Roadblock')
INSERT [dbo].[types] ([id_type], [name_type]) VALUES (3, N'Musical event')
INSERT [dbo].[types] ([id_type], [name_type]) VALUES (4, N'Broken pipe')
INSERT [dbo].[types] ([id_type], [name_type]) VALUES (5, N'Sports')
SET IDENTITY_INSERT [dbo].[types] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [username], [pass], [nickname]) VALUES (1, N'milan', N'admin', N'milan     ')
INSERT [dbo].[users] ([id], [username], [pass], [nickname]) VALUES (2, N'marko', N'admin', N'marko     ')
INSERT [dbo].[users] ([id], [username], [pass], [nickname]) VALUES (3, N'aleksandar', N'admin', N'aca       ')
INSERT [dbo].[users] ([id], [username], [pass], [nickname]) VALUES (4, N'srecko', N'admin', N'src       ')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_types] FOREIGN KEY([type])
REFERENCES [dbo].[types] ([id_type])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_types]
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_users] FOREIGN KEY([createdBy])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_users]
GO
/****** Object:  StoredProcedure [dbo].[sp_getEvents]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[sp_getEvents]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from events WHERE 
	dateStart < GETDATE() AND dateEnd > GETDATE();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getTypes]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getTypes]
	
AS
BEGIN

   SELECT [name_type] FROM [insight].[dbo].[types]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_event]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insert_event]
	@name nvarchar(40),
	@type int,
	@datestart datetime,
	@dateend datetime,
	@user int,
	@lan float,
	@lot float
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO events(name,type, dateStart, dateEnd, createdBy, lan, lot) 
		  VALUES(@name, @type,@datestart, @dateend,@user, @lan, @lot );


END
GO
/****** Object:  StoredProcedure [dbo].[sp_login]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_login]
	@username nvarchar(30),
	@password nvarchar(30)
AS
BEGIN

	SELECT id FROM [insight].[dbo].[users] WHERE username = @username AND pass = @password;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_register]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_register]
	@username nvarchar(40), 
	@password nvarchar(40),
	@nickname nvarchar(40)
AS
BEGIN
	
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT id FROM users WHERE username = @username) 
	BEGIN
		INSERT INTO users(username,pass,nickname) 
		  VALUES(@username, @password, @nickname )
		  SELECT 1;
	END
	ELSE
	BEGIN
		SELECT 0;
	END
    
END
GO
/****** Object:  StoredProcedure [dbo].[sp_removeEvent]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_removeEvent]
	@id int
AS
BEGIN
	 DELETE FROM events WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_updateEvent]    Script Date: 19-Dec-21 15:56:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_updateEvent]
	@id int,
	@name nvarchar(40),
	@type int,
	@dateStart datetime,
	@dateEnd datetime
AS
BEGIN

	SET NOCOUNT ON;

    UPDATE events
	SET name = @name, type = @type, dateStart = @dateStart, dateEnd = @dateEnd
	WHERE id = @id;
END
GO
USE [master]
GO
ALTER DATABASE [insight] SET  READ_WRITE 
GO
