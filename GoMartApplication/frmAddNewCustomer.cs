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
            BindCustomer();
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtCustName.Text == String.Empty)
            {
                MessageBox.Show("Please Enter Name", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtCustName.Focus();
                return;
            }
            else if (txtPhone.Text == String.Empty)
            {
                MessageBox.Show("Please Enter Customer Phone", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtPhone.Focus();
                return;
            }

            try
            {
                SqlCommand cmd = new SqlCommand("spCustomerInsert", dbCon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerName", txtCustName.Text);
                cmd.Parameters.AddWithValue("@CustomerPhone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@CustomerEmail", txtEmail.Text);
                cmd.Parameters.AddWithValue("@CustomerAddress", txtAddress.Text);

                dbCon.OpenCon();
                int i = cmd.ExecuteNonQuery();
                dbCon.CloseCon();

                if (i > 0)
                {
                    MessageBox.Show("Customer Inserted Successfully", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtClear();
                    BindCustomer();
                }
                else
                {
                    MessageBox.Show("Insert failed. Check console or procedure messages.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "Database Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (lblCustID.Text == String.Empty)
            {
                MessageBox.Show("Please select CustomerID", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                SqlCommand cmd = new SqlCommand("spCustomerUpdate", dbCon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerID", Convert.ToInt32(lblCustID.Text));
                cmd.Parameters.AddWithValue("@CustomerName", txtCustName.Text);
                cmd.Parameters.AddWithValue("@CustomerPhone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@CustomerEmail", txtEmail.Text);
                cmd.Parameters.AddWithValue("@CustomerAddress", txtAddress.Text);

                dbCon.OpenCon();
                int i = cmd.ExecuteNonQuery();
                dbCon.CloseCon();

                if (i > 0)
                {
                    MessageBox.Show("Customer Updated Successfully", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtClear();
                    BindCustomer();
                    btnUpdate.Visible = false;
                    btnDelete.Visible = false;
                    btnAdd.Visible = true;
                    lblCustID.Visible = false;
                }
                else
                {
                    MessageBox.Show("Update failed. Check procedure messages.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "Database Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (lblCustID.Text == String.Empty)
            {
                MessageBox.Show("Please select CustomerID", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (DialogResult.Yes == MessageBox.Show("Do you want to delete?", "Confirmation", MessageBoxButtons.YesNo, MessageBoxIcon.Warning))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spCustomerDelete", dbCon.GetCon());
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CustomerID", Convert.ToInt32(lblCustID.Text));

                    dbCon.OpenCon();
                    int i = cmd.ExecuteNonQuery();
                    dbCon.CloseCon();

                    if (i > 0)
                    {
                        MessageBox.Show("Customer Deleted Successfully", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        txtClear();
                        BindCustomer();
                        btnUpdate.Visible = false;
                        btnDelete.Visible = false;
                        btnAdd.Visible = true;
                        lblCustID.Visible = false;
                    }
                    else
                    {
                        MessageBox.Show("Delete failed. Check procedure messages.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                }
                catch (SqlException ex)
                {
                    MessageBox.Show(ex.Message, "Database Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void txtClear()
        {
            txtCustName.Clear();
            txtPhone.Clear();
            txtEmail.Clear();
            txtAddress.Clear();
        }

        private void BindCustomer()
        {
            SqlCommand cmd = new SqlCommand("select * from tblCustomer", dbCon.GetCon());
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

        private void dataGridView1_Click(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                btnUpdate.Visible = true;
                btnDelete.Visible = true;
                btnAdd.Visible = false;
                lblCustID.Visible = true;

                lblCustID.Text = dataGridView1.SelectedRows[0].Cells[0].Value.ToString();
                txtCustName.Text = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                txtPhone.Text = dataGridView1.SelectedRows[0].Cells[2].Value.ToString();
                txtEmail.Text = dataGridView1.SelectedRows[0].Cells[3].Value.ToString();
                txtAddress.Text = dataGridView1.SelectedRows[0].Cells[4].Value.ToString();
            }
        }
    }
}
