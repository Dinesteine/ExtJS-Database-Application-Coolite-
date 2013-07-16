namespace ExtJSDatabaseApplication
{
    using System;
    using System.Collections;
    using System.Configuration;
    using System.Data;
    using System.Linq;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;
    using System.Web.UI.WebControls;
    using System.Web.UI.WebControls.WebParts;
    using System.Xml.Linq;
    using Coolite.Ext.Web;

    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BuildAgac();
            }
            this.ProtectForms();
        }

        public void ProtectForms()
        {
             if (Session["sys"] == null) Response.Redirect("giris.aspx");
        }


        [Coolite.Ext.Web.AjaxMethod]
        public void Cikis()
        {
            Session.Abandon();
            Response.Redirect(HttpContext.Current.Request.RawUrl);
        }


        void BuildAgac()
        {
           
        }
    }
}
