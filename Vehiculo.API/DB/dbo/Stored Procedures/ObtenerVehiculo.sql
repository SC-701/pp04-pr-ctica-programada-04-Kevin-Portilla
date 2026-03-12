-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE ObtenerVehiculo
    @Id uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;

    SELECT        Vehiculo.Id, Vehiculo.Placa, Vehiculo.IdModelo, Vehiculo.Color, Vehiculo.Anio, Vehiculo.Precio, Vehiculo.CorreoPropietario, Vehiculo.TelefonoPropietario, Modelos.Nombre AS Modelo, Marcas.Nombre AS Marca
FROM            Marcas INNER JOIN
                         Modelos ON Marcas.Id = Modelos.IdMarca INNER JOIN
                         Vehiculo ON Modelos.Id = Vehiculo.IdModelo
WHERE        (Vehiculo.Id = @Id)
END