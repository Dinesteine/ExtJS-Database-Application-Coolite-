<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="ExtJSDatabaseApplication.Main" %>
<%@ Register assembly="Coolite.Ext.Web" namespace="Coolite.Ext.Web" tagprefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>ExtJS YazılımARGE Uygulaması</title>
    <link href="css/main.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        //Tab Ekleme Fonksiyonu
        function addTab(tabPanel, id, url,titlex) {
            var tab = tabPanel.getComponent(id);
            if (!tab) {
                tab = tabPanel.add({ 
                    id: id, 
                    title: titlex, 
                    closable:true,                 
                    autoLoad: {
                        showMask: true,
                        url: url,
                        mode:'iframe',
                        maskMsg: titlex + ' Yükleniyor...'
                    }                    
                });
            }
            tabPanel.setActiveTab(tab);
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">

         <ext:ScriptManager ID="ScriptManager1" runat="server">
         </ext:ScriptManager>
         
            <ext:ViewPort ID="ViewPort1" runat="server">
                <Body>
                        <ext:BorderLayout ID="BorderLayout1" runat="server">
                            <North Margins-Bottom="5">
                                <ext:Panel ID="header" IDMode="Ignore" runat="server" Header="false" Border="false" Html="<div id='header'><h1>ExtJS YazılımARGE Uygulaması</h1></div>" />
                            </North>
                            
                            <West Collapsible="true" MinWidth="225" Split="true" AnimFloat="true" UseSplitTips="true">
                                <ext:Panel ID="Panel1" runat="server" Width="225" Title="İşlem Ağacı" Icon="ApplicationHome"  Draggable="true">
                                  <TopBar>
                                    <ext:Toolbar runat="server">
                                       <Items>
                                         <ext:Button ID="btnCikis" runat="server" Icon="Cancel" Text="Defolup Gidiyorum">
                                          <Listeners>
                                            <Click Handler="Coolite.AjaxMethods.Cikis()" />
                                          </Listeners>
                                         </ext:Button>
                                       </Items>
                                    </ext:Toolbar>
                                  </TopBar>
                                  
                                  
                                  <BottomBar>
                                    <ext:StatusBar ID="durum"  Text="" runat="server"></ext:StatusBar>
                                  </BottomBar>
                                  
                                  <Body>
                                            <ext:TreePanel runat="server"
                                              ID="agac" 
                                              RootVisible="true"
                                              ContainerScroll="true"
                                              AutoScroll="true"
                                              Border="false" >
                                              <LoadMask ShowMask="true"  Msg="Building..."/>
                                               <TopBar>
                                                    <ext:Toolbar ID="ToolBar1" runat="server">
                                                        <Items>
                                                            <ext:Button ID="Button1" runat="server" Text="Düğümleri Aç" IconCls="icon-expand-all">
                                                                <Listeners>
                                                                    <Click Handler="#{agac}.expandAll();" />
                                                                </Listeners>
                                                            </ext:Button>
                                                            <ext:Button ID="Button2" runat="server" Text="Düğümleri Kapa" IconCls="icon-collapse-all">
                                                                <Listeners>
                                                                    <Click Handler="#{agac}.collapseAll();" />
                                                                </Listeners>
                                                            </ext:Button>
                                                        </Items>
                                                    </ext:Toolbar>
                                                </TopBar>
                      
                                        


                                              <Root>   
                                                   <ext:TreeNode Text="Gavur Düğümü :)" Expanded="true" Icon="Application">
                                                       <Nodes>
                                                             <ext:TreeNode Text="Başlıyoruz"  Icon="Application">
                                                                 <Nodes>
                                                                    <ext:TreeNode Text="Önsöz" Icon="Note"><Listeners><Click Handler="addTab(#{TabFrame}, 'idOnsoz', 'Onsoz.aspx','ÖnSöz');" /></Listeners></ext:TreeNode>
                                                                    <ext:TreeNode Text="VeriTabanı Diagramı" Icon="DatabaseYellow"><Listeners><Click Handler="addTab(#{TabFrame}, 'idVtDiag', 'DatabaseDiagram.aspx','VeriTabanı Diagramı');" /></Listeners></ext:TreeNode>
                                                                 </Nodes>
                                                             </ext:TreeNode>
                                                       </Nodes>
                                                      
                                                       <Nodes>
                                                             <ext:TreeNode Text="Tanımlar" Icon="Application">
                                                                <Nodes>
                                                                  <ext:TreeNode Text="Yazar Tanımları" Icon="ApplicationForm"><Listeners><Click Handler="addTab(#{TabFrame}, 'idFrmYazar', 'FrmYazar.aspx','Yazar Kayıt Formu');" /></Listeners></ext:TreeNode>
                                                                  <ext:TreeNode Text="Yayın Evi Tanımları" Icon="ApplicationForm"><Listeners><Click Handler="addTab(#{TabFrame}, 'idYayinEv', 'FrmYayinEv.aspx','Yayın Evi Kayıt Formu');" /></Listeners></ext:TreeNode>
                                                                  <ext:TreeNode Text="Tür Tanımları" Icon="ApplicationForm"><Listeners><Click Handler="addTab(#{TabFrame}, 'idFrmKitapTur', 'FrmKitapTur.aspx','Tür Kayıt Formu');" /></Listeners></ext:TreeNode>
                                                                </Nodes>
                                                             </ext:TreeNode>
                                                             
                                                             <ext:TreeNode Text="İşlemler" Icon="Application">
                                                                <Nodes>
                                                                  <ext:TreeNode Text="Kitap Kayıt Formu" Icon="ApplicationForm"><Listeners><Click Handler="addTab(#{TabFrame}, 'idFrmKitap', 'FrmKitap.aspx','Kitap Kayıt Formu');" /></Listeners></ext:TreeNode>
                                                                  <ext:TreeNode Text="Sorgula" Icon="ApplicationLightning"></ext:TreeNode>
                                                                </Nodes>
                                                             </ext:TreeNode>

                                                             
                                                             
                                                             
                                                       </Nodes>
                                                   </ext:TreeNode>              
                                              </Root>
                                              

                                              
                                               <Listeners>
                                                    <Click Handler="#{durum}.setStatus({text: 'Düğüm Seçildi: <b>' + node.text + '</b>', clear: true});" />
                                                    <ExpandNode Handler="#{durum}.setStatus({text: 'Düğüm Açıldı: <b>' + node.text + '</b>', clear: true});" Delay="30" />
                                                    <CollapseNode  Handler="#{durum}.setStatus({text: 'Düğüm Kapandı: <b>' + node.text + '</b>', clear: true});" />
                                               </Listeners>

                                            </ext:TreePanel>
                                  </Body>
                                </ext:Panel>
                            </West>
                            <Center>
                                <ext:TabPanel ID="TabFrame" Draggable="true" runat="server" ActiveTabIndex="0" BodyStyle="padding:5px;">
                                <BottomBar>
                                 <ext:StatusBar ID="TabDurum" Text="" runat="server"></ext:StatusBar>
                                </BottomBar>
                                <TopBar>
                                  <ext:Toolbar runat="server">
                                    <Items>
                                       <ext:ToolbarFill></ext:ToolbarFill>
                                       
                                       <ext:ToolbarButton Icon="Decline" Text="Kapat">
                                         <Listeners>
                                           <Click Handler="#{TabFrame}.closeTab(#{TabFrame}.activeTab);" />
                                         </Listeners>
                                       </ext:ToolbarButton>
                                    </Items>
                                  </ext:Toolbar>
                                </TopBar>
                                    <Tabs>
                                        <ext:Tab 
                                            ID="idOnsoz" 
                                            runat="server" 
                                            Title="ÖnSöz" 
                                            Closable="true"
                                            Icon="Application">
                                            <Body></Body>
                                            <AutoLoad Url="Onsoz.aspx" Mode="IFrame" ShowMask="true"></AutoLoad>
                                        </ext:Tab>
                                    </Tabs>
                                </ext:TabPanel>
                            </Center>
                            <South>
                               <ext:StatusBar runat="server" Icon="Coolite" Text="ExtJS Yazılım ARGE uygulaması 2010 - Bu uygulamanın yazılımı ve tasarımı ismail kocacan tarafından yapılmıştır."></ext:StatusBar>
                            </South>
                        </ext:BorderLayout>
             </Body>
            </ext:ViewPort>
 
    </form>
    
</body>
</html>
