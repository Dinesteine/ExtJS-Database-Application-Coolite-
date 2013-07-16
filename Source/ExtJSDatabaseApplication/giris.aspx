<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="giris.aspx.cs" Inherits="ExtJSDatabaseApplication.giris" %>
<%@ Register assembly="Coolite.Ext.Web" namespace="Coolite.Ext.Web" tagprefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>ExtJS Yazılım ARGE Uygulaması Giriş</title>
    <style type="text/css">
      body{
      	background-color:#D4E0F2;
      	margin:0px;
      	vertical-align:middle;
      	font-family:Lucida Sans Unicode;
      	font-size:11px;
      	}
    </style>
    <script language="javascript" type="text/javascript">
       
    </script>
</head>
<body>
<center>
        <form id="form1" runat="server">
             <ext:ScriptManager ID="ScriptManager1" runat="server">
             </ext:ScriptManager>
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

         <ext:FormPanel ID="giriPanel" 
                BodyStyle="padding:5px;" 
                Width="350" 
                AutoHeight="true" 
                runat="server" 
                Title="Sistem Girişi"
                Icon="Lock" 
                LabelAlign="Left"
                LabelSeparator="">
             <Defaults>
                   <ext:Parameter Name="AllowBlank" Value="false" Mode="Raw" />
                   <ext:Parameter Name="MsgTarget" Value="side" />
             </Defaults>
           <Body>
           <ext:FormLayout ID="FormLayout1" runat="server">
                   <ext:Anchor Horizontal="100%" IsFormField="true">
                        <ext:TextField ID="FKullanici" runat="server" FieldLabel="Kullanıcı" Text="sa">
                        </ext:TextField>
                    </ext:Anchor>
                    
                    <ext:Anchor Horizontal="100%" IsFormField="true">
                        <ext:TextField ID="FParola" runat="server" FieldLabel="Parola" InputType="Password" Text="12345">
                        </ext:TextField>
                    </ext:Anchor>
                    
                    <ext:Anchor Horizontal="100%">
                       <ext:MultiField runat="server">
                          <Fields>
                            <ext:Button runat="server" ID="btnGiris" Text="Giriş" Icon="Accept">
                             <Listeners>
                               <Click Handler="#{sbDRM}.showBusy('Kontrol ediliyor...');Coolite.AjaxMethods.Giris();" />
                             </Listeners>
                            </ext:Button>
                            <ext:Button runat="server" ID="btnCikis" Text="İptal" Icon="Decline">
                              <Listeners>
                               <Click Handler="close();" />
                              </Listeners>
                            </ext:Button>
                          </Fields>
                       </ext:MultiField>
                    </ext:Anchor>
           </ext:FormLayout>
           </Body>
           <BottomBar>
             <ext:StatusBar ID="sbDRM" runat="server" Text=" " StatusAlign="Left"></ext:StatusBar>
           </BottomBar>
         </ext:FormPanel>
        </form>
 </center>
</body>
</html>
