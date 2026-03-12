-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE AgregarVehiculo
            @Id AS uniqueidentifier
           ,@IdModelo AS uniqueidentifier
           ,@Placa AS varchar(MAX)
           ,@Color AS varchar(MAX)
           ,@Anio AS int
           ,@Precio AS decimal(18,0)
           ,@CorreoPropietario AS varchar(MAX)
           ,@TelefonoPropietario AS varchar(MAX)
AS
BEGIN
	SET NOCOUNT ON;

    BEGIN TRANSACTION
INSERT INTO [dbo].[Vehiculo]
           ([Id]
           ,[IdModelo]
           ,[Placa]
           ,[Color]
           ,[Anio]
           ,[Precio]
           ,[CorreoPropietario]
           ,[TelefonoPropietario])
     VALUES
           (@Id
           ,@IdModelo 
           ,@Placa
           ,@Color
           ,@Anio
           ,@Precio
           ,@CorreoPropietario
           ,@TelefonoPropietario)

    SELECT @Id
    COMMIT TRANSACTION
END