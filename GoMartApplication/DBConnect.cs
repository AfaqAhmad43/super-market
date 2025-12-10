using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace GoMartApplication
{
    class DBConnect
    {
        private SqlConnection con = new SqlConnection(@"data source=DESKTOP-8B4GOKA\SQLEXPRESS;initial catalog=GoMartDB;trusted_connection=true");
        public SqlConnection GetCon()
        {
            return con;
        }
        public void OpenCon()
        {
            if(con.State==ConnectionState.Closed)
            {
                con.Open();
            }
        }

        public void CloseCon()
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
}
