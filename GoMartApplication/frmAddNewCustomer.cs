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
using System.Xml.Linq;

namespace GoMartApplication
{
    public partial class frmAddNewCustomer : Form
    {
        DBConnect dbCon = new DBConnect();
        public frmAddNewCustomer()
        {
            InitializeComponent();
        }

        private void frmAddNewCustomer_Load(object sender, EventArgs e)
        {
            lblCustID.Visible = false;
            btnUpdate.Visible = false;
            btnDelete.Visible = false;
            btnAdd.Visible = true;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtCustName.Text == String.Empty)
            {
                MessageBox.Show("Please Enter Name", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtCustName.Focus();
                return;
            }

        }

        private void txtClear()
        {
            txtCustName.Clear();
            txtPhone.Clear();
            txtEmail.Clear();
            txtAddress.Clear();
        }
    }
}
