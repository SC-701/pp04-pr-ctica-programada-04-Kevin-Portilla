-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE EditarVehiculo
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
    UPDATE [dbo].[Vehiculo]
   SET
      [IdModelo] = @IdModelo
      ,[Placa] = @Placa
      ,[Color] = @Color
      ,[Anio] = @Anio
      ,[Precio] = @Precio
      ,[CorreoPropietario] = @CorreoPropietario
      ,[TelefonoPropietario] = @TelefonoPropietario
 WHERE Id=@Id

 SELECT @Id
 COMMIT TRANSACTION
END