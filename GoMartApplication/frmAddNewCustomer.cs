using GoMartApplication.SQL_DB;
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
            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("select CustomerName from tblCustomer where CustomerName=@CustomerName", dbCon.GetCon());
                    cmd.Parameters.AddWithValue("@CustomerName", txtCustName.Text);
                    dbCon.OpenCon();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        MessageBox.Show("Customer Name already exist", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        txtClear();
                    }
                    else
                    {
                        cmd = new SqlCommand("spCustomerInsert", dbCon.GetCon());
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustName.Text);
                        cmd.Parameters.AddWithValue("@CustomerPhone", txtPhone.Text);
                        cmd.Parameters.AddWithValue("@CustomerEmail", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@CustomerAddress", txtAddress.Text);
                        cmd.CommandType = CommandType.StoredProcedure;
                        int i = cmd.ExecuteNonQuery();
                        if (i > 0)
                        {
                            MessageBox.Show("Customer Inserted Successfully...", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            txtClear();
                            BindCustomer();
                        }
                    }
                }
                catch (SqlException ex)
                {
                    MessageBox.Show(ex.Message, "Database Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                finally
                {
                    dbCon.CloseCon();
                }
            }

        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            
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

        private void btnUpdate_Click_1(object sender, EventArgs e)
        {
            try
            {
                if (lblCustID.Text == String.Empty)
                {
                    MessageBox.Show("Please select custID", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                    return;
                }
                if (lblCustID.Text == String.Empty)
                {
                    MessageBox.Show("Please Enter Name", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtCustName.Focus();
                    return;
                }
                else if (txtPhone.Text == String.Empty)
                {
                    MessageBox.Show("Please Enter Password", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtPhone.Focus();
                    return;
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("select CustomerName from tblCustomer where CustomerName=@CustomerName", dbCon.GetCon());
                    cmd.Parameters.AddWithValue("@CustomerName", txtCustName.Text);

                    dbCon.OpenCon();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        MessageBox.Show("Customer Name already exist", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        txtClear();
                    }
                    else
                    {
                        cmd = new SqlCommand("spCustomerUpdate", dbCon.GetCon());
                        cmd.Parameters.AddWithValue("@CustomerID", Convert.ToInt32(lblCustID.Text));
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustName.Text);
                        cmd.Parameters.AddWithValue("@CustomerPhone", txtPhone.Text);
                        cmd.Parameters.AddWithValue("@CustomerEmail", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@CustomerAddress", txtAddress.Text);
                        cmd.CommandType = CommandType.StoredProcedure;
                        int i = cmd.ExecuteNonQuery();
                        dbCon.CloseCon();
                        if (i > 0)
                        {
                            MessageBox.Show("customer updated Successfully...", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            txtClear();
                            BindCustomer();
                            btnUpdate.Visible = false;
                            btnDelete.Visible = false;
                            btnAdd.Visible = true;
                            lblCustID.Visible = false;
                        }
                        else
                        {
                            MessageBox.Show("update failed...", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            txtClear();
                        }
                    }
                    dbCon.CloseCon();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnDelete_Click_1(object sender, EventArgs e)
        {
            try
            {
                if (lblCustID.Text == String.Empty)
                {
                    MessageBox.Show("Please select CategoryID", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                if (lblCustID.Text != String.Empty)
                {
                    if (DialogResult.Yes == MessageBox.Show("Do You Want to Delete?", "Confirmation", MessageBoxButtons.YesNo, MessageBoxIcon.Warning))
                    {
                        SqlCommand cmd = new SqlCommand("spCustomerDelete", dbCon.GetCon());
                        cmd.Parameters.AddWithValue("@CustomerID", Convert.ToInt32(lblCustID.Text));
                        cmd.CommandType = CommandType.StoredProcedure;
                        dbCon.OpenCon();
                        int i = cmd.ExecuteNonQuery();
                        if (i > 0)
                        {
                            MessageBox.Show("Seller Deleted Successfully...", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            txtClear();
                            BindCustomer();
                            btnUpdate.Visible = false;
                            btnDelete.Visible = false;
                            btnAdd.Visible = true;
                            lblCustID.Visible = false;
                        }
                        else
                        {
                            MessageBox.Show("Delete failed...", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            txtClear();
                        }
                        dbCon.CloseCon();
                    }

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            
            if (dataGridView1.SelectedRows.Count == 0)
            {
                MessageBox.Show("Please select a customer first.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            
            int customerId;
            bool parsed = int.TryParse(dataGridView1.SelectedRows[0].Cells["CustomerID"].Value.ToString(), out customerId);

            if (!parsed)
            {
                MessageBox.Show("Selected customer ID is invalid.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            
            frmCustomerHistory historyForm = new frmCustomerHistory(customerId);
            historyForm.ShowDialog();
        }
    }
}
