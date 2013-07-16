namespace ExtJSDatabaseApplication
{
    using System;
    using System.Data;
    using System.Web.UI;
    using System.Data.SqlClient;
    using ExtJS.Data.Accsess;
    using Coolite.Ext.Web;
    using Coolite.Ext;
    using Coolite.Utilities;

    public partial class FrmYayinEv : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.KaynagaBagla();
            }

        }

        protected void dsYayinEvleri_RefreshData(object sender, StoreRefreshDataEventArgs e)
        {
            this.KaynagaBagla();
        }


        public void KaynagaBagla()
        {
            dsYayinEvleri.DataSource = this.GetYayinEvleri();
            dsYayinEvleri.DataBind();
        }



        protected DataTable GetYayinEvleri()
        {
            using (var dtYayinEvleri = new DataTable())
            {
                using (var cmdGetYayinEvleri = new SqlCommand())
                {
                    cmdGetYayinEvleri.CommandText = "SELECT * FROM YAYINEVLERI ORDER BY RID DESC";
                    using (var Baglanti = new Connection())
                    {
                        cmdGetYayinEvleri.Connection = Baglanti.ConnectionObj;
                        dtYayinEvleri.Load(cmdGetYayinEvleri.ExecuteReader());
                        return dtYayinEvleri;
                    }
                }
            }
        }



        [Coolite.Ext.Web.AjaxMethod]
        public void Sil(int RID)
        {
            try
            {
                using (var CmdSil = new SqlCommand())
                {
                    using (var Conn = new Connection())
                    {
                        CmdSil.Connection = Conn.ConnectionObj;
                        CmdSil.CommandText = "DELETE FROM YAYINEVLERI WHERE RID=@RID";
                        CmdSil.Parameters.AddWithValue("@RID", RID);
                        CmdSil.ExecuteNonQuery();
                        MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.INFO, Message = "Seçili Kayıt Silinmiştir", Modal = true, Title = "bilgi", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.Application });
                        MessageBox.Instance.Show();
                    }
                }
            }
            catch (Exception Ex)
            {
                MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.INFO, Message = Ex.Message, Modal = true, Title = "dikkat", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.Application });
                MessageBox.Instance.Show();
            }
        }

        [Coolite.Ext.Web.AjaxMethod]
        public void InsertUpdate()
        {
            if (FRID.Text.Trim() == string.Empty)
                this.Kaydet();
            else
                this.Guncelle();
        }


        [Coolite.Ext.Web.AjaxMethod]
        public void Guncelle()
        {
            try
            {
                using (var CmdGuncelle = new SqlCommand())
                {
                    using (var Conn = new Connection())
                    {
                        CmdGuncelle.Connection = Conn.ConnectionObj;
                        CmdGuncelle.CommandText = "UPDATE YAYINEVLERI SET YAYINEVI=@YAYINEVI,TEL=@TEL,ADRES=@ADRES,MAIL=@MAIL WHERE RID=@RID";
                        CmdGuncelle.Parameters.AddWithValue("@RID", int.Parse(FRID.Text.Trim()));
                        CmdGuncelle.Parameters.AddWithValue("@YAYINEVI",FYayinEvi.Text.Trim());
                        CmdGuncelle.Parameters.AddWithValue("@TEL", FTel.Text.Trim());
                        CmdGuncelle.Parameters.AddWithValue("@ADRES", FAdres.Text.Trim());
                        CmdGuncelle.Parameters.AddWithValue("@MAIL", FMail.Text.Trim());
                        CmdGuncelle.ExecuteNonQuery();
                        MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.INFO, Message = "Bilgiler Değiştirilmiştir", Modal = true, Title = "bilgi", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.Application });
                        MessageBox.Instance.Show();
                    }
                }
            }
            catch (Exception Ex)
            {
                MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.ERROR, Message = Ex.Message.ToString(), Modal = true, Title = "hata !", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.ApplicationError });
                MessageBox.Instance.Show();
            }
        }


        [Coolite.Ext.Web.AjaxMethod]
        public void Kaydet()
        {
            try
            {
                using (var CmdKaydet = new SqlCommand())
                {
                    using (var Conn = new Connection())
                    {
                        CmdKaydet.Connection = Conn.ConnectionObj;
                        CmdKaydet.CommandText = "INSERT INTO YAYINEVLERI(YAYINEVI,TEL,ADRES,MAIL) VALUES (@YAYINEVI,@TEL,@ADRES,@MAIL)";
                        CmdKaydet.Parameters.AddWithValue("@YAYINEVI",FYayinEvi.Text.Trim());
                        CmdKaydet.Parameters.AddWithValue("@TEL", FTel.Text.Trim());
                        CmdKaydet.Parameters.AddWithValue("@ADRES", FAdres.Text.Trim());
                        CmdKaydet.Parameters.AddWithValue("@MAIL",FMail.Text.Trim());
                        CmdKaydet.ExecuteNonQuery();
                        MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.INFO, Message = "Bilgiler Kaydedilmiştir", Modal = true, Title = "bilgi", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.ApplicationError });
                        MessageBox.Instance.Show();
                    }
                }
            }
            catch (Exception Ex)
            {
                MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.ERROR, Message = Ex.Message.ToString(), Modal = true, Title = "hata !", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.ApplicationError });
                MessageBox.Instance.Show();
            }
        }
    }
}
