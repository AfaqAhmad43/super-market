using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace GoMartApplication.SQL_DB
{
    public partial class frmProductHistory : Form
    {
        DBConnect dbCon = new DBConnect();
        private int? ProductID;
        public frmProductHistory(int? productID = null)
        {
            InitializeComponent();
            ProductID = productID;
        }

        private void frmProductHistory_Load(object sender, EventArgs e)
        {
            BindProductHistory();
        }

        private void BindProductHistory()
        {
            SqlCommand cmd = new SqlCommand("select * from tblProductHistory", dbCon.GetCon());
            dbCon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dbCon.CloseCon();
        }
    }
}
