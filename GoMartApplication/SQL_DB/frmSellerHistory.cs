using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GoMartApplication.SQL_DB
{
    public partial class frmSellerHistory : Form
    {
        DBConnect dbCon = new DBConnect();
        private int SellerID;
        public frmSellerHistory(int sellerID)
        {
            InitializeComponent();
            SellerID = sellerID;
        }

        private void frmSellerHistory_Load(object sender, EventArgs e)
        {
            BindSellerHistory();
        }

        private void BindSellerHistory()
        {
            SqlCommand cmd = new SqlCommand("select * from tblSellerHistory", dbCon.GetCon());
            dbCon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dbCon.CloseCon();
        }
    }
}
