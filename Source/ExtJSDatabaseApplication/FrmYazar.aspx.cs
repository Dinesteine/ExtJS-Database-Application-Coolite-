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

    public partial class FrmYazar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.KaynagaBagla();
            }
        }


        [Coolite.Ext.Web.AjaxMethod]
        public void GetKitaplarofYazar(int YazarRID)
        {
            using (var dtKitaplar = new DataTable())
            {
                using (var cmdGetKitaplar = new SqlCommand())
                {
                    cmdGetKitaplar.CommandText = @"SELECT 
                     (SELECT TURAD FROM TURLER WHERE TURLER.RID=KITAPLAR.TURRID)  TURAD,
                     (SELECT AD+' '+SOYAD FROM YAZARLAR WHERE YAZARLAR.RID=KITAPLAR.YAZARRID) ADSOYAD,
                     (SELECT YAYINEVI FROM YAYINEVLERI WHERE YAYINEVLERI.RID=KITAPLAR.YAYINEVIRID) YAYINEVI,
                    * FROM KITAPLAR WHERE YAZARRID="+YazarRID.ToString()+" ORDER BY RID DESC";
                    using (var Baglanti = new Connection())
                    {
                        cmdGetKitaplar.Connection = Baglanti.ConnectionObj;
                        dtKitaplar.Load(cmdGetKitaplar.ExecuteReader());
                    }
                }
                dsKitaplar.DataSource = dtKitaplar;
                dsKitaplar.DataBind();
            }
        }


        protected void dsYazarlar_RefreshData(object sender, StoreRefreshDataEventArgs e)
        {
            this.KaynagaBagla();
        }


        public void KaynagaBagla()
        {
            dsYazarlar.DataSource = this.GetYazarlar();
            dsYazarlar.DataBind();
        }



        protected DataTable GetYazarlar()
        {
            using (var dtYazarlar = new DataTable())
            {
                using (var cmdGetYazarlar = new SqlCommand())
                {
                    cmdGetYazarlar.CommandText = "SELECT * FROM YAZARLAR ORDER BY RID DESC";
                    using (var Baglanti = new Connection())
                    {
                        cmdGetYazarlar.Connection = Baglanti.ConnectionObj;
                        dtYazarlar.Load(cmdGetYazarlar.ExecuteReader());
                        return dtYazarlar;
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
                        CmdSil.CommandText = "DELETE FROM YAZARLAR WHERE RID=@RID";
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
                        CmdGuncelle.CommandText = "UPDATE YAZARLAR SET AD=@AD,SOYAD=@SOYAD,HAKKINDA=@HAKKINDA WHERE RID=@RID";
                        CmdGuncelle.Parameters.AddWithValue("@RID", int.Parse(FRID.Text.Trim()));
                        CmdGuncelle.Parameters.AddWithValue("@AD", FAd.Text.Trim());
                        CmdGuncelle.Parameters.AddWithValue("@SOYAD", FSoyad.Text.Trim());
                        CmdGuncelle.Parameters.AddWithValue("@HAKKINDA", FHakkinda.Text.Trim());
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
                        CmdKaydet.CommandText = "INSERT INTO YAZARLAR(AD,SOYAD,HAKKINDA) VALUES (@AD,@SOYAD,@HAKKINDA)";
                        CmdKaydet.Parameters.AddWithValue("@AD", FAd.Text.Trim());
                        CmdKaydet.Parameters.AddWithValue("@SOYAD", FSoyad.Text.Trim());
                        CmdKaydet.Parameters.AddWithValue("@HAKKINDA", FHakkinda.Text.Trim());
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
