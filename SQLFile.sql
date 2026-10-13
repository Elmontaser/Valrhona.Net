USE [ValrhonaDB]
GO
/****** Object:  UserDefinedTableType [RecipeIngredientType]    Script Date: 11/10/2026 12:25:16 م ******/
CREATE TYPE [RecipeIngredientType] AS TABLE(
	[IngredientItemId] [int] NOT NULL,
	[Quantity] [decimal](18, 4) NOT NULL,
	[UnitId] [int] NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[WastePercent] [decimal](5, 2) NOT NULL,
	[Notes] [nvarchar](500) NULL
)
GO
/****** Object:  Table [Categories]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[ParentCategoryId] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ItemCosts]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ItemCosts](
	[ItemCostId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NOT NULL,
	[CostPerUnit] [decimal](18, 4) NOT NULL,
	[UnitId] [int] NOT NULL,
	[Currency] [nvarchar](10) NOT NULL,
	[CostDate] [date] NOT NULL,
	[SourceRecipeId] [int] NULL,
	[Notes] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemCostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ItemPrices]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ItemPrices](
	[ItemPriceId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NOT NULL,
	[Price] [decimal](18, 4) NOT NULL,
	[Currency] [nvarchar](10) NOT NULL,
	[EffectiveDate] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UnitId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemPriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Items]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Items](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[ItemCode] [nvarchar](50) NOT NULL,
	[ItemName] [nvarchar](200) NOT NULL,
	[ItemTypeId] [tinyint] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[UnitId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedAt] [datetime2](0) NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Items_ItemCode] UNIQUE NONCLUSTERED 
(
	[ItemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ItemTypes]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ItemTypes](
	[ItemTypeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ItemTypes] PRIMARY KEY CLUSTERED 
(
	[ItemTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ItemTypes_NameAr] UNIQUE NONCLUSTERED 
(
	[TypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecipeDetails]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecipeDetails](
	[RecipeDetailId] [bigint] IDENTITY(1,1) NOT NULL,
	[RecipeId] [int] NOT NULL,
	[IngredientItemId] [int] NOT NULL,
	[Quantity] [decimal](18, 4) NOT NULL,
	[UnitId] [int] NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[WastePercent] [decimal](5, 2) NOT NULL,
	[Notes] [nvarchar](500) NULL,
 CONSTRAINT [PK_RecipeDetails] PRIMARY KEY CLUSTERED 
(
	[RecipeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Recipes]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Recipes](
	[RecipeId] [int] IDENTITY(1,1) NOT NULL,
	[RecipeCode] [nvarchar](50) NOT NULL,
	[RecipeName] [nvarchar](200) NOT NULL,
	[OutputItemId] [int] NOT NULL,
	[OutputQuantity] [decimal](18, 4) NOT NULL,
	[OutputUnitId] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Notes] [nvarchar](1000) NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedAt] [datetime2](0) NULL,
	[ActualOutputQuantity] [decimal](18, 4) NULL,
	[BatchInputQuantity] [decimal](18, 4) NULL,
 CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED 
(
	[RecipeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Recipes_RecipeCode] UNIQUE NONCLUSTERED 
(
	[RecipeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [UnitConversions]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UnitConversions](
	[UnitConversionId] [int] IDENTITY(1,1) NOT NULL,
	[FromUnitId] [int] NOT NULL,
	[ToUnitId] [int] NOT NULL,
	[ConversionFactor] [decimal](18, 8) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UnitConversionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_UnitConversions] UNIQUE NONCLUSTERED 
(
	[FromUnitId] ASC,
	[ToUnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Units]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Units](
	[UnitId] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](50) NOT NULL,
	[Symbol] [nvarchar](10) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Units] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Units_NameAr] UNIQUE NONCLUSTERED 
(
	[UnitName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Categories] ADD  CONSTRAINT [DF_Categories_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Categories] ADD  CONSTRAINT [DF_Categories_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [ItemCosts] ADD  CONSTRAINT [DF_ItemCosts_Currency]  DEFAULT (N'LYD') FOR [Currency]
GO
ALTER TABLE [ItemCosts] ADD  CONSTRAINT [DF_ItemCosts_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [ItemPrices] ADD  DEFAULT (N'LYD') FOR [Currency]
GO
ALTER TABLE [ItemPrices] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [ItemPrices] ADD  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [Items] ADD  CONSTRAINT [DF_Items_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Items] ADD  CONSTRAINT [DF_Items_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [ItemTypes] ADD  CONSTRAINT [DF_ItemTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [RecipeDetails] ADD  CONSTRAINT [DF_RecipeDetails_SequenceNo]  DEFAULT ((1)) FOR [SequenceNo]
GO
ALTER TABLE [RecipeDetails] ADD  CONSTRAINT [DF_RecipeDetails_WastePercent]  DEFAULT ((0)) FOR [WastePercent]
GO
ALTER TABLE [Recipes] ADD  CONSTRAINT [DF_Recipes_VersionNo]  DEFAULT ((1)) FOR [VersionNo]
GO
ALTER TABLE [Recipes] ADD  CONSTRAINT [DF_Recipes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Recipes] ADD  CONSTRAINT [DF_Recipes_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [UnitConversions] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [UnitConversions] ADD  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [Units] ADD  CONSTRAINT [DF_Units_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Parent] FOREIGN KEY([ParentCategoryId])
REFERENCES [Categories] ([CategoryId])
GO
ALTER TABLE [Categories] CHECK CONSTRAINT [FK_Categories_Parent]
GO
ALTER TABLE [ItemCosts]  WITH CHECK ADD  CONSTRAINT [FK_ItemCosts_Items] FOREIGN KEY([ItemId])
REFERENCES [Items] ([ItemId])
GO
ALTER TABLE [ItemCosts] CHECK CONSTRAINT [FK_ItemCosts_Items]
GO
ALTER TABLE [ItemCosts]  WITH CHECK ADD  CONSTRAINT [FK_ItemCosts_Recipes] FOREIGN KEY([SourceRecipeId])
REFERENCES [Recipes] ([RecipeId])
GO
ALTER TABLE [ItemCosts] CHECK CONSTRAINT [FK_ItemCosts_Recipes]
GO
ALTER TABLE [ItemCosts]  WITH CHECK ADD  CONSTRAINT [FK_ItemCosts_Units] FOREIGN KEY([UnitId])
REFERENCES [Units] ([UnitId])
GO
ALTER TABLE [ItemCosts] CHECK CONSTRAINT [FK_ItemCosts_Units]
GO
ALTER TABLE [ItemPrices]  WITH CHECK ADD  CONSTRAINT [FK_ItemPrices_Items] FOREIGN KEY([ItemId])
REFERENCES [Items] ([ItemId])
GO
ALTER TABLE [ItemPrices] CHECK CONSTRAINT [FK_ItemPrices_Items]
GO
ALTER TABLE [Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Category] FOREIGN KEY([CategoryId])
REFERENCES [Categories] ([CategoryId])
GO
ALTER TABLE [Items] CHECK CONSTRAINT [FK_Items_Category]
GO
ALTER TABLE [Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_ItemType] FOREIGN KEY([ItemTypeId])
REFERENCES [ItemTypes] ([ItemTypeId])
GO
ALTER TABLE [Items] CHECK CONSTRAINT [FK_Items_ItemType]
GO
ALTER TABLE [Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Unit] FOREIGN KEY([UnitId])
REFERENCES [Units] ([UnitId])
GO
ALTER TABLE [Items] CHECK CONSTRAINT [FK_Items_Unit]
GO
ALTER TABLE [RecipeDetails]  WITH CHECK ADD  CONSTRAINT [FK_RecipeDetails_Item] FOREIGN KEY([IngredientItemId])
REFERENCES [Items] ([ItemId])
GO
ALTER TABLE [RecipeDetails] CHECK CONSTRAINT [FK_RecipeDetails_Item]
GO
ALTER TABLE [RecipeDetails]  WITH CHECK ADD  CONSTRAINT [FK_RecipeDetails_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [Recipes] ([RecipeId])
GO
ALTER TABLE [RecipeDetails] CHECK CONSTRAINT [FK_RecipeDetails_Recipe]
GO
ALTER TABLE [RecipeDetails]  WITH CHECK ADD  CONSTRAINT [FK_RecipeDetails_Unit] FOREIGN KEY([UnitId])
REFERENCES [Units] ([UnitId])
GO
ALTER TABLE [RecipeDetails] CHECK CONSTRAINT [FK_RecipeDetails_Unit]
GO
ALTER TABLE [Recipes]  WITH CHECK ADD  CONSTRAINT [FK_Recipes_OutputItem] FOREIGN KEY([OutputItemId])
REFERENCES [Items] ([ItemId])
GO
ALTER TABLE [Recipes] CHECK CONSTRAINT [FK_Recipes_OutputItem]
GO
ALTER TABLE [Recipes]  WITH CHECK ADD  CONSTRAINT [FK_Recipes_OutputUnit] FOREIGN KEY([OutputUnitId])
REFERENCES [Units] ([UnitId])
GO
ALTER TABLE [Recipes] CHECK CONSTRAINT [FK_Recipes_OutputUnit]
GO
ALTER TABLE [UnitConversions]  WITH CHECK ADD  CONSTRAINT [FK_UnitConversions_FromUnit] FOREIGN KEY([FromUnitId])
REFERENCES [Units] ([UnitId])
GO
ALTER TABLE [UnitConversions] CHECK CONSTRAINT [FK_UnitConversions_FromUnit]
GO
ALTER TABLE [UnitConversions]  WITH CHECK ADD  CONSTRAINT [FK_UnitConversions_ToUnit] FOREIGN KEY([ToUnitId])
REFERENCES [Units] ([UnitId])
GO
ALTER TABLE [UnitConversions] CHECK CONSTRAINT [FK_UnitConversions_ToUnit]
GO
ALTER TABLE [ItemCosts]  WITH CHECK ADD  CONSTRAINT [CK_ItemCosts_Cost] CHECK  (([CostPerUnit]>=(0)))
GO
ALTER TABLE [ItemCosts] CHECK CONSTRAINT [CK_ItemCosts_Cost]
GO
ALTER TABLE [ItemPrices]  WITH CHECK ADD  CONSTRAINT [CK_ItemPrices_Price] CHECK  (([Price]>=(0)))
GO
ALTER TABLE [ItemPrices] CHECK CONSTRAINT [CK_ItemPrices_Price]
GO
ALTER TABLE [RecipeDetails]  WITH CHECK ADD  CONSTRAINT [CK_RecipeDetails_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [RecipeDetails] CHECK CONSTRAINT [CK_RecipeDetails_Quantity]
GO
ALTER TABLE [RecipeDetails]  WITH CHECK ADD  CONSTRAINT [CK_RecipeDetails_SequenceNo] CHECK  (([SequenceNo]>(0)))
GO
ALTER TABLE [RecipeDetails] CHECK CONSTRAINT [CK_RecipeDetails_SequenceNo]
GO
ALTER TABLE [RecipeDetails]  WITH CHECK ADD  CONSTRAINT [CK_RecipeDetails_WastePercent] CHECK  (([WastePercent]>=(0) AND [WastePercent]<=(100)))
GO
ALTER TABLE [RecipeDetails] CHECK CONSTRAINT [CK_RecipeDetails_WastePercent]
GO
ALTER TABLE [Recipes]  WITH CHECK ADD  CONSTRAINT [CK_Recipes_OutputQuantity] CHECK  (([OutputQuantity]>(0)))
GO
ALTER TABLE [Recipes] CHECK CONSTRAINT [CK_Recipes_OutputQuantity]
GO
ALTER TABLE [Recipes]  WITH CHECK ADD  CONSTRAINT [CK_Recipes_VersionNo] CHECK  (([VersionNo]>(0)))
GO
ALTER TABLE [Recipes] CHECK CONSTRAINT [CK_Recipes_VersionNo]
GO
ALTER TABLE [UnitConversions]  WITH CHECK ADD  CONSTRAINT [CK_UnitConversions_DifferentUnits] CHECK  (([FromUnitId]<>[ToUnitId]))
GO
ALTER TABLE [UnitConversions] CHECK CONSTRAINT [CK_UnitConversions_DifferentUnits]
GO
ALTER TABLE [UnitConversions]  WITH CHECK ADD  CONSTRAINT [CK_UnitConversions_Factor] CHECK  (([ConversionFactor]>(0)))
GO
ALTER TABLE [UnitConversions] CHECK CONSTRAINT [CK_UnitConversions_Factor]
GO
/****** Object:  StoredProcedure [Category_Delete]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Category_Delete]
    @CategoryId INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Categories
            WHERE CategoryId = @CategoryId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'التصنيف غير موجود' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Categories
            WHERE ParentCategoryId = @CategoryId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'لا يمكن إيقاف التصنيف لأنه يحتوي على تصنيفات فرعية فعالة'
                AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE CategoryId = @CategoryId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -3 AS ResultCode,
                N'لا يمكن إيقاف التصنيف لأنه مستخدم من أصناف فعالة'
                AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.Categories
        SET IsActive = 0
        WHERE CategoryId = @CategoryId;

        SELECT
            1 AS ResultCode,
            N'تم إيقاف التصنيف بنجاح' AS ResultMessage,
            @CategoryId AS CategoryId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء إيقاف التصنيف' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object: StoredProcedure [UnitConversion_GetAll] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UnitConversion_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        uc.UnitConversionId,
        uc.FromUnitId,
        fromUnit.UnitName AS FromUnitName,
        fromUnit.Symbol AS FromUnitSymbol,
        uc.ToUnitId,
        toUnit.UnitName AS ToUnitName,
        toUnit.Symbol AS ToUnitSymbol,
        uc.ConversionFactor,
        uc.IsActive,
        uc.Notes,
        uc.CreatedAt
    FROM dbo.UnitConversions uc
    INNER JOIN dbo.Units fromUnit ON fromUnit.UnitId = uc.FromUnitId
    INNER JOIN dbo.Units toUnit ON toUnit.UnitId = uc.ToUnitId
    ORDER BY fromUnit.UnitName, toUnit.UnitName;
END
GO
/****** Object: StoredProcedure [UnitConversion_GetById] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UnitConversion_GetById]
    @UnitConversionId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        uc.UnitConversionId,
        uc.FromUnitId,
        fromUnit.UnitName AS FromUnitName,
        fromUnit.Symbol AS FromUnitSymbol,
        uc.ToUnitId,
        toUnit.UnitName AS ToUnitName,
        toUnit.Symbol AS ToUnitSymbol,
        uc.ConversionFactor,
        uc.IsActive,
        uc.Notes,
        uc.CreatedAt
    FROM dbo.UnitConversions uc
    INNER JOIN dbo.Units fromUnit ON fromUnit.UnitId = uc.FromUnitId
    INNER JOIN dbo.Units toUnit ON toUnit.UnitId = uc.ToUnitId
    WHERE uc.UnitConversionId = @UnitConversionId;
END
GO
/****** Object: StoredProcedure [UnitConversion_Insert] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UnitConversion_Insert]
    @FromUnitId INT,
    @ToUnitId INT,
    @ConversionFactor DECIMAL(18,8),
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        IF @FromUnitId = @ToUnitId
        BEGIN
            SELECT -1 AS ResultCode,
                   N'يجب أن تختلف وحدة المصدر عن وحدة الهدف.' AS ResultMessage;
            RETURN;
        END;

        IF @ConversionFactor <= 0
        BEGIN
            SELECT -2 AS ResultCode,
                   N'معامل التحويل يجب أن يكون أكبر من صفر.' AS ResultMessage;
            RETURN;
        END;

        IF (SELECT COUNT(*)
            FROM dbo.Units
            WHERE UnitId IN (@FromUnitId, @ToUnitId)
              AND IsActive = 1) <> 2
        BEGIN
            SELECT -3 AS ResultCode,
                   N'يجب اختيار وحدتين موجودتين ونشطتين.' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.UnitConversions
            WHERE FromUnitId = @FromUnitId
              AND ToUnitId = @ToUnitId
        )
        BEGIN
            SELECT -4 AS ResultCode,
                   N'قاعدة التحويل بين هاتين الوحدتين موجودة مسبقاً.' AS ResultMessage;
            RETURN;
        END;

        INSERT INTO dbo.UnitConversions
            (FromUnitId, ToUnitId, ConversionFactor, Notes)
        VALUES
            (@FromUnitId, @ToUnitId, @ConversionFactor,
             NULLIF(LTRIM(RTRIM(@Notes)), N''));

        SELECT 1 AS ResultCode,
               N'تمت إضافة قاعدة التحويل بنجاح.' AS ResultMessage,
               CONVERT(INT, SCOPE_IDENTITY()) AS UnitConversionId;
    END TRY
    BEGIN CATCH
        SELECT -500 AS ResultCode,
               N'حدث خطأ أثناء إضافة قاعدة التحويل.' AS ResultMessage,
               ERROR_NUMBER() AS ErrorNumber,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO
/****** Object: StoredProcedure [UnitConversion_Update] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UnitConversion_Update]
    @UnitConversionId INT,
    @FromUnitId INT,
    @ToUnitId INT,
    @ConversionFactor DECIMAL(18,8),
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.UnitConversions
            WHERE UnitConversionId = @UnitConversionId
        )
        BEGIN
            SELECT -1 AS ResultCode,
                   N'قاعدة التحويل غير موجودة.' AS ResultMessage;
            RETURN;
        END;

        IF @FromUnitId = @ToUnitId
        BEGIN
            SELECT -2 AS ResultCode,
                   N'يجب أن تختلف وحدة المصدر عن وحدة الهدف.' AS ResultMessage;
            RETURN;
        END;

        IF @ConversionFactor <= 0
        BEGIN
            SELECT -3 AS ResultCode,
                   N'معامل التحويل يجب أن يكون أكبر من صفر.' AS ResultMessage;
            RETURN;
        END;

        IF (SELECT COUNT(*)
            FROM dbo.Units
            WHERE UnitId IN (@FromUnitId, @ToUnitId)) <> 2
        BEGIN
            SELECT -4 AS ResultCode,
                   N'إحدى الوحدتين غير موجودة.' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.UnitConversions
            WHERE FromUnitId = @FromUnitId
              AND ToUnitId = @ToUnitId
              AND UnitConversionId <> @UnitConversionId
        )
        BEGIN
            SELECT -5 AS ResultCode,
                   N'قاعدة التحويل بين هاتين الوحدتين موجودة مسبقاً.' AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.UnitConversions
        SET FromUnitId = @FromUnitId,
            ToUnitId = @ToUnitId,
            ConversionFactor = @ConversionFactor,
            Notes = NULLIF(LTRIM(RTRIM(@Notes)), N'')
        WHERE UnitConversionId = @UnitConversionId;

        SELECT 1 AS ResultCode,
               N'تم تعديل قاعدة التحويل بنجاح.' AS ResultMessage,
               @UnitConversionId AS UnitConversionId;
    END TRY
    BEGIN CATCH
        SELECT -500 AS ResultCode,
               N'حدث خطأ أثناء تعديل قاعدة التحويل.' AS ResultMessage,
               ERROR_NUMBER() AS ErrorNumber,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO
/****** Object: StoredProcedure [UnitConversion_SetActive] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UnitConversion_SetActive]
    @UnitConversionId INT,
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.UnitConversions
            WHERE UnitConversionId = @UnitConversionId
        )
        BEGIN
            SELECT -1 AS ResultCode,
                   N'قاعدة التحويل غير موجودة.' AS ResultMessage;
            RETURN;
        END;

        IF @IsActive = 1 AND EXISTS
        (
            SELECT 1
            FROM dbo.UnitConversions uc
            INNER JOIN dbo.Units fromUnit ON fromUnit.UnitId = uc.FromUnitId
            INNER JOIN dbo.Units toUnit ON toUnit.UnitId = uc.ToUnitId
            WHERE uc.UnitConversionId = @UnitConversionId
              AND (fromUnit.IsActive = 0 OR toUnit.IsActive = 0)
        )
        BEGIN
            SELECT -2 AS ResultCode,
                   N'لا يمكن تفعيل التحويل لأن إحدى الوحدتين غير نشطة.' AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.UnitConversions
        SET IsActive = @IsActive
        WHERE UnitConversionId = @UnitConversionId;

        SELECT 1 AS ResultCode,
               N'تم تحديث حالة قاعدة التحويل.' AS ResultMessage,
               @UnitConversionId AS UnitConversionId;
    END TRY
    BEGIN CATCH
        SELECT -500 AS ResultCode,
               N'حدث خطأ أثناء تغيير حالة قاعدة التحويل.' AS ResultMessage,
               ERROR_NUMBER() AS ErrorNumber,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO
/****** Object:  StoredProcedure [Category_GetAll]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   CATEGORIES
   ========================================================= */

