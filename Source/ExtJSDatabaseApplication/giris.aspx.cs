namespace ExtJSDatabaseApplication
{
    using System;
    using Coolite.Ext.Web;
    using Coolite.Utilities;
    using System.Configuration;
    public partial class giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        [Coolite.Ext.Web.AjaxMethod]
        public void Giris()
        {
            string ConfigUser = ConfigurationManager.AppSettings["user"].ToString();
            string ConfigPass = ConfigurationManager.AppSettings["pass"].ToString();

            if (ConfigUser == FKullanici.Text.Trim() && ConfigPass==FParola.Text.Trim())
            {
                Session["sys"] = true;
                Response.Redirect("Main.aspx");
            }
            else
            {
                sbDRM.ShowBusy(string.Empty);
                MessageBox.Instance.Configure(new Coolite.Ext.Web.MessageBox.Config() { Icon = Coolite.Ext.Web.MessageBox.Icon.ERROR, Message = "Kullanıcı Adı Veya Parola Hatalı", Modal = true, Title = "Hata", Buttons = Coolite.Ext.Web.MessageBox.Button.OK });
                MessageBox.Instance.Show();
            }
        }
    }
}
