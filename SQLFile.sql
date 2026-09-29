USE [ValrhonaDB]
GO
/****** Object:  UserDefinedTableType [dbo].[RecipeIngredientType]    Script Date: 29/09/2026 03:45:20 م ******/
CREATE TYPE [dbo].[RecipeIngredientType] AS TABLE(
	[IngredientItemId] [int] NOT NULL,
	[Quantity] [decimal](18, 4) NOT NULL,
	[UnitId] [int] NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[WastePercent] [decimal](5, 2) NOT NULL,
	[Notes] [nvarchar](500) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[Category_Delete]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Category_Delete]
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
/****** Object:  StoredProcedure [dbo].[Category_GetAll]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   CATEGORIES
   ========================================================= */

CREATE PROCEDURE [dbo].[Category_GetAll]
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
/****** Object:  StoredProcedure [dbo].[Category_GetById]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Category_GetById]
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
/****** Object:  StoredProcedure [dbo].[Category_Insert]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Category_Insert]
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
/****** Object:  StoredProcedure [dbo].[Category_Update]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Category_Update]
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
/****** Object:  StoredProcedure [dbo].[Item_Delete]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Item_Delete]
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
/****** Object:  StoredProcedure [dbo].[Item_GetAll]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   ITEMS
   ========================================================= */

CREATE PROCEDURE [dbo].[Item_GetAll]
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
/****** Object:  StoredProcedure [dbo].[Item_GetById]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Item_GetById]
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
/****** Object:  StoredProcedure [dbo].[Item_Insert]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Item_Insert]
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
/****** Object:  StoredProcedure [dbo].[Item_Search]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Item_Search]
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
/****** Object:  StoredProcedure [dbo].[Item_Update]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Item_Update]
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
/****** Object:  StoredProcedure [dbo].[ItemCost_RecalculateFromItem]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ItemCost_RecalculateFromItem]
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
/****** Object:  StoredProcedure [dbo].[ItemPrice_ActivateDuePrices]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ItemPrice_ActivateDuePrices]
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
/****** Object:  StoredProcedure [dbo].[ItemPrice_Set]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ItemPrice_Set]
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
/****** Object:  StoredProcedure [dbo].[ItemType_Delete]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[ItemType_Delete]
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
/****** Object:  StoredProcedure [dbo].[ItemType_GetAll]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   ITEM TYPES
   ========================================================= */

CREATE PROCEDURE [dbo].[ItemType_GetAll]
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
/****** Object:  StoredProcedure [dbo].[ItemType_GetById]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ItemType_GetById]
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
/****** Object:  StoredProcedure [dbo].[ItemType_Insert]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[ItemType_Insert]
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
/****** Object:  StoredProcedure [dbo].[ItemType_Update]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ItemType_Update]
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
/****** Object:  StoredProcedure [dbo].[Recipe_Deactivate]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Recipe_Deactivate]
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
/****** Object:  StoredProcedure [dbo].[Recipe_GetAll]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   RECIPES
   ========================================================= */

CREATE PROCEDURE [dbo].[Recipe_GetAll]
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
/****** Object:  StoredProcedure [dbo].[Recipe_GetById]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Recipe_GetById]
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
/****** Object:  StoredProcedure [dbo].[Recipe_GetByIngredient]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Recipe_GetByIngredient]
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
/****** Object:  StoredProcedure [dbo].[Recipe_Insert]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Recipe_Insert]
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
/****** Object:  StoredProcedure [dbo].[Recipe_RecalculateCost]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Recipe_RecalculateCost]
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
/****** Object:  StoredProcedure [dbo].[Recipe_RecalculateCost_Internal]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Recipe_RecalculateCost_Internal]
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
/****** Object:  StoredProcedure [dbo].[Recipe_Save]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Recipe_Save]
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
/****** Object:  StoredProcedure [dbo].[RecipeDetail_Delete]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RecipeDetail_Delete]
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
/****** Object:  StoredProcedure [dbo].[RecipeDetail_GetByRecipeId]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   RECIPE DETAILS
   ========================================================= */

CREATE PROCEDURE [dbo].[RecipeDetail_GetByRecipeId]
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
/****** Object:  StoredProcedure [dbo].[RecipeDetail_Insert]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RecipeDetail_Insert]
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
/****** Object:  StoredProcedure [dbo].[RecipeDetail_Update]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RecipeDetail_Update]
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
/****** Object:  StoredProcedure [dbo].[Unit_Convert]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Unit_Convert]
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
/****** Object:  StoredProcedure [dbo].[Unit_Delete]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Unit_Delete]
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
/****** Object:  StoredProcedure [dbo].[Unit_GetAll]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* =========================================================
   UNITS
   ========================================================= */

CREATE PROCEDURE [dbo].[Unit_GetAll]
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
/****** Object:  StoredProcedure [dbo].[Unit_GetById]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Unit_GetById]
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
/****** Object:  StoredProcedure [dbo].[Unit_Insert]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Unit_Insert]
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
/****** Object:  StoredProcedure [dbo].[Unit_Update]    Script Date: 29/09/2026 03:45:20 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Unit_Update]
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