CREATE PROCEDURE [Category_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        CategoryId,
        CategoryName,
        ParentCategoryId,
        IsActive,
        CreatedAt
    FROM dbo.Categories
    ORDER BY CategoryName;
END
GO
/****** Object:  StoredProcedure [Category_GetById]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Category_GetById]
    @CategoryId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        CategoryId,
        CategoryName,
        ParentCategoryId,
        IsActive,
        CreatedAt
    FROM dbo.Categories
    WHERE CategoryId = @CategoryId;
END
GO
/****** Object:  StoredProcedure [Category_Insert]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Category_Insert]
    @CategoryName NVARCHAR(100),
    @ParentCategoryId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @CategoryName = LTRIM(RTRIM(@CategoryName));

        IF NULLIF(@CategoryName, N'') IS NULL
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'اسم التصنيف العربي مطلوب' AS ResultMessage;
            RETURN;
        END;

        IF @ParentCategoryId IS NOT NULL
           AND NOT EXISTS
           (
               SELECT 1
               FROM dbo.Categories
               WHERE CategoryId = @ParentCategoryId
                 AND IsActive = 1
           )
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'التصنيف الأب غير موجود أو غير فعال' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Categories
            WHERE CategoryName = @CategoryName
        )
        BEGIN
            SELECT
                -3 AS ResultCode,
                N'اسم التصنيف العربي موجود مسبقاً' AS ResultMessage;
            RETURN;
        END;

        INSERT INTO dbo.Categories
        (
            CategoryName,
            ParentCategoryId
        )
        VALUES
        (
            @CategoryName,
            @ParentCategoryId
        );

        SELECT
            1 AS ResultCode,
            N'تمت إضافة التصنيف بنجاح' AS ResultMessage,
            CAST(SCOPE_IDENTITY() AS INT) AS CategoryId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء إضافة التصنيف' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [Category_Update]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Category_Update]
    @CategoryId INT,
    @CategoryName NVARCHAR(100),
    @ParentCategoryId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @CategoryName = LTRIM(RTRIM(@CategoryName));

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Categories
            WHERE CategoryId = @CategoryId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'التصنيف غير موجود' AS ResultMessage;
            RETURN;
        END;

        IF NULLIF(@CategoryName, N'') IS NULL
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'اسم التصنيف العربي مطلوب' AS ResultMessage;
            RETURN;
        END;

        IF @ParentCategoryId = @CategoryId
        BEGIN
            SELECT
                -3 AS ResultCode,
                N'لا يمكن أن يكون التصنيف أباً لنفسه' AS ResultMessage;
            RETURN;
        END;

        IF @ParentCategoryId IS NOT NULL
           AND NOT EXISTS
           (
               SELECT 1
               FROM dbo.Categories
               WHERE CategoryId = @ParentCategoryId
                 AND IsActive = 1
           )
        BEGIN
            SELECT
                -4 AS ResultCode,
                N'التصنيف الأب غير موجود أو غير فعال' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Categories
            WHERE CategoryName = @CategoryName
              AND CategoryId <> @CategoryId
        )
        BEGIN
            SELECT
                -5 AS ResultCode,
                N'اسم التصنيف موجود مسبقاً' AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.Categories
        SET
            CategoryName = @CategoryName,
            ParentCategoryId = @ParentCategoryId
        WHERE CategoryId = @CategoryId;

        SELECT
            1 AS ResultCode,
            N'تم تعديل التصنيف بنجاح' AS ResultMessage,
            @CategoryId AS CategoryId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء تعديل التصنيف' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [Item_Delete]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Item_Delete]
    @ItemId INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemId = @ItemId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'الصنف غير موجود' AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.Items
        SET
            IsActive = 0,
            UpdatedAt = SYSDATETIME()
        WHERE ItemId = @ItemId;

        SELECT
            1 AS ResultCode,
            N'تم إيقاف الصنف بنجاح' AS ResultMessage,
            @ItemId AS ItemId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء إيقاف الصنف' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [Item_GetAll]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   ITEMS
   ========================================================= */

CREATE PROCEDURE [Item_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        i.ItemId,
        i.ItemCode,
        i.ItemName,

        i.ItemTypeId,
        t.TypeName AS ItemTypeName,

        i.CategoryId,
        c.CategoryName,

        i.UnitId,
        u.UnitName,
        u.Symbol,

        i.IsActive,
        i.Notes,
        i.CreatedAt,
        i.UpdatedAt

    FROM dbo.Items i

    INNER JOIN dbo.ItemTypes t
        ON i.ItemTypeId = t.ItemTypeId

    INNER JOIN dbo.Categories c
        ON i.CategoryId = c.CategoryId

    INNER JOIN dbo.Units u
        ON i.UnitId = u.UnitId

    ORDER BY i.ItemName;
END
GO
/****** Object:  StoredProcedure [Item_GetById]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Item_GetById]
    @ItemId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        i.ItemId,
        i.ItemCode,
        i.ItemName,

        i.ItemTypeId,
        t.TypeName AS ItemTypeName,

        i.CategoryId,
        c.CategoryName,

        i.UnitId,
        u.UnitName,
        u.Symbol,

        i.IsActive,
        i.Notes,
        i.CreatedAt,
        i.UpdatedAt

    FROM dbo.Items i

    INNER JOIN dbo.ItemTypes t
        ON i.ItemTypeId = t.ItemTypeId

    INNER JOIN dbo.Categories c
        ON i.CategoryId = c.CategoryId

    INNER JOIN dbo.Units u
        ON i.UnitId = u.UnitId

    WHERE i.ItemId = @ItemId AND i.IsActive=1
END
GO
/****** Object:  StoredProcedure [Item_Insert]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Item_Insert]
    @ItemCode NVARCHAR(50),
    @ItemName NVARCHAR(200),
    @ItemTypeId TINYINT,
    @CategoryId INT,
    @UnitId INT,
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @ItemCode = LTRIM(RTRIM(@ItemCode));
        SET @ItemName= LTRIM(RTRIM(@ItemName));

        IF NULLIF(@ItemCode, N'') IS NULL
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'كود الصنف مطلوب' AS ResultMessage;
            RETURN;
        END;

        IF NULLIF(@ItemName, N'') IS NULL
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'اسم الصنف العربي مطلوب' AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.ItemTypes
            WHERE ItemTypeId = @ItemTypeId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -3 AS ResultCode,
                N'نوع الصنف غير موجود أو غير فعال' AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Categories
            WHERE CategoryId = @CategoryId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -4 AS ResultCode,
                N'التصنيف غير موجود أو غير فعال' AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitId = @UnitId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -5 AS ResultCode,
                N'وحدة القياس غير موجودة أو غير فعالة' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemCode = @ItemCode
        )
        BEGIN
            SELECT
                -6 AS ResultCode,
                N'كود الصنف موجود مسبقاً' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemName = @ItemName
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -7 AS ResultCode,
                N'اسم الصنف موجود مسبقاً' AS ResultMessage;
            RETURN;
        END;

        INSERT INTO dbo.Items
        (
            ItemCode,
            ItemName,
            ItemTypeId,
            CategoryId,
            UnitId,
            Notes
        )
        VALUES
        (
            @ItemCode,
            @ItemName,
            @ItemTypeId,
            @CategoryId,
            @UnitId,
            NULLIF(LTRIM(RTRIM(@Notes)), N'')
        );

        SELECT
            1 AS ResultCode,
            N'تمت إضافة الصنف بنجاح' AS ResultMessage,
            CAST(SCOPE_IDENTITY() AS INT) AS ItemId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء إضافة الصنف' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [Item_Search]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Item_Search]
    @Search NVARCHAR(200) = NULL,
    @ItemTypeId TINYINT = NULL,
    @CategoryId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

    SELECT
        i.ItemId,
        i.ItemCode,
        i.ItemName,

        i.ItemTypeId,
        t.TypeName AS ItemTypeName,

        i.CategoryId,
        c.CategoryName,

        i.UnitId,
        u.UnitName,
        u.Symbol,

        i.IsActive

    FROM dbo.Items i

    INNER JOIN dbo.ItemTypes t
        ON i.ItemTypeId = t.ItemTypeId

    INNER JOIN dbo.Categories c
        ON i.CategoryId = c.CategoryId

    INNER JOIN dbo.Units u
        ON i.UnitId = u.UnitId

    WHERE
        i.IsActive = 1

        AND
        (
            @Search IS NULL
            OR i.ItemCode LIKE N'%' + @Search + N'%'
            OR i.ItemName LIKE N'%' + @Search + N'%'
        )

        AND
        (
            @ItemTypeId IS NULL
            OR i.ItemTypeId = @ItemTypeId
        )

        AND
        (
            @CategoryId IS NULL
            OR i.CategoryId = @CategoryId
        )

    ORDER BY i.ItemName;
END
GO
/****** Object:  StoredProcedure [Item_Update]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Item_Update]
    @ItemId INT,
    @ItemCode NVARCHAR(50),
    @ItemName NVARCHAR(200),
    @ItemTypeId TINYINT,
    @CategoryId INT,
    @UnitId INT,
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @ItemCode = LTRIM(RTRIM(@ItemCode));
        SET @ItemName = LTRIM(RTRIM(@ItemName));

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemId = @ItemId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'الصنف غير موجود' AS ResultMessage;
            RETURN;
        END;

        IF NULLIF(@ItemCode, N'') IS NULL
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'كود الصنف مطلوب' AS ResultMessage;
            RETURN;
        END;

        IF NULLIF(@ItemName, N'') IS NULL
        BEGIN
            SELECT
                -3 AS ResultCode,
                N'اسم الصنف العربي مطلوب' AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.ItemTypes
            WHERE ItemTypeId = @ItemTypeId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -4 AS ResultCode,
                N'نوع الصنف غير موجود أو غير فعال' AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Categories
            WHERE CategoryId = @CategoryId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -5 AS ResultCode,
                N'التصنيف غير موجود أو غير فعال' AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitId = @UnitId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -6 AS ResultCode,
                N'وحدة القياس غير موجودة أو غير فعالة' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemCode = @ItemCode
              AND ItemId <> @ItemId
        )
        BEGIN
            SELECT
                -7 AS ResultCode,
                N'كود الصنف مستخدم من صنف آخر' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemName = @ItemName
              AND ItemId <> @ItemId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -8 AS ResultCode,
                N'اسم الصنف مستخدم من صنف آخر' AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.Items
        SET
            ItemCode = @ItemCode,
            ItemName = @ItemName,
            ItemTypeId = @ItemTypeId,
            CategoryId = @CategoryId,
            UnitId = @UnitId,
            Notes = NULLIF(LTRIM(RTRIM(@Notes)), N''),
            UpdatedAt = SYSDATETIME()
        WHERE ItemId = @ItemId;

        SELECT
            1 AS ResultCode,
            N'تم تعديل الصنف بنجاح' AS ResultMessage,
            @ItemId AS ItemId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء تعديل الصنف' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [ItemCost_RecalculateFromItem]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [ItemCost_RecalculateFromItem]
    @ItemId INT,
    @AsOfDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @AsOfDate IS NULL
        SET @AsOfDate = CAST(GETDATE() AS DATE);

    IF OBJECT_ID('tempdb..#RecipesToProcess') IS NOT NULL
        DROP TABLE #RecipesToProcess;

    CREATE TABLE #RecipesToProcess
    (
        RecipeId INT NOT NULL PRIMARY KEY,
        Depth INT NOT NULL
    );

    ;WITH RecipeTree AS
    (
        SELECT
            r.RecipeId,
            r.OutputItemId,
            0 AS Depth,
            CAST(',' + CAST(r.RecipeId AS VARCHAR(20)) + ',' AS VARCHAR(MAX)) AS Path
        FROM dbo.Recipes r
        INNER JOIN dbo.RecipeDetails rd
            ON rd.RecipeId = r.RecipeId
        WHERE rd.IngredientItemId = @ItemId
          AND r.IsActive = 1

        UNION ALL

        SELECT
            r.RecipeId,
            r.OutputItemId,
            rt.Depth + 1,
            CAST(
                rt.Path + CAST(r.RecipeId AS VARCHAR(20)) + ','
                AS VARCHAR(MAX)
            )
        FROM RecipeTree rt
        INNER JOIN dbo.RecipeDetails rd
            ON rd.IngredientItemId = rt.OutputItemId
        INNER JOIN dbo.Recipes r
            ON r.RecipeId = rd.RecipeId
           AND r.IsActive = 1
        WHERE rt.Path NOT LIKE
              '%,' + CAST(r.RecipeId AS VARCHAR(20)) + ',%'
    )
    INSERT INTO #RecipesToProcess
    (
        RecipeId,
        Depth
    )
    SELECT
        RecipeId,
        MIN(Depth) AS Depth
    FROM RecipeTree
    GROUP BY RecipeId
    OPTION (MAXRECURSION 32767);

    DECLARE
        @RecipeId INT,
        @Depth INT;

    DECLARE RecipeCursor CURSOR LOCAL FAST_FORWARD
    FOR
        SELECT
            RecipeId,
            Depth
        FROM #RecipesToProcess
        ORDER BY
            Depth ASC,
            RecipeId ASC;

    OPEN RecipeCursor;

    FETCH NEXT FROM RecipeCursor
        INTO @RecipeId, @Depth;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC dbo.Recipe_RecalculateCost
            @RecipeId = @RecipeId,
            @AsOfDate = @AsOfDate;

        FETCH NEXT FROM RecipeCursor
            INTO @RecipeId, @Depth;
    END;

    CLOSE RecipeCursor;
    DEALLOCATE RecipeCursor;

    SELECT
        r.RecipeId,
        r.RecipeCode,
        i.ItemId,
        i.ItemCode,
        i.ItemName,
        r.ActualOutputQuantity,
        ic.CostPerUnit,
        ic.Currency,
        ic.CostDate
    FROM #RecipesToProcess p
    INNER JOIN dbo.Recipes r
        ON r.RecipeId = p.RecipeId
    INNER JOIN dbo.Items i
        ON i.ItemId = r.OutputItemId
    LEFT JOIN dbo.ItemCosts ic
        ON ic.ItemId = r.OutputItemId
       AND ic.SourceRecipeId = r.RecipeId
    ORDER BY
        p.Depth,
        r.RecipeId;
END;
GO
/****** Object: StoredProcedure [ItemPrice_GetAll] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [ItemPrice_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ip.ItemPriceId,
        ip.ItemId,
        i.ItemCode,
        i.ItemName,
        ip.Price,
        ip.UnitId,
        u.UnitName,
        u.Symbol AS UnitSymbol,
        ip.Currency,
        ip.EffectiveDate,
        ip.IsActive,
        ip.Notes,
        ip.CreatedAt
    FROM dbo.ItemPrices ip
    INNER JOIN dbo.Items i ON i.ItemId = ip.ItemId
    LEFT JOIN dbo.Units u ON u.UnitId = ip.UnitId
    ORDER BY i.ItemName, ip.EffectiveDate DESC, ip.CreatedAt DESC;
END
GO
/****** Object:  StoredProcedure [ItemPrice_ActivateDuePrices]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [ItemPrice_ActivateDuePrices]
    @AsOfDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @AsOfDate IS NULL
        SET @AsOfDate = CAST(GETDATE() AS DATE);

    DECLARE @ChangedItems TABLE
    (
        ItemId INT PRIMARY KEY
    );

    BEGIN TRY

        BEGIN TRANSACTION;

        ;WITH RankedPrices AS
        (
            SELECT
                ip.ItemPriceId,
                ip.ItemId,
                ROW_NUMBER() OVER
                (
                    PARTITION BY ip.ItemId
                    ORDER BY
                        ip.EffectiveDate DESC,
                        ip.CreatedAt DESC,
                        ip.ItemPriceId DESC
                ) AS rn
            FROM dbo.ItemPrices ip
            INNER JOIN dbo.Items i
                ON i.ItemId = ip.ItemId
               AND i.IsActive = 1
            WHERE ip.EffectiveDate <= @AsOfDate
        ),
        DuePrices AS
        (
            SELECT
                ItemId,
                ItemPriceId
            FROM RankedPrices
            WHERE rn = 1
        )
        INSERT INTO @ChangedItems
        (
            ItemId
        )
        SELECT DISTINCT
            dp.ItemId
        FROM DuePrices dp
        INNER JOIN dbo.ItemPrices currentPrice
            ON currentPrice.ItemId = dp.ItemId
           AND currentPrice.IsActive = 1
        WHERE currentPrice.ItemPriceId <> dp.ItemPriceId;


        ;WITH RankedPrices AS
        (
            SELECT
                ip.ItemPriceId,
                ip.ItemId,
                ROW_NUMBER() OVER
                (
                    PARTITION BY ip.ItemId
                    ORDER BY
                        ip.EffectiveDate DESC,
                        ip.CreatedAt DESC,
                        ip.ItemPriceId DESC
                ) AS rn
            FROM dbo.ItemPrices ip
            INNER JOIN dbo.Items i
                ON i.ItemId = ip.ItemId
               AND i.IsActive = 1
            WHERE ip.EffectiveDate <= @AsOfDate
        ),
        DuePrices AS
        (
            SELECT
                ItemId,
                ItemPriceId
            FROM RankedPrices
            WHERE rn = 1
        )
        UPDATE ip
        SET
            IsActive =
                CASE
                    WHEN dp.ItemPriceId = ip.ItemPriceId
                    THEN 1
                    ELSE 0
                END
        FROM dbo.ItemPrices ip
        INNER JOIN DuePrices dp
            ON dp.ItemId = ip.ItemId;


        DECLARE @ItemId INT;

        DECLARE ItemCursor CURSOR LOCAL FAST_FORWARD
        FOR
            SELECT ItemId
            FROM @ChangedItems;

        OPEN ItemCursor;

        FETCH NEXT FROM ItemCursor
            INTO @ItemId;

        WHILE @@FETCH_STATUS = 0
        BEGIN

            EXEC dbo.ItemCost_RecalculateFromItem
                @ItemId = @ItemId,
                @AsOfDate = @AsOfDate;

            FETCH NEXT FROM ItemCursor
                INTO @ItemId;

        END;

        CLOSE ItemCursor;
        DEALLOCATE ItemCursor;


        COMMIT TRANSACTION;


        SELECT
            ip.ItemPriceId,
            ip.ItemId,
            i.ItemCode,
            i.ItemName,
            ip.Price,
            ip.UnitId,
            ip.Currency,
            ip.EffectiveDate,
            ip.IsActive
        FROM dbo.ItemPrices ip
        INNER JOIN dbo.Items i
            ON i.ItemId = ip.ItemId
        WHERE ip.IsActive = 1
        ORDER BY
            ip.ItemId;

    END TRY

    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END;
GO
/****** Object:  StoredProcedure [ItemPrice_Set]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [ItemPrice_Set]
    @ItemId INT,
    @Price DECIMAL(18,4),
    @UnitId INT,
    @Currency NVARCHAR(10) = N'LYD',
    @EffectiveDate DATE = NULL,
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE
        @NewItemPriceId INT,
        @Today DATE = CAST(GETDATE() AS DATE);

    IF @EffectiveDate IS NULL
        SET @EffectiveDate = @Today;

    SET @Notes = NULLIF(LTRIM(RTRIM(@Notes)), N'');

    IF @Price < 0
    BEGIN
        THROW 50020, N'السعر لا يمكن أن يكون سالبًا.', 1;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Items
        WHERE ItemId = @ItemId
          AND IsActive = 1
    )
    BEGIN
        THROW 50021, N'المادة غير موجودة أو غير فعالة.', 1;
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Units
        WHERE UnitId = @UnitId
          AND IsActive = 1
    )
    BEGIN
        THROW 50022, N'وحدة القياس غير موجودة أو غير فعالة.', 1;
    END;

    BEGIN TRY

        BEGIN TRANSACTION;

        /*
            إذا كان السعر ساريًا اليوم أو في الماضي،
            نجعل الأسعار السابقة غير فعالة.
        */
        IF @EffectiveDate <= @Today
        BEGIN
            UPDATE dbo.ItemPrices
            SET IsActive = 0
            WHERE ItemId = @ItemId
              AND IsActive = 1;
        END;

        INSERT INTO dbo.ItemPrices
        (
            ItemId,
            Price,
            UnitId,
            Currency,
            EffectiveDate,
            IsActive,
            Notes
        )
        VALUES
        (
            @ItemId,
            @Price,
            @UnitId,
            @Currency,
            @EffectiveDate,
            CASE
                WHEN @EffectiveDate <= @Today THEN 1
                ELSE 0
            END,
            @Notes
        );

        SET @NewItemPriceId = CONVERT(INT, SCOPE_IDENTITY());

        /*
            إعادة حساب التكلفة فقط إذا أصبح السعر ساريًا.
        */
        IF @EffectiveDate <= @Today
        BEGIN
            EXEC dbo.ItemCost_RecalculateFromItem
                @ItemId = @ItemId;
        END;

        COMMIT TRANSACTION;

        SELECT
            ItemPriceId,
            ItemId,
            Price,
            UnitId,
            Currency,
            EffectiveDate,
            IsActive,
            Notes
        FROM dbo.ItemPrices
        WHERE ItemPriceId = @NewItemPriceId;

    END TRY

    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END;
GO
/****** Object:  StoredProcedure [ItemType_Delete]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [ItemType_Delete]
    @ItemTypeId TINYINT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.ItemTypes
            WHERE ItemTypeId = @ItemTypeId
        )
        BEGIN
            THROW 50001, N'نوع الصنف غير موجود.', 1;
        END;

        UPDATE dbo.ItemTypes
        SET
            IsActive = 0
        WHERE ItemTypeId = @ItemTypeId;

    END TRY

    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [ItemType_GetAll]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   ITEM TYPES
   ========================================================= */

CREATE PROCEDURE [ItemType_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ItemTypeId,
        TypeName,
        IsActive
    FROM dbo.ItemTypes
    WHERE IsActive = 1
    ORDER BY ItemTypeId;
END
GO
/****** Object:  StoredProcedure [ItemType_GetById]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [ItemType_GetById]
    @ItemTypeId TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ItemTypeId,
        TypeName,
        IsActive
    FROM dbo.ItemTypes
    WHERE ItemTypeId = @ItemTypeId;
END
GO
/****** Object:  StoredProcedure [ItemType_Insert]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [ItemType_Insert]
    @TypeName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @TypeName = LTRIM(RTRIM(@TypeName));

        IF NULLIF(@TypeName, N'') IS NULL
        BEGIN
            THROW 50001, N'اسم نوع الصنف مطلوب.', 1;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.ItemTypes
            WHERE TypeName = @TypeName
        )
        BEGIN
            THROW 50002, N'نوع الصنف موجود مسبقاً.', 1;
        END;

        INSERT INTO dbo.ItemTypes
        (
            TypeName
        )
        VALUES
        (
            @TypeName
        );

        DECLARE @ItemTypeId TINYINT =
            CONVERT(TINYINT, SCOPE_IDENTITY());

        SELECT
            ItemTypeId,
            TypeName,
            IsActive
        FROM dbo.ItemTypes
        WHERE ItemTypeId = @ItemTypeId;

    END TRY

    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [ItemType_Update]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [ItemType_Update]
    @ItemTypeId TINYINT,
    @TypeName NVARCHAR(50),
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @TypeName = LTRIM(RTRIM(@TypeName));

        IF NULLIF(@TypeName, N'') IS NULL
        BEGIN
            THROW 50001, N'اسم نوع الصنف مطلوب.', 1;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.ItemTypes
            WHERE ItemTypeId = @ItemTypeId
        )
        BEGIN
            THROW 50002, N'نوع الصنف غير موجود.', 1;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.ItemTypes
            WHERE TypeName = @TypeName
              AND ItemTypeId <> @ItemTypeId
        )
        BEGIN
            THROW 50003, N'نوع الصنف موجود مسبقاً.', 1;
        END;

        UPDATE dbo.ItemTypes
        SET
            TypeName = @TypeName,
            IsActive = @IsActive
        WHERE ItemTypeId = @ItemTypeId;

    END TRY

    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [Recipe_Deactivate]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Recipe_Deactivate]
    @RecipeId INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Recipes
            WHERE RecipeId = @RecipeId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'الوصفة غير موجودة' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Recipes
            WHERE RecipeId = @RecipeId
              AND IsActive = 0
        )
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'الوصفة معطلة بالفعل' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.RecipeDetails rd
            INNER JOIN dbo.Recipes r
                ON r.OutputItemId = rd.IngredientItemId
               AND r.IsActive = 1
            WHERE rd.RecipeId = @RecipeId
        )
        BEGIN
            SELECT
                -3 AS ResultCode,
                N'لا يمكن تعطيل الوصفة لأنها تحتوي على مكونات مرتبطة بوصفات نشطة' AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.Recipes
        SET
            IsActive = 0,
            UpdatedAt = SYSDATETIME()
        WHERE RecipeId = @RecipeId;

        SELECT
            1 AS ResultCode,
            N'تم تعطيل الوصفة بنجاح' AS ResultMessage,
            @RecipeId AS RecipeId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء تعطيل الوصفة' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END;
GO
/****** Object:  StoredProcedure [Recipe_GetAll]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   RECIPES
   ========================================================= */

CREATE PROCEDURE [Recipe_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        r.RecipeId,
        r.RecipeCode,
        r.RecipeName,

        r.OutputItemId,
        i.ItemCode AS OutputItemCode,
        i.Itemname AS OutputItemName,

        r.OutputQuantity,

        r.OutputUnitId,
        u.Unitname AS OutputUnitName,
        u.Symbol AS OutputUnitSymbol,

        r.VersionNo,
        r.IsActive,
        r.Notes,
        r.CreatedAt,
        r.UpdatedAt

    FROM dbo.Recipes r

    INNER JOIN dbo.Items i
        ON r.OutputItemId = i.ItemId

    INNER JOIN dbo.Units u
        ON r.OutputUnitId = u.UnitId

    ORDER BY r.Recipename;
END
GO
/****** Object:  StoredProcedure [Recipe_GetById]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Recipe_GetById]
    @RecipeId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        r.RecipeId,
        r.RecipeCode,
        r.RecipeName,

        r.OutputItemId,
        i.ItemCode AS OutputItemCode,
        i.Itemname AS OutputItemName,

        r.OutputQuantity,

        r.OutputUnitId,
        u.Unitname AS OutputUnitName,
        u.Symbol AS OutputUnitSymbol,

        r.VersionNo,
        r.IsActive,
        r.Notes,
        r.CreatedAt,
        r.UpdatedAt,

        r.ActualOutputQuantity,
        r.BatchInputQuantity

    FROM dbo.Recipes r

    INNER JOIN dbo.Items i
        ON r.OutputItemId = i.ItemId

    INNER JOIN dbo.Units u
        ON r.OutputUnitId = u.UnitId

    WHERE r.RecipeId = @RecipeId;
END
GO
/****** Object:  StoredProcedure [Recipe_GetByIngredient]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Recipe_GetByIngredient]
    @IngredientItemId INT
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        r.RecipeId,
        r.RecipeCode,
        r.RecipeName,
        r.OutputItemId,
        i.ItemCode AS OutputItemCode,
        i.Itemname AS OutputItemName,
        r.VersionNo,
        r.IsActive
    FROM dbo.RecipeDetails rd

    INNER JOIN dbo.Recipes r
        ON r.RecipeId = rd.RecipeId

    INNER JOIN dbo.Items i
        ON i.ItemId = r.OutputItemId

    WHERE rd.IngredientItemId = @IngredientItemId
      AND r.IsActive = 1

    ORDER BY
        r.VersionNo DESC,
        r.RecipeId DESC
END
GO
/****** Object:  StoredProcedure [Recipe_Insert]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Recipe_Insert]
    @RecipeCode NVARCHAR(50),
    @RecipeName NVARCHAR(200),
    @OutputItemId INT,
    @OutputQuantity DECIMAL(18,4),
    @OutputUnitId INT,
    @VersionNo INT = 1,
    @Notes NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Recipes
    (
        RecipeCode,
        RecipeName,
        OutputItemId,
        OutputQuantity,
        OutputUnitId,
        VersionNo,
        Notes
    )
    VALUES
    (
        @RecipeCode,
        @RecipeName,
        @OutputItemId,
        @OutputQuantity,
        @OutputUnitId,
        @VersionNo,
        @Notes
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS RecipeId;
END
GO
/****** Object:  StoredProcedure [Recipe_RecalculateCost]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Recipe_RecalculateCost]
    @RecipeId INT,
    @AsOfDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @AsOfDate IS NULL
        SET @AsOfDate = CAST(GETDATE() AS DATE);

    IF OBJECT_ID('tempdb..#CostProcessing') IS NOT NULL
        DROP TABLE #CostProcessing;

    CREATE TABLE #CostProcessing
    (
        RecipeId INT PRIMARY KEY
    );

    EXEC dbo.Recipe_RecalculateCost_Internal
        @RecipeId = @RecipeId,
        @AsOfDate = @AsOfDate;

    SELECT
        r.RecipeId,
        r.RecipeCode,
        i.ItemId,
        i.ItemCode,
        i.ItemName,
        r.ActualOutputQuantity,
        ic.CostPerUnit,
        ic.Currency,
        ic.CostDate
    FROM dbo.Recipes r
    INNER JOIN dbo.Items i
        ON i.ItemId = r.OutputItemId
    INNER JOIN dbo.ItemCosts ic
        ON ic.ItemId = r.OutputItemId
       AND ic.SourceRecipeId = r.RecipeId
    WHERE r.RecipeId = @RecipeId;
END;
GO
/****** Object:  StoredProcedure [Recipe_RecalculateCost_Internal]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Recipe_RecalculateCost_Internal]
    @RecipeId INT,
    @AsOfDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @AsOfDate IS NULL
        SET @AsOfDate = CAST(GETDATE() AS DATE);

    DECLARE
        @OutputItemId INT,
        @OutputUnitId INT,
        @ActualOutputQuantity DECIMAL(18,4),
        @TotalCost DECIMAL(18,4),
        @CostPerUnit DECIMAL(18,4);

    IF EXISTS
    (
        SELECT 1
        FROM #CostProcessing
        WHERE RecipeId = @RecipeId
    )
    BEGIN
        THROW 50010, N'تم اكتشاف دورة في الوصفات أثناء حساب التكلفة.', 1;
    END;

    INSERT INTO #CostProcessing (RecipeId)
    VALUES (@RecipeId);

    SELECT
        @OutputItemId = OutputItemId,
        @OutputUnitId = OutputUnitId,
        @ActualOutputQuantity = ActualOutputQuantity
    FROM dbo.Recipes
    WHERE RecipeId = @RecipeId
      AND IsActive = 1;

    IF @OutputItemId IS NULL
        THROW 50011, N'الوصفة غير موجودة أو غير فعالة.', 1;

    IF @ActualOutputQuantity IS NULL
       OR @ActualOutputQuantity <= 0
        THROW 50012, N'يجب تحديد ActualOutputQuantity قبل حساب التكلفة.', 1;

    DECLARE
        @IngredientItemId INT,
        @SubRecipeId INT;

    DECLARE IngredientCursor CURSOR LOCAL FAST_FORWARD
    FOR
        SELECT DISTINCT
            rd.IngredientItemId
        FROM dbo.RecipeDetails rd
        WHERE rd.RecipeId = @RecipeId;

    OPEN IngredientCursor;

    FETCH NEXT FROM IngredientCursor
        INTO @IngredientItemId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SubRecipeId = NULL;

        SELECT TOP 1
            @SubRecipeId = r.RecipeId
        FROM dbo.Recipes r
        WHERE r.OutputItemId = @IngredientItemId
          AND r.IsActive = 1
          AND r.RecipeId <> @RecipeId
        ORDER BY
            r.VersionNo DESC,
            r.RecipeId DESC;

        IF @SubRecipeId IS NOT NULL
        BEGIN
            EXEC dbo.Recipe_RecalculateCost_Internal
                @RecipeId = @SubRecipeId,
                @AsOfDate = @AsOfDate;
        END;

        FETCH NEXT FROM IngredientCursor
            INTO @IngredientItemId;
    END;

    CLOSE IngredientCursor;
    DEALLOCATE IngredientCursor;

    CREATE TABLE #IngredientCosts
    (
        RecipeDetailId INT NOT NULL,
        IngredientItemId INT NOT NULL,
        OriginalQuantity DECIMAL(18,4) NOT NULL,
        RecipeUnitId INT NOT NULL,
        CostUnitId INT NULL,
        ConversionFactor DECIMAL(18,8) NULL,
        ConvertedQuantity DECIMAL(18,8) NULL,
        UnitCost DECIMAL(18,4) NULL,
        TotalCost DECIMAL(18,4) NULL
    );

    INSERT INTO #IngredientCosts
    (
        RecipeDetailId,
        IngredientItemId,
        OriginalQuantity,
        RecipeUnitId,
        CostUnitId,
        ConversionFactor,
        ConvertedQuantity,
        UnitCost,
        TotalCost
    )
    SELECT
        rd.RecipeDetailId,
        rd.IngredientItemId,
        rd.Quantity,
        rd.UnitId,
        CostBase.CostUnitId,
        ConversionData.ConversionFactor,
        CASE
            WHEN ConversionData.ConversionFactor IS NOT NULL
            THEN rd.Quantity * ConversionData.ConversionFactor
            ELSE NULL
        END,
        CostBase.UnitCost,
        CASE
            WHEN ConversionData.ConversionFactor IS NOT NULL
               AND CostBase.UnitCost IS NOT NULL
            THEN
                rd.Quantity
                * ConversionData.ConversionFactor
                * CostBase.UnitCost
            ELSE NULL
        END
    FROM dbo.RecipeDetails rd

    OUTER APPLY
    (
        SELECT TOP 1
            r.RecipeId
        FROM dbo.Recipes r
        WHERE r.OutputItemId = rd.IngredientItemId
          AND r.IsActive = 1
        ORDER BY
            r.VersionNo DESC,
            r.RecipeId DESC
    ) sr

    OUTER APPLY
    (
        SELECT
            CASE
                WHEN sr.RecipeId IS NOT NULL
                THEN
                (
                    SELECT TOP 1
                        ic.CostPerUnit
                    FROM dbo.ItemCosts ic
                    WHERE ic.ItemId = rd.IngredientItemId
                      AND ic.SourceRecipeId = sr.RecipeId
                    ORDER BY
                        ic.CostDate DESC,
                        ic.ItemCostId DESC
                )
                ELSE
                (
                    SELECT TOP 1
                        ip.Price
                    FROM dbo.ItemPrices ip
                    WHERE ip.ItemId = rd.IngredientItemId
                      AND ip.EffectiveDate <= @AsOfDate
                    ORDER BY
                        ip.EffectiveDate DESC,
                        ip.CreatedAt DESC,
                        ip.ItemPriceId DESC
                )
            END AS UnitCost,

            CASE
                WHEN sr.RecipeId IS NOT NULL
                THEN
                (
                    SELECT TOP 1
                        ic.UnitId
                    FROM dbo.ItemCosts ic
                    WHERE ic.ItemId = rd.IngredientItemId
                      AND ic.SourceRecipeId = sr.RecipeId
                    ORDER BY
                        ic.CostDate DESC,
                        ic.ItemCostId DESC
                )
                ELSE
                (
                    SELECT TOP 1
                        ip.UnitId
                    FROM dbo.ItemPrices ip
                    WHERE ip.ItemId = rd.IngredientItemId
                      AND ip.EffectiveDate <= @AsOfDate
                    ORDER BY
                        ip.EffectiveDate DESC,
                        ip.CreatedAt DESC,
                        ip.ItemPriceId DESC
                )
            END AS CostUnitId
    ) CostBase

    OUTER APPLY
    (
        SELECT
            CASE
                WHEN rd.UnitId = CostBase.CostUnitId
                THEN CAST(1.00000000 AS DECIMAL(18,8))
                ELSE
                (
                    SELECT TOP 1
                        uc.ConversionFactor
                    FROM dbo.UnitConversions uc
                    WHERE uc.FromUnitId = rd.UnitId
                      AND uc.ToUnitId = CostBase.CostUnitId
                      AND uc.IsActive = 1
                )
            END AS ConversionFactor
    ) ConversionData

    WHERE rd.RecipeId = @RecipeId;

    IF EXISTS
    (
        SELECT 1
        FROM #IngredientCosts
        WHERE UnitCost IS NULL
    )
    BEGIN
        SELECT
            RecipeDetailId,
            IngredientItemId,
            OriginalQuantity,
            RecipeUnitId,
            CostUnitId,
            UnitCost
        FROM #IngredientCosts
        WHERE UnitCost IS NULL;

        THROW 50013,
              N'لا توجد تكلفة معرفة لأحد مكونات الوصفة.',
              1;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM #IngredientCosts
        WHERE ConversionFactor IS NULL
    )
    BEGIN
        SELECT
            RecipeDetailId,
            IngredientItemId,
            OriginalQuantity,
            RecipeUnitId,
            CostUnitId,
            ConversionFactor
        FROM #IngredientCosts
        WHERE ConversionFactor IS NULL;

        THROW 50014,
              N'لا يوجد تحويل معرف بين وحدة أحد مكونات الوصفة ووحدة تكلفته.',
              1;
    END;

    SELECT
        @TotalCost = ISNULL(SUM(TotalCost), 0)
    FROM #IngredientCosts;

    SET @CostPerUnit =
        @TotalCost / @ActualOutputQuantity;

    DELETE FROM dbo.ItemCosts
    WHERE ItemId = @OutputItemId
      AND SourceRecipeId = @RecipeId;

    INSERT INTO dbo.ItemCosts
    (
        ItemId,
        CostPerUnit,
        UnitId,
        Currency,
        CostDate,
        SourceRecipeId,
        Notes
    )
    VALUES
    (
        @OutputItemId,
        @CostPerUnit,
        @OutputUnitId,
        N'LYD',
        @AsOfDate,
        @RecipeId,
        N'تكلفة محسوبة تلقائيًا مع تحويل وحدات القياس'
    );

    DELETE FROM #CostProcessing
    WHERE RecipeId = @RecipeId;

END;
GO
/****** Object:  StoredProcedure [Recipe_Save]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Recipe_Save]
    @RecipeId INT = NULL,

    @RecipeCode NVARCHAR(50),
    @Recipename NVARCHAR(200),

    @OutputItemId INT,
    @OutputQuantity DECIMAL(18,4),
    @OutputUnitId INT,

    @VersionNo INT = 1,
    @Notes NVARCHAR(1000) = NULL,

    @Ingredients dbo.RecipeIngredientType READONLY
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        BEGIN TRANSACTION;


        /* =====================================================
           1. تنظيف القيم النصية
           ===================================================== */

        SET @RecipeCode   = LTRIM(RTRIM(@RecipeCode));
        SET @RecipeName = LTRIM(RTRIM(@Recipename));
        SET @Notes        = NULLIF(LTRIM(RTRIM(@Notes)), N'');


        /* =====================================================
           2. التحقق الأساسي
           ===================================================== */

        IF NULLIF(@RecipeCode, N'') IS NULL
        BEGIN
            ROLLBACK;

            SELECT
                -1 AS ResultCode,
                N'كود الوصفة مطلوب' AS ResultMessage;
            RETURN;
        END;


        IF NULLIF(@RecipeName, N'') IS NULL
        BEGIN
            ROLLBACK;

            SELECT
                -2 AS ResultCode,
                N'اسم الوصفة مطلوب' AS ResultMessage;
            RETURN;
        END;


        IF @OutputQuantity IS NULL
           OR @OutputQuantity <= 0
        BEGIN
            ROLLBACK;

            SELECT
                -3 AS ResultCode,
                N'كمية الإنتاج يجب أن تكون أكبر من صفر' AS ResultMessage;
            RETURN;
        END;


        IF @VersionNo IS NULL
           OR @VersionNo <= 0
        BEGIN
            ROLLBACK;

            SELECT
                -4 AS ResultCode,
                N'رقم الإصدار غير صحيح' AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           3. التحقق من المنتج الناتج
           ===================================================== */

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemId = @OutputItemId
              AND IsActive = 1
        )
        BEGIN
            ROLLBACK;

            SELECT
                -5 AS ResultCode,
                N'صنف الناتج غير موجود أو غير فعال' AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           4. التحقق من وحدة الناتج
           ===================================================== */

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitId = @OutputUnitId
              AND IsActive = 1
        )
        BEGIN
            ROLLBACK;

            SELECT
                -6 AS ResultCode,
                N'وحدة الناتج غير موجودة أو غير فعالة' AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           5. يجب وجود مكون واحد على الأقل
           ===================================================== */

        IF NOT EXISTS
        (
            SELECT 1
            FROM @Ingredients
        )
        BEGIN
            ROLLBACK;

            SELECT
                -7 AS ResultCode,
                N'يجب أن تحتوي الوصفة على مكون واحد على الأقل'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           6. التحقق من كميات المكونات
           ===================================================== */

        IF EXISTS
        (
            SELECT 1
            FROM @Ingredients
            WHERE Quantity IS NULL
               OR Quantity <= 0
        )
        BEGIN
            ROLLBACK;

            SELECT
                -8 AS ResultCode,
                N'توجد كمية مكون غير صحيحة'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           7. التحقق من نسبة الهالك
           ===================================================== */

        IF EXISTS
        (
            SELECT 1
            FROM @Ingredients
            WHERE WastePercent IS NULL
               OR WastePercent < 0
               OR WastePercent > 100
        )
        BEGIN
            ROLLBACK;

            SELECT
                -9 AS ResultCode,
                N'نسبة الهالك يجب أن تكون بين 0 و100'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           8. منع المنتج من استخدام نفسه مباشرة
           ===================================================== */

        IF EXISTS
        (
            SELECT 1
            FROM @Ingredients
            WHERE IngredientItemId = @OutputItemId
        )
        BEGIN
            ROLLBACK;

            SELECT
                -10 AS ResultCode,
                N'لا يمكن أن يكون المنتج نفسه أحد مكونات وصفته'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           9. التحقق من جميع المكونات
           ===================================================== */

        IF EXISTS
        (
            SELECT 1
            FROM @Ingredients x
            LEFT JOIN dbo.Items i
                ON i.ItemId = x.IngredientItemId
               AND i.IsActive = 1
            WHERE i.ItemId IS NULL
        )
        BEGIN
            ROLLBACK;

            SELECT
                -11 AS ResultCode,
                N'يوجد مكون غير موجود أو غير فعال'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           10. التحقق من وحدات المكونات
           ===================================================== */

        IF EXISTS
        (
            SELECT 1
            FROM @Ingredients x
            LEFT JOIN dbo.Units u
                ON u.UnitId = x.UnitId
               AND u.IsActive = 1
            WHERE u.UnitId IS NULL
        )
        BEGIN
            ROLLBACK;

            SELECT
                -12 AS ResultCode,
                N'توجد وحدة قياس غير موجودة أو غير فعالة'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           11. التحقق من SequenceNo
           ===================================================== */

        IF EXISTS
        (
            SELECT 1
            FROM @Ingredients
            WHERE SequenceNo IS NULL
               OR SequenceNo <= 0
        )
        BEGIN
            ROLLBACK;

            SELECT
                -17 AS ResultCode,
                N'رقم ترتيب المكون SequenceNo يجب أن يكون أكبر من صفر'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           12. منع تكرار نفس المكون في الوصفة
           ===================================================== */

        IF EXISTS
        (
            SELECT
                IngredientItemId
            FROM @Ingredients
            GROUP BY IngredientItemId
            HAVING COUNT(*) > 1
        )
        BEGIN
            ROLLBACK;

            SELECT
                -18 AS ResultCode,
                N'لا يمكن تكرار نفس المكون أكثر من مرة في الوصفة'
                AS ResultMessage;
            RETURN;
        END;


        /* =====================================================
           13. التحقق من كود الوصفة
           ===================================================== */

        IF @RecipeId IS NULL
        BEGIN

            IF EXISTS
            (
                SELECT 1
                FROM dbo.Recipes
                WHERE RecipeCode = @RecipeCode
            )
            BEGIN
                ROLLBACK;

                SELECT
                    -13 AS ResultCode,
                    N'كود الوصفة موجود مسبقاً'
                    AS ResultMessage;
                RETURN;
            END;

        END
        ELSE
        BEGIN

            IF NOT EXISTS
            (
                SELECT 1
                FROM dbo.Recipes
                WHERE RecipeId = @RecipeId
            )
            BEGIN
                ROLLBACK;

                SELECT
                    -14 AS ResultCode,
                    N'الوصفة غير موجودة'
                    AS ResultMessage;
                RETURN;
            END;


            IF EXISTS
            (
                SELECT 1
                FROM dbo.Recipes
                WHERE RecipeCode = @RecipeCode
                  AND RecipeId <> @RecipeId
            )
            BEGIN
                ROLLBACK;

                SELECT
                    -15 AS ResultCode,
                    N'كود الوصفة مستخدم في وصفة أخرى'
                    AS ResultMessage;
                RETURN;
            END;

        END;


        /* =====================================================
           14. Circular Dependency Check
           ===================================================== */

        DECLARE @CircularDependency TABLE
        (
            IngredientItemId INT NOT NULL,
            Itemname NVARCHAR(200) NULL,
            DependencyPath NVARCHAR(MAX) NULL
        );


        ;WITH RecipeGraph AS
        (
            SELECT
                r.OutputItemId AS ParentItemId,
                rd.IngredientItemId AS ChildItemId,

                CAST(
                    N'|' +
                    CAST(r.OutputItemId AS NVARCHAR(20)) +
                    N'|' +
                    CAST(rd.IngredientItemId AS NVARCHAR(20)) +
                    N'|'
                    AS NVARCHAR(MAX)
                ) AS Path

            FROM dbo.Recipes r

            INNER JOIN dbo.RecipeDetails rd
                ON r.RecipeId = rd.RecipeId

            WHERE
                r.IsActive = 1
                AND
                (
                    @RecipeId IS NULL
                    OR r.RecipeId <> @RecipeId
                )


            UNION ALL


            SELECT
                rg.ParentItemId,
                rd.IngredientItemId,

                CAST(
                    rg.Path +
                    CAST(rd.IngredientItemId AS NVARCHAR(20)) +
                    N'|'
                    AS NVARCHAR(MAX)
                ) AS Path

            FROM RecipeGraph rg

            INNER JOIN dbo.Recipes r
                ON r.OutputItemId = rg.ChildItemId

            INNER JOIN dbo.RecipeDetails rd
                ON r.RecipeId = rd.RecipeId

            WHERE
                r.IsActive = 1
                AND
                (
                    @RecipeId IS NULL
                    OR r.RecipeId <> @RecipeId
                )
                AND CHARINDEX
                (
                    N'|' +
                    CAST(rd.IngredientItemId AS NVARCHAR(20)) +
                    N'|',
                    rg.Path
                ) = 0
        )

        INSERT INTO @CircularDependency
        (
            IngredientItemId,
            ItemName,
            DependencyPath
        )

        SELECT TOP 1
            x.IngredientItemId,
            i.ItemName,
            rg.Path

        FROM @Ingredients x

        INNER JOIN RecipeGraph rg
            ON rg.ParentItemId = x.IngredientItemId

        INNER JOIN dbo.Items i
            ON i.ItemId = x.IngredientItemId

        WHERE rg.ChildItemId = @OutputItemId

        OPTION (MAXRECURSION 32767);


        /* =====================================================
           15. إذا وجدت دورة
           ===================================================== */

        IF EXISTS
        (
            SELECT 1
            FROM @CircularDependency
        )
        BEGIN

            DECLARE @CircularItemId INT;
            DECLARE @CircularItemName NVARCHAR(200);
            DECLARE @DependencyPath NVARCHAR(MAX);

            SELECT TOP 1
                @CircularItemId = IngredientItemId,
                @CircularItemName = ItemName,
                @DependencyPath = DependencyPath
            FROM @CircularDependency;


            ROLLBACK;

            SELECT
                -16 AS ResultCode,

                N'لا يمكن حفظ الوصفة لأنها ستؤدي إلى علاقة دائرية. ' +
                N'المكون: ' +
                ISNULL(@CircularItemName, N'غير معروف') +
                N' يعتمد بشكل مباشر أو غير مباشر على المنتج الناتج.'
                AS ResultMessage,

                @CircularItemId AS CircularItemId,
                @DependencyPath AS DependencyPath;

            RETURN;
        END;


        /* =====================================================
           16. إضافة أو تعديل الوصفة
           ===================================================== */

        IF @RecipeId IS NULL
        BEGIN

            INSERT INTO dbo.Recipes
            (
                RecipeCode,
                RecipeName,
                OutputItemId,
                OutputQuantity,
                OutputUnitId,
                VersionNo,
                ActualOutputQuantity,
                BatchInputQuantity,
                Notes
            )
            VALUES
            (
                @RecipeCode,
                @RecipeName,
                @OutputItemId,
                @OutputQuantity,
                @OutputUnitId,
                @VersionNo,

                @OutputQuantity,
                @OutputQuantity,

                @Notes
            );


            SET @RecipeId = CONVERT(INT, SCOPE_IDENTITY());

        END
        ELSE
        BEGIN

            UPDATE dbo.Recipes
            SET
                RecipeCode = @RecipeCode,
                RecipeName = @RecipeName,

                OutputItemId = @OutputItemId,
                OutputQuantity = @OutputQuantity,
                OutputUnitId = @OutputUnitId,

                VersionNo = @VersionNo,

                /*
                   لا نغير القيم الفعلية السابقة
                   إذا كانت موجودة.
                */
                BatchInputQuantity =
                    ISNULL(BatchInputQuantity, @OutputQuantity),

                ActualOutputQuantity =
                    ISNULL(ActualOutputQuantity, @OutputQuantity),

                Notes = @Notes,
                UpdatedAt = SYSDATETIME()

            WHERE RecipeId = @RecipeId;


            /* حذف المكونات القديمة */
            DELETE FROM dbo.RecipeDetails
            WHERE RecipeId = @RecipeId;

        END;


        /* =====================================================
           17. إضافة المكونات الجديدة
           ===================================================== */

        INSERT INTO dbo.RecipeDetails
        (
            RecipeId,
            IngredientItemId,
            Quantity,
            UnitId,
            SequenceNo,
            WastePercent,
            Notes
        )
        SELECT
            @RecipeId,
            IngredientItemId,
            Quantity,
            UnitId,
            SequenceNo,
            WastePercent,
            Notes
        FROM @Ingredients;


        /* =====================================================
           18. إنشاء بيئة معالجة التكلفة
           ===================================================== */

        IF OBJECT_ID('tempdb..#CostProcessing') IS NOT NULL
            DROP TABLE #CostProcessing;


        CREATE TABLE #CostProcessing
        (
            RecipeId INT PRIMARY KEY
        );


        /* =====================================================
           19. حساب تكلفة الوصفة الحالية
           ===================================================== */

        EXEC dbo.Recipe_RecalculateCost_Internal
            @RecipeId = @RecipeId;


        /* =====================================================
           20. إعادة حساب الوصفات التابعة
           
           مثال:
           
           Feuilletine
               ↓
           SFG-001
               ↓
           SFG-002
           
           عند تعديل Feuilletine
           يتم تحديث SFG-001 ثم SFG-002.
           ===================================================== */

        EXEC dbo.ItemCost_RecalculateFromItem
            @ItemId = @OutputItemId;


        /* =====================================================
           21. قراءة التكلفة النهائية
           ===================================================== */

        DECLARE @CostPerUnit DECIMAL(18,4);


        SELECT TOP 1
            @CostPerUnit = ic.CostPerUnit

        FROM dbo.ItemCosts ic

        WHERE ic.ItemId = @OutputItemId
          AND ic.SourceRecipeId = @RecipeId

        ORDER BY
            ic.CostDate DESC,
            ic.ItemCostId DESC;


        /* =====================================================
           22. إنهاء Transaction
           ===================================================== */

        COMMIT TRANSACTION;


        /* =====================================================
           23. النتيجة النهائية
           ===================================================== */

        SELECT
            1 AS ResultCode,

            N'تم حفظ الوصفة وإعادة حساب التكلفة بنجاح'
                AS ResultMessage,

            @RecipeId AS RecipeId,

            @OutputItemId AS OutputItemId,

            @CostPerUnit AS CostPerUnit,

            N'LYD' AS Currency;


    END TRY

    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;


        SELECT
            -500 AS ResultCode,

            N'حدث خطأ أثناء حفظ الوصفة'
                AS ResultMessage,

            ERROR_NUMBER() AS ErrorNumber,

            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END;
GO
/****** Object:  StoredProcedure [RecipeDetail_Delete]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [RecipeDetail_Delete]
    @RecipeDetailId BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.RecipeDetails
            WHERE RecipeDetailId = @RecipeDetailId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'مكون الوصفة غير موجود' AS ResultMessage;
            RETURN;
        END;

        DELETE FROM dbo.RecipeDetails
        WHERE RecipeDetailId = @RecipeDetailId;

        SELECT
            1 AS ResultCode,
            N'تم حذف مكون الوصفة بنجاح'
            AS ResultMessage;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء حذف مكون الوصفة'
            AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [RecipeDetail_GetByRecipeId]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   RECIPE DETAILS
   ========================================================= */

CREATE PROCEDURE [RecipeDetail_GetByRecipeId]
    @RecipeId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        rd.RecipeDetailId,
        rd.RecipeId,

        rd.IngredientItemId,
        i.ItemCode,
        i.ItemName,


        rd.Quantity,

        rd.UnitId,
        u.UnitName,
        u.Symbol,

        rd.SequenceNo,
        rd.WastePercent,
        rd.Notes

    FROM dbo.RecipeDetails rd

    INNER JOIN dbo.Items i
        ON rd.IngredientItemId = i.ItemId

    INNER JOIN dbo.Units u
        ON rd.UnitId = u.UnitId

    WHERE rd.RecipeId = @RecipeId

    ORDER BY
        rd.SequenceNo,
        rd.RecipeDetailId;
END
GO
/****** Object:  StoredProcedure [RecipeDetail_Insert]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [RecipeDetail_Insert]
    @RecipeId INT,
    @IngredientItemId INT,
    @Quantity DECIMAL(18,4),
    @UnitId INT,
    @SequenceNo INT = 1,
    @WastePercent DECIMAL(5,2) = 0,
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.RecipeDetails
    (
        RecipeId,
        IngredientItemId,
        Quantity,
        UnitId,
        SequenceNo,
        WastePercent,
        Notes
    )
    VALUES
    (
        @RecipeId,
        @IngredientItemId,
        @Quantity,
        @UnitId,
        @SequenceNo,
        @WastePercent,
        @Notes
    );

    SELECT CAST(SCOPE_IDENTITY() AS BIGINT) AS RecipeDetailId;
END
GO
/****** Object:  StoredProcedure [RecipeDetail_Update]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [RecipeDetail_Update]
    @RecipeDetailId BIGINT,
    @IngredientItemId INT,
    @Quantity DECIMAL(18,4),
    @UnitId INT,
    @SequenceNo INT,
    @WastePercent DECIMAL(5,2),
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.RecipeDetails
            WHERE RecipeDetailId = @RecipeDetailId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'مكون الوصفة غير موجود'
                AS ResultMessage;
            RETURN;
        END;

        IF @Quantity <= 0
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'الكمية يجب أن تكون أكبر من صفر'
                AS ResultMessage;
            RETURN;
        END;

        IF @WastePercent < 0 OR @WastePercent > 100
        BEGIN
            SELECT
                -3 AS ResultCode,
                N'نسبة الهالك يجب أن تكون بين 0 و100'
                AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE ItemId = @IngredientItemId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -4 AS ResultCode,
                N'المكون غير موجود أو غير فعال'
                AS ResultMessage;
            RETURN;
        END;

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitId = @UnitId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -5 AS ResultCode,
                N'وحدة القياس غير موجودة أو غير فعالة'
                AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.RecipeDetails
        SET
            IngredientItemId = @IngredientItemId,
            Quantity = @Quantity,
            UnitId = @UnitId,
            SequenceNo = @SequenceNo,
            WastePercent = @WastePercent,
            Notes = NULLIF(LTRIM(RTRIM(@Notes)), N'')
        WHERE RecipeDetailId = @RecipeDetailId;

        SELECT
            1 AS ResultCode,
            N'تم تعديل مكون الوصفة بنجاح'
            AS ResultMessage,
            @RecipeDetailId AS RecipeDetailId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء تعديل مكون الوصفة'
            AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [Unit_Convert]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Unit_Convert]
    @Quantity DECIMAL(18,4),
    @FromUnitId INT,
    @ToUnitId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @Factor DECIMAL(18,8),
        @Result DECIMAL(18,8);

    -- نفس الوحدة
    IF @FromUnitId = @ToUnitId
    BEGIN
        SELECT
            @Quantity AS OriginalQuantity,
            @FromUnitId AS FromUnitId,
            @ToUnitId AS ToUnitId,
            @Quantity AS ConvertedQuantity;

        RETURN;
    END;

    SELECT TOP 1
        @Factor = ConversionFactor
    FROM dbo.UnitConversions
    WHERE FromUnitId = @FromUnitId
      AND ToUnitId = @ToUnitId
      AND IsActive = 1;

    IF @Factor IS NULL
    BEGIN
        THROW 50040, N'لا يوجد تحويل معرف بين الوحدتين المحددتين.', 1;
    END;

    SET @Result = @Quantity * @Factor;

    SELECT
        @Quantity AS OriginalQuantity,
        @FromUnitId AS FromUnitId,
        @ToUnitId AS ToUnitId,
        @Factor AS ConversionFactor,
        @Result AS ConvertedQuantity;
END;
GO
/****** Object:  StoredProcedure [Unit_Delete]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Unit_Delete]
    @UnitId INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitId = @UnitId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'الوحدة غير موجودة' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Items
            WHERE UnitId = @UnitId
              AND IsActive = 1
        )
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'لا يمكن إيقاف الوحدة لأنها مستخدمة في أصناف'
                AS ResultMessage;
            RETURN;
        END;

        UPDATE dbo.Units
        SET IsActive = 0
        WHERE UnitId = @UnitId;

        SELECT
            1 AS ResultCode,
            N'تم إيقاف الوحدة بنجاح' AS ResultMessage,
            @UnitId AS UnitId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء إيقاف الوحدة' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
/****** Object:  StoredProcedure [Unit_GetAll]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   UNITS
   ========================================================= */

CREATE PROCEDURE [Unit_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        UnitId,
        UnitName,
        Symbol,
        IsActive
    FROM dbo.Units
    WHERE IsActive = 1
    ORDER BY Unitname;
END
GO
/****** Object:  StoredProcedure [Unit_GetById]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Unit_GetById]
    @UnitId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        UnitId,
        UnitName,
        Symbol,
        IsActive
    FROM dbo.Units
    WHERE UnitId = @UnitId;
END
GO
/****** Object:  StoredProcedure [Unit_Insert]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Unit_Insert]
    @UnitName NVARCHAR(50),
    @Symbol NVARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @UnitName = LTRIM(RTRIM(@UnitName));
        SET @Symbol = NULLIF(LTRIM(RTRIM(@Symbol)), N'')

        IF NULLIF(@UnitName, N'') IS NULL
        BEGIN
            THROW 50001, N'اسم الوحدة مطلوب.', 1
        END

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitName = @UnitName
        )
        BEGIN
            THROW 50002, N'اسم الوحدة موجود مسبقاً.', 1
        END

        INSERT INTO dbo.Units
        (
            UnitName,
            Symbol
        )
        VALUES
        (
            @UnitName,
            @Symbol
        )

        DECLARE @UnitId INT = CONVERT(INT, SCOPE_IDENTITY())

        SELECT
            UnitId,
            UnitName,
            Symbol,
            IsActive
        FROM dbo.Units
        WHERE UnitId = @UnitId

    END TRY

    BEGIN CATCH

        THROW;

    END CATCH
END
GO
/****** Object:  StoredProcedure [Unit_Update]    Script Date: 11/10/2026 12:25:16 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Unit_Update]
    @UnitId INT,
    @Unitname NVARCHAR(50),
    @Symbol NVARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        SET @UnitName = LTRIM(RTRIM(@Unitname));
        SET @Symbol = NULLIF(LTRIM(RTRIM(@Symbol)), N'');

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitId = @UnitId
        )
        BEGIN
            SELECT
                -1 AS ResultCode,
                N'الوحدة غير موجودة' AS ResultMessage;
            RETURN;
        END;

        IF NULLIF(@UnitName, N'') IS NULL
        BEGIN
            SELECT
                -2 AS ResultCode,
                N'اسم الوحدة بالعربي مطلوب' AS ResultMessage;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.Units
            WHERE UnitName = @Unitname
              AND UnitId <> @UnitId
        )
        BEGIN
            SELECT
                -4 AS ResultCode,
                N'اسم الوحدة العربي مستخدم مسبقاً' AS ResultMessage;
            RETURN;
        END;       

        UPDATE dbo.Units
        SET
            UnitName = @UnitName,
            Symbol = @Symbol
        WHERE UnitId = @UnitId;

        SELECT
            1 AS ResultCode,
            N'تم تعديل الوحدة بنجاح' AS ResultMessage,
            @UnitId AS UnitId;

    END TRY

    BEGIN CATCH

        SELECT
            -500 AS ResultCode,
            N'حدث خطأ أثناء تعديل الوحدة' AS ResultMessage,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH
END
GO
