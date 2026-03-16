using Abstracciones.Interfaces.Reglas;
using Abstracciones.Modelos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Reglas;
using System.Text.Json;

namespace Web.Pages.Seguridad
{
    public class RegistroModel : PageModel
    {
        [BindProperty]
        public Usuario usuario { get; set; } = new Usuario();

        public string MensajeDebug { get; set; } = string.Empty;

        private readonly IConfiguracion _configuracion;

        public RegistroModel(IConfiguracion configuracion)
        {
            _configuracion = configuracion;
        }

        public void OnGet()
        {
        }

        public async Task<IActionResult> OnPost()
        {
            MensajeDebug = "Entró al OnPost.";

            try
            {
                if (!ModelState.IsValid)
                {
                    var errores = new List<string>();

                    foreach (var item in ModelState)
                    {
                        foreach (var error in item.Value.Errors)
                        {
                            string mensaje = $"Campo: {item.Key} - Error: {error.ErrorMessage}";
                            errores.Add(mensaje);
                            Console.WriteLine(mensaje);
                        }
                    }

                    MensajeDebug = errores.Count > 0
                        ? string.Join(" | ", errores)
                        : "ModelState inválido, pero no se encontraron mensajes de error.";

                    return Page();
                }

                if (usuario == null)
                {
                    MensajeDebug = "El objeto usuario llegó null.";
                    ModelState.AddModelError(string.Empty, "El usuario no fue enviado correctamente.");
                    return Page();
                }

                Console.WriteLine("NombreUsuario: " + usuario.NombreUsuario);
                Console.WriteLine("CorreoElectronico: " + usuario.CorreoElectronico);

                var hash = Autenticacion.GenerarHash(usuario.Password);
                usuario.PasswordHash = Autenticacion.ObtenerHash(hash);

                Console.WriteLine("PasswordHash generado correctamente.");

                string endpoint = _configuracion.ObtenerMetodo("ApiEndPointsSeguridad", "Registro");
                Console.WriteLine("Endpoint Registro: " + endpoint);

                using var cliente = new HttpClient();

                var respuesta = await cliente.PostAsJsonAsync<UsuarioBase>(endpoint, usuario);

                var contenido = await respuesta.Content.ReadAsStringAsync();

                Console.WriteLine("StatusCode: " + respuesta.StatusCode);
                Console.WriteLine("Respuesta API: " + contenido);

                if (!respuesta.IsSuccessStatusCode)
                {
                    MensajeDebug = $"API respondió {(int)respuesta.StatusCode} - {respuesta.StatusCode}. Contenido: {contenido}";
                    ModelState.AddModelError(string.Empty, $"No se pudo registrar el usuario. Respuesta API: {contenido}");
                    return Page();
                }

                MensajeDebug = "Registro exitoso.";
                return RedirectToPage("/Index");
            }
            catch (Exception ex)
            {
                Console.WriteLine("EXCEPCIÓN EN REGISTRO:");
                Console.WriteLine(ex.ToString());

                MensajeDebug = $"Excepción: {ex.Message}";
                ModelState.AddModelError(string.Empty, $"Ocurrió un error: {ex.Message}");
                return Page();
            }
        }
    }
}