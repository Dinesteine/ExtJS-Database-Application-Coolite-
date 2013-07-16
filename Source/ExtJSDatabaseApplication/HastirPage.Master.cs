namespace ExtJSDatabaseApplication
{
    using System;

    public partial class HastirPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.ProtectForms();
          
        }

        public void ProtectForms()
        {
            if (Session["sys"] == null) Response.Redirect("giris.aspx");
        }
    }
}
