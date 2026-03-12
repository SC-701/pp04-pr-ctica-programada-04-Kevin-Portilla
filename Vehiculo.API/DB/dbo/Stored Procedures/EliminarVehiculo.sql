-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE EliminarVehiculo
    @Id uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION
	DELETE FROM Vehiculo WHERE (Id = @Id)

	SELECT @Id
	COMMIT TRANSACTION
END