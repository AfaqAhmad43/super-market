using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace GoMartApplication
{
    public partial class SellingForm : Form
    {
        DBConnect dbCon = new DBConnect();
        private int SellerID;       // Seller ID of logged-in seller
        double GrandTotal = 0.0;

        public SellingForm(int sellerId)
        {
            InitializeComponent();
            SellerID = sellerId;
        }

        private void SellingForm_Load(object sender, EventArgs e)
        {
            BindCategory();
            lblDate.Text = DateTime.Now.ToShortDateString();
            BindBillList();
        }

        // Bind categories to combo box
        private void BindCategory()
        {
            SqlCommand cmd = new SqlCommand("spGetCategory", dbCon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            dbCon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cmbCategory.DataSource = dt;
            cmbCategory.DisplayMember = "CategoryName";
            cmbCategory.ValueMember = "CatID";
            dbCon.CloseCon();
        }

        // Search products by category
        private void Searched_ProductList()
        {
            SqlCommand cmd = new SqlCommand("spGetAllProductList_SearchByCat", dbCon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProdCatID", cmbCategory.SelectedValue);
            dbCon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView2_Product.DataSource = dt;
            dbCon.CloseCon();
        }

        private void btnRefCat_Click(object sender, EventArgs e) => BindCategory();
        private void button3_Click(object sender, EventArgs e) => Searched_ProductList();

        // Select product from grid
        private void dataGridView2_Product_Click(object sender, EventArgs e)
        {
            try
            {
                txtProdID.Text = dataGridView2_Product.SelectedRows[0].Cells[0].Value.ToString();
                txtProductName.Text = dataGridView2_Product.SelectedRows[0].Cells[1].Value.ToString();
                txtPrice.Text = dataGridView2_Product.SelectedRows[0].Cells[4].Value.ToString();
                txtQty.Clear();
                txtQty.Focus();
            }
            catch { }
        }

        // Add order to grid (local only)
        private void btnAddOrder_Click(object sender, EventArgs e)
        {
            if (txtProdID.Text == "" || txtQty.Text == "")
            {
                MessageBox.Show("Select product and quantity");
                return;
            }

            int prodId = Convert.ToInt32(txtProdID.Text);
            string name = txtProductName.Text;
            decimal price = Convert.ToDecimal(txtPrice.Text);
            int qty = Convert.ToInt32(txtQty.Text);

            dataGridView1_Order.Rows.Add(prodId, name, price, qty);
            GrandTotal += (double)(price * qty);
            lblGrandTot.Text = "Rs. " + GrandTotal;
        }

        // Add bill and details to database
        private void btnAddBill_Details_Click(object sender, EventArgs e)
        {
            if (dataGridView1_Order.Rows.Count == 0)
            {
                MessageBox.Show("No items in bill");
                return;
            }

            int billId;

            // 1️⃣ Insert bill
            using (SqlCommand cmd = new SqlCommand("spInsertBill", dbCon.GetCon()))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SellerID", SellerID);
                cmd.Parameters.AddWithValue("@SellDate", DateTime.Now);

                dbCon.OpenCon();
                billId = Convert.ToInt32(cmd.ExecuteScalar());
                dbCon.CloseCon();
            }

            // 2️⃣ Insert each bill item
            foreach (DataGridViewRow row in dataGridView1_Order.Rows)
            {
                if (row.IsNewRow) continue;

                using (SqlCommand cmd = new SqlCommand("spAddBillItem", dbCon.GetCon()))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Bill_ID", billId);
                    cmd.Parameters.AddWithValue("@ProdID", Convert.ToInt32(row.Cells["ProdID"].Value));
                    cmd.Parameters.AddWithValue("@Quantity", Convert.ToInt32(row.Cells["Quantity"].Value));
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(row.Cells["Price"].Value));

                    dbCon.OpenCon();
                    cmd.ExecuteNonQuery();
                    dbCon.CloseCon();
                }
            }

            MessageBox.Show("Bill saved successfully");

            ClearForm();
            BindBillList();
        }

        private void ClearForm()
        {
            dataGridView1_Order.Rows.Clear();
            txtProdID.Clear();
            txtProductName.Clear();
            txtPrice.Clear();
            txtQty.Clear();
            lblGrandTot.Text = "Rs. 0";
            GrandTotal = 0;
        }

        private void BindBillList()
        {
            using (SqlCommand cmd = new SqlCommand("spGetBillList", dbCon.GetCon()))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
            }
        }
    }
}
