USE [hspmNIR_homol]
GO
/****** Object:  Table [dbo].[Paciente]    Script Date: 03/01/2021 11:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Paciente](
	[prontuario] [int] NOT NULL,
	[nome] [varchar](max) NOT NULL,
	[nascimento] [varchar](10) NULL,
	[sexo] [char](1) NULL,
	[vinculo] [varchar](max) NULL,
 CONSTRAINT [PK_Paciente] PRIMARY KEY CLUSTERED 
(
	[prontuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[internacao]    Script Date: 03/01/2021 11:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[internacao](
	[cod_internacao] [int] IDENTITY(1,1) NOT NULL,
	[prontuario_pac] [int] NULL,
	[quarto] [int] NULL,
	[dt_internacao] [varchar](10) NULL,
	[especialidade] [varchar](max) NULL,
	[medico] [varchar](100) NULL,
	[tempo] [varchar](50) NULL,
	[cid] [varchar](50) NULL,
	[descricao_cid] [varchar](max) NULL,
	[unidade_funcional] [varchar](100) NULL,
	[data_carga] [datetime] NULL,
	[usuario_carga] [varchar](50) NULL,
 CONSTRAINT [PK_internacao] PRIMARY KEY CLUSTERED 
(
	[cod_internacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Anotacoes]    Script Date: 03/01/2021 11:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Anotacoes](
	[cod_anotacao] [int] IDENTITY(1,1) NOT NULL,
	[data_anotacao] [datetime] NULL,
	[usuario_anota] [varchar](50) NULL,
	[cod_internacao] [int] NULL,
	[diagnostico] [varchar](max) NULL,
	[detalhamento] [varchar](max) NULL,
	[aguarda] [varchar](100) NULL,
 CONSTRAINT [PK_Anotacoes] PRIMARY KEY CLUSTERED 
(
	[cod_anotacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_relatorio_detalhado]    Script Date: 03/01/2021 11:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_relatorio_detalhado]
AS
SELECT     dbo.Paciente.prontuario, dbo.Paciente.nome, dbo.Paciente.nascimento, dbo.Paciente.sexo, dbo.Paciente.vinculo, dbo.internacao.cod_internacao, dbo.internacao.quarto, 
                      dbo.internacao.unidade_funcional, dbo.internacao.dt_internacao, dbo.internacao.tempo, dbo.internacao.cid, dbo.internacao.descricao_cid, dbo.internacao.especialidade, dbo.internacao.medico, 
                      dbo.internacao.data_carga, stuff
                          ((SELECT     '; ' + T .diagnostico
                              FROM         [dbo].[Anotacoes] AS T
                              WHERE     T .cod_internacao = dbo.internacao.cod_internacao FOR xml path('')), 1, 2, '') diagnostico, stuff
                          ((SELECT     '; ' + T .detalhamento
                              FROM         [dbo].[Anotacoes] AS T
                              WHERE     T .cod_internacao = dbo.internacao.cod_internacao FOR xml path('')), 1, 2, '') detalhamento, stuff
                          ((SELECT     '; ' + T .aguarda 
                              FROM         [dbo].[Anotacoes] AS T
                              WHERE     T .cod_internacao = dbo.internacao.cod_internacao FOR xml path('')), 1, 2, '') aguarda
FROM         dbo.Paciente INNER JOIN
                      dbo.internacao ON dbo.Paciente.prontuario = dbo.internacao.prontuario_pac
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[22] 2[31] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_relatorio_detalhado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_relatorio_detalhado'
GO
/****** Object:  ForeignKey [FK_Anotacoes_internacao]    Script Date: 03/01/2021 11:01:02 ******/
ALTER TABLE [dbo].[Anotacoes]  WITH CHECK ADD  CONSTRAINT [FK_Anotacoes_internacao] FOREIGN KEY([cod_internacao])
REFERENCES [dbo].[internacao] ([cod_internacao])
GO
ALTER TABLE [dbo].[Anotacoes] CHECK CONSTRAINT [FK_Anotacoes_internacao]
GO
/****** Object:  ForeignKey [FK_internacao_Paciente]    Script Date: 03/01/2021 11:01:02 ******/
ALTER TABLE [dbo].[internacao]  WITH CHECK ADD  CONSTRAINT [FK_internacao_Paciente] FOREIGN KEY([prontuario_pac])
REFERENCES [dbo].[Paciente] ([prontuario])
GO
ALTER TABLE [dbo].[internacao] CHECK CONSTRAINT [FK_internacao_Paciente]
GO
