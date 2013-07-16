using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;

namespace ExtJS.Data.Accsess
{
  public class Connection:IDisposable
    {
      public SqlConnection ConnectionObj = null;

      //constructor
      public Connection()
      {
          this.OpenDB();
      }


      public void OpenDB()
      {
          ConnectionObj = new SqlConnection(ConnectionString.Get);
          ConnectionObj.Open();
      }


      public void CloseDB()
      {
          ConnectionObj.Close();
          ConnectionObj.Dispose();
      }

      ~Connection()
      {
          this.CloseDB();
      }

      //destructor
      public void Dispose()
      {
          GC.SuppressFinalize(this);
      }
    }
}
