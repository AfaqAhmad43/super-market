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
    public partial class frmCustomerHistory : Form
    {
        DBConnect dbCon = new DBConnect();
        private int CustomerID;
        
        public frmCustomerHistory(int customerID)
        {
            InitializeComponent();
            CustomerID = customerID;
        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void frmCustomerHistory_Load(object sender, EventArgs e)
        {
            BindCustomerHistory();
        }

        private void BindCustomerHistory()
        {
            SqlCommand cmd = new SqlCommand("select * from tblCustomerHistory", dbCon.GetCon());
            dbCon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            dbCon.CloseCon();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
