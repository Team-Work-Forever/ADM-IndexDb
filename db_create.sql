-- Tabela Curso
USE [db_index]
GO

/****** Object:  Table [dbo].[Course]    Script Date: 27/04/2023 14:24:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Course]
(
	[code] [char](4) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](100) NULL,
	CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [db_index]
GO


-- Tabela Disciplina
/****** Object:  Table [dbo].[Class]    Script Date: 27/04/2023 14:26:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Class]
(
	[code] [char](7) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](100) NULL,
	[code_course] [char](4) NOT NULL,
	CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_Class] FOREIGN KEY([code_course])
REFERENCES [dbo].[Course] ([code])
GO

ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_Class]
GO


-- Tabela Tipo Indicador
USE [db_index]
GO

/****** Object:  Table [dbo].[IndexType]    Script Date: 27/04/2023 14:26:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IndexType]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	CONSTRAINT [PK_IndexType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


-- Tabela Indicador
USE [db_index]
GO

/****** Object:  Table [dbo].[Class_IndexType]    Script Date: 27/04/2023 14:26:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Class_IndexType]
(
	[year] [char](5) NOT NULL,
	[id_index_type] [int] NOT NULL,
	[code_class] [char](7) NOT NULL,
	[value] [decimal](18, 2) NOT NULL,
	CONSTRAINT [PK_Class_IndexType] PRIMARY KEY CLUSTERED 
(
	[year] ASC,
	[id_index_type] ASC,
	[code_class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Class_IndexType]  WITH CHECK ADD  CONSTRAINT [FK_Class_IndexType_Class] FOREIGN KEY([code_class])
REFERENCES [dbo].[Class] ([code])
GO

ALTER TABLE [dbo].[Class_IndexType] CHECK CONSTRAINT [FK_Class_IndexType_Class]
GO

ALTER TABLE [dbo].[Class_IndexType]  WITH CHECK ADD  CONSTRAINT [FK_Class_IndexType_IndexType] FOREIGN KEY([id_index_type])
REFERENCES [dbo].[IndexType] ([id])
GO

ALTER TABLE [dbo].[Class_IndexType] CHECK CONSTRAINT [FK_Class_IndexType_IndexType]
GO