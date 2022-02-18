CREATE TABLE [dbo].[Sales] (
    [Id]       INT  IDENTITY (1, 1) NOT NULL,
    [SaleDate] DATE NOT NULL,
    [Cost]     INT  NOT NULL,
    [Amount]   INT  NOT NULL,
    [IdSeller] INT  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

