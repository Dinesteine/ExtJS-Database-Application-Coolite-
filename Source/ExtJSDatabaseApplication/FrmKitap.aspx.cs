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

    public partial class FrmKitap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.GetDataS();
                this.KaynagaBagla();
            }
        }

        
        protected void dsKitaplar_RefreshData(object sender, StoreRefreshDataEventArgs e)
        {
            this.KaynagaBagla();
        }




        public void KaynagaBagla()
        {
            dsKitaplar.DataSource = this.GetKitaplar();
            dsKitaplar.DataBind();
        }


        protected DataTable GetKitaplar()
        {
            using (var dtKitaplar = new DataTable())
            {
                using (var cmdGetKitaplar = new SqlCommand())
                {
                    cmdGetKitaplar.CommandText = @"SELECT 
                     (SELECT TURAD FROM TURLER WHERE TURLER.RID=KITAPLAR.TURRID)  TURAD,
                     (SELECT AD+' '+SOYAD FROM YAZARLAR WHERE YAZARLAR.RID=KITAPLAR.YAZARRID) ADSOYAD,
                     (SELECT YAYINEVI FROM YAYINEVLERI WHERE YAYINEVLERI.RID=KITAPLAR.YAYINEVIRID) YAYINEVI,
                    * FROM KITAPLAR ORDER BY RID DESC";
                    using (var Baglanti = new Connection())
                    {
                        cmdGetKitaplar.Connection = Baglanti.ConnectionObj;
                        dtKitaplar.Load(cmdGetKitaplar.ExecuteReader());
                        return dtKitaplar;
                    }
                }
            }
        }


        [AjaxMethod]
        public void GetYazarlar()
        {
            using (var dt = new DataTable())
            {
                using (var cmd = new SqlCommand())
                {
                    using (var Conn = new Connection())
                    {
                        cmd.Connection = Conn.ConnectionObj;
                        cmd.CommandText = "SELECT RID,AD,SOYAD FROM YAZARLAR ORDER BY AD ASC";
                        dt.Load(cmd.ExecuteReader());
                        FYazar.Items.Clear();
                        foreach (DataRow rowItem in dt.Rows)
                            FYazar.Items.Add(new Coolite.Ext.Web.ListItem(rowItem["AD"].ToString() + " " + rowItem["SOYAD"].ToString(), rowItem["RID"].ToString()));
                    }
                }
            }
        }



        [AjaxMethod]
        public void GetTurler(object sender, AjaxEventArgs e)
        {
            using (var dt = new DataTable())
            {
                using (var cmd = new SqlCommand())
                {
                    using (var Conn = new Connection())
                    {
                        cmd.Connection = Conn.ConnectionObj;
                        cmd.CommandText = "SELECT RID,TURAD FROM TURLER ORDER BY TURAD ASC";
                        dt.Load(cmd.ExecuteReader());
                        FTur.Items.Clear();
                        foreach (DataRow rowItem in dt.Rows)
                            FTur.Items.Add(new Coolite.Ext.Web.ListItem(rowItem["TURAD"].ToString(), rowItem["RID"].ToString()));
                    }
                }
            }
        }


        [AjaxMethod]
        public void GetYayinEvleri()
        {
            using (var dt = new DataTable())
            {
                using (var cmd = new SqlCommand())
                {
                    using (var Conn = new Connection())
                    {
                        cmd.Connection = Conn.ConnectionObj;
                        cmd.CommandText = "SELECT RID,YAYINEVI FROM YAYINEVLERI ORDER BY YAYINEVI ASC";
                        dt.Load(cmd.ExecuteReader());
                        FYayinEv.Items.Clear();
                        foreach (DataRow rowItem in dt.Rows)
                            FYayinEv.Items.Add(new Coolite.Ext.Web.ListItem(rowItem["YAYINEVI"].ToString(), rowItem["RID"].ToString()));
                    }
                }
            }
        }


        // Master Tabloların Verileri çekiliyor
        void GetDataS()
        {
            using (var YayinEvleri = new DataTable())
            {
                using (var Turler = new DataTable())
                {
                    using (var yazarlar = new DataTable())
                    {
                        using (var Cmd = new SqlCommand())
                        {
                            using (var Conn = new Connection())
                            {
                                Cmd.Connection = Conn.ConnectionObj;

                                //YAZARLAR(Master tablo) verileri çekiliyor
                                Cmd.CommandText = "SELECT RID,AD,SOYAD FROM YAZARLAR ORDER BY AD ASC";
                                yazarlar.Load(Cmd.ExecuteReader());
                                FYazar.Items.Clear();
                                //FYazar.Items.Add(new Coolite.Ext.Web.ListItem("-Yazar Seçiniz-", "0"));
                                foreach (DataRow rowItem in yazarlar.Rows)
                                    FYazar.Items.Add(new Coolite.Ext.Web.ListItem(rowItem["AD"].ToString() + " " + rowItem["SOYAD"].ToString(), rowItem["RID"].ToString()));


                                //TÜRLER(Master tablo) verileri çekiliyor
                                Cmd.CommandText = "SELECT RID,TURAD FROM TURLER ORDER BY TURAD ASC";
                                Turler.Load(Cmd.ExecuteReader());
                                FTur.Items.Clear();
                                foreach (DataRow rowItem in Turler.Rows)
                                    FTur.Items.Add(new Coolite.Ext.Web.ListItem(rowItem["TURAD"].ToString(), rowItem["RID"].ToString()));

                                
                                //YAYINEVLER(Master tablo) verileri çekiliyor
                                Cmd.CommandText = "SELECT RID,YAYINEVI FROM YAYINEVLERI ORDER BY YAYINEVI ASC";
                                YayinEvleri.Load(Cmd.ExecuteReader());
                                FYayinEv.Items.Clear();
                                //FYayinEv.Items.Add(new Coolite.Ext.Web.ListItem("-Yayın Evi Seçiniz-", "0"));
                                foreach (DataRow rowItem in YayinEvleri.Rows)
                                    FYayinEv.Items.Add(new Coolite.Ext.Web.ListItem(rowItem["YAYINEVI"].ToString(), rowItem["RID"].ToString()));

                            }// Connection bu bloktan sonra yaşamaz. 
                        }
                    }
                }
            }
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
                            CmdGuncelle.CommandText = "UPDATE KITAPLAR SET YAZARRID=@YAZARRID,TURRID=@TURRID,YAYINEVIRID=@YAYINEVIRID,KITAPAD=@KITAPAD,ISBN=@ISBN,SADET=@SADET,BASIMTARIHI=@BASIMTARIHI,KAYITTARIHI=@KAYITTARIHI,BIRIMFIYATI=@BIRIMFIYATI WHERE RID=@RID";
                            CmdGuncelle.Parameters.AddWithValue("@RID", int.Parse(FRID.Text.Trim()));
                            CmdGuncelle.Parameters.AddWithValue("@YAZARRID", int.Parse(FYazar.SelectedItem.Value.Trim()));
                            CmdGuncelle.Parameters.AddWithValue("@TURRID", int.Parse(FTur.SelectedItem.Value.Trim()));
                            CmdGuncelle.Parameters.AddWithValue("@YAYINEVIRID", int.Parse(FYayinEv.SelectedItem.Value.Trim()));
                            CmdGuncelle.Parameters.AddWithValue("@KITAPAD", FKitapAd.Text.Trim());
                            CmdGuncelle.Parameters.AddWithValue("@ISBN", FISBN.Text.Trim());
                            CmdGuncelle.Parameters.AddWithValue("@SADET", int.Parse(FSAdet.Text.Trim()));
                            CmdGuncelle.Parameters.AddWithValue("@BASIMTARIHI", int.Parse(FBasimYili.Text.Trim()));
                            CmdGuncelle.Parameters.AddWithValue("@KAYITTARIHI", FKayitTarihi.SelectedDate);
                            CmdGuncelle.Parameters.AddWithValue("@BIRIMFIYATI", double.Parse(FBirimFiyat.Text.Trim()));
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
       public void Sil(int RID)
        {
            try
            {
                using (var CmdGuncelle = new SqlCommand())
                {
                    using (var Conn = new Connection())
                    {
                        CmdGuncelle.Connection = Conn.ConnectionObj;
                        CmdGuncelle.CommandText = "DELETE FROM KITAPLAR WHERE RID=@RID";
                        CmdGuncelle.Parameters.AddWithValue("@RID", RID);
                        CmdGuncelle.ExecuteNonQuery();
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
           {
               this.Kaydet();
           }
           else
           {
              this.Guncelle();
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
                        CmdKaydet.CommandText = "INSERT INTO KITAPLAR(YAZARRID,TURRID,YAYINEVIRID,KITAPAD,ISBN,SADET,BASIMTARIHI,KAYITTARIHI,BIRIMFIYATI) VALUES(@YAZARRID,@TURRID,@YAYINEVIRID,@KITAPAD,@ISBN,@SADET,@BASIMTARIHI,@KAYITTARIHI,@BIRIMFIYATI)";
                        CmdKaydet.Parameters.AddWithValue("@YAZARRID", int.Parse(FYazar.SelectedItem.Value.Trim()));
                        CmdKaydet.Parameters.AddWithValue("@TURRID", int.Parse(FTur.SelectedItem.Value.Trim()));
                        CmdKaydet.Parameters.AddWithValue("@YAYINEVIRID", int.Parse(FYayinEv.SelectedItem.Value.Trim()));
                        CmdKaydet.Parameters.AddWithValue("@KITAPAD", FKitapAd.Text.Trim());
                        CmdKaydet.Parameters.AddWithValue("@ISBN", FISBN.Text.Trim());
                        CmdKaydet.Parameters.AddWithValue("@SADET", int.Parse(FSAdet.Text.Trim()));
                        CmdKaydet.Parameters.AddWithValue("@BASIMTARIHI", int.Parse(FBasimYili.Text.Trim()));
                        CmdKaydet.Parameters.AddWithValue("@KAYITTARIHI", FKayitTarihi.SelectedDate);
                        CmdKaydet.Parameters.AddWithValue("@BIRIMFIYATI", double.Parse(FBirimFiyat.Text.Trim()));
                        CmdKaydet.ExecuteNonQuery();
                        MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.INFO, Message = "Bilgiler Kaydedilmiştir", Modal = true, Title = "bilgi", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.ApplicationError });
                        MessageBox.Instance.Show();
                    }
                }
            }
            catch(Exception Ex)
            {
                MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.ERROR, Message = Ex.Message.ToString(), Modal = true, Title = "hata !", Buttons = Coolite.Ext.Web.MessageBox.Button.OK, HeaderIcon = Coolite.Ext.Web.Icon.ApplicationError });
                MessageBox.Instance.Show();
            }
        }
    }
}
