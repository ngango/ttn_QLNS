using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace bai1.Controller
{
  public  class DatAcess
    {
     static string constr  = @"Data Source=DESKTOP-DCH69I1\SQLEXPRESS;Initial Catalog=Vidu;Integrated Security=True";
      private static  SqlConnection con = new SqlConnection(constr);
        public  DataTable Query(string sql,params SqlParameter []pr )
        {
            SqlDataAdapter da = null;
            DataTable dt = new DataTable();
            con.Open();
            if (sql.Trim().Contains(' '))
                da = null;
            else
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.CommandType = CommandType.StoredProcedure;
                pr.ToList().ForEach(x => cmd.Parameters.Add(x));
                da = new SqlDataAdapter(cmd);
            }
            da.Fill(dt);
            con.Close();
            return dt;
        }
        public  void NonQuery(string sql,params SqlParameter [] pr)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            if (sql.Trim().Contains(' '))
                cmd.CommandType = CommandType.Text;
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                pr.ToList().ForEach(x => cmd.Parameters.Add(x));
            }
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
