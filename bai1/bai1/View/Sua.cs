using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using bai1.Controller;

namespace bai1
{
  
    public partial class ThemSuaXoa : Form
    {
        public ThemSuaXoa()
        {
            InitializeComponent();
           
        }
        DatAcess dulieu = new DatAcess();
        private void textBox3_TextChanged(object sender, EventArgs e)
        {
 
        }
      
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.DataSource = dulieu.Query("select *from ttn_QLNS");
            if(dataGridView1.CurrentRow != null)
            {
                txtma.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[0].Value.ToString();
                txtten.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[1].Value.ToString();
                txtdiachi.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[2].Value.ToString();
                txtquequan.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[3].Value.ToString();
                dataTP.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[4].Value.ToString();
              // gioi tinh  t.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[5].Value.ToString();
                txtsocmnd.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[6].Value.ToString();
                txtdienthoai.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[7].Value.ToString();
                txtemali.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[8].Value.ToString();
                txtloainv.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[9].Value.ToString();
                cbbmachucvu.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[10].Value.ToString();
                cbbmaluong.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[11].Value.ToString();
                cbbmaphongban.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[12].Value.ToString();
                cbbmatdhv.Text = dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[13].Value.ToString();
              
            }
        }
    }
}
