using System;
using Ext.Net;

namespace ExtNet_ParteCinco
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
        }

        protected void storePersonas_ReadData(object sender, StoreReadDataEventArgs e)
        {
            string nombre = e.Parameters["nombre"];
            string apellido = e.Parameters["apellido"];
            string email = e.Parameters["email"];
            string direccion = e.Parameters["direccion"];
            string pais = e.Parameters["pais"];

            int totalRegistros = 0;

            storePersonas.DataSource = PersonaRepositorio.Buscar(nombre, apellido, email, direccion, pais, e.Start, e.Limit, out totalRegistros);
            storePersonas.DataBind();

            e.Total = totalRegistros;
        }
    }
}