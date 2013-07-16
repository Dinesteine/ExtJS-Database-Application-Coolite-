using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace ExtJS.Data.Accsess
{
    public class ConnectionString:IDisposable
    {

        public static string Get
        {
            get 
            {
                return ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            }
        }

        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
}
