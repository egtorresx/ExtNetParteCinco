using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using Newtonsoft.Json;

namespace ExtNet_ParteCinco
{
    public class PersonaRepositorio
    {
        static List<Persona> datos = LeerDatos();

        public static List<Persona> Buscar(string nombres, string apellidos, string correoElectronico, string direccion,
            string pais, int inicio, int totalRegistrosPagina, out int totalRegistros)
        {

            var datosFiltrados =

                datos.Where(x =>
                            (string.IsNullOrEmpty(nombres) || x.Nombre.Contains(nombres)) &&
                            (string.IsNullOrEmpty(apellidos) || x.Apellido.Contains(apellidos)) &&
                            (string.IsNullOrEmpty(correoElectronico) || x.CorreoElectronico.Contains(correoElectronico)) &&
                            (string.IsNullOrEmpty(direccion) || x.Direccion.Contains(direccion)) &&
                            (string.IsNullOrEmpty(pais) || x.Pais.Contains(pais)));

            totalRegistros = datosFiltrados.Count();

            return datosFiltrados.Skip(inicio)
                .Take(totalRegistrosPagina)
                .ToList();
        }

        private static List<Persona> LeerDatos()
        {
            string datosJson = string.Empty;
            string archivoJson = HttpContext.Current.Server.MapPath("~/datos.json");
            using (StreamReader reader = new StreamReader(archivoJson)) 
            {
                datosJson = reader.ReadToEnd();
            }

            return JsonConvert.DeserializeObject<List<Persona>>(datosJson);
        }
    }
}