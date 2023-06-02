USE [db_index]
GO

/****** Object:  Table [dbo].[Course]    Script Date: 01/05/2023 20:54:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Make this with json

CREATE TABLE [dbo].[log_action]
(
    [id] [int] IDENTITY(1,1) NOT NULL,
    [json_info] [nvarchar](max) NULL,
    [createdAt] [date] DEFAULT getdate(),
    [deletedAt] [date] DEFAULT getdate(),
    CONSTRAINT [PK_Index_Log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)
WITH
(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


