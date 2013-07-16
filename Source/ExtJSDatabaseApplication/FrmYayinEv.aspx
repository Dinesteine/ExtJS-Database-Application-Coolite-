<%@ Page Language="C#" MasterPageFile="~/HastirPage.Master" AutoEventWireup="true" CodeBehind="FrmYayinEv.aspx.cs" Inherits="ExtJSDatabaseApplication.FrmYayinEv" Title="Yayın Ev Kayıt Formu" %>
<%@ Register assembly="Coolite.Ext.Web" namespace="Coolite.Ext.Web" tagprefix="ext" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <ext:Panel ID="Panel1" runat="server"  Title="YayınEvi Kayıt İşlem Formu"
        Icon="ApplicationForm" BodyStyle="padding:5px;">
        <Body>
          
           <ext:FormPanel ID="FormYayinEvi" runat="server" BodyStyle="padding:5px;" ButtonAlign="Right"
                Frame="false" AutoHeight="true" Title="YayınEvi Kayıt Bilgileri" Width="600">
             <Defaults>
                   <ext:Parameter Name="AllowBlank" Value="false" Mode="Raw" />
                   <ext:Parameter Name="MsgTarget" Value="side" />
             </Defaults>
             
                <Body>
                    <ext:FormLayout ID="FormLayout1" runat="server">
                        <ext:Anchor Horizontal="100%" IsFormField="true">
                            <ext:TextField ID="FRID" runat="server" FieldLabel="Kayıt No" Disabled="true" Hidden="true">
                            </ext:TextField>
                        </ext:Anchor>
                        
                        <ext:Anchor Horizontal="100%" IsFormField="true">
                            <ext:TextField ID="FYayinEvi" runat="server" FieldLabel="Yayın Evi Adı">
                            </ext:TextField>
                        </ext:Anchor>
                        
                        <ext:Anchor Horizontal="100%" IsFormField="true">
                            <ext:TextField ID="FTel" runat="server" FieldLabel="Telefon">
                            </ext:TextField>
                        </ext:Anchor>
                        
                        
                        <ext:Anchor Horizontal="100%" IsFormField="true">
                            <ext:TextField ID="FAdres" runat="server" FieldLabel="Adres">
                            </ext:TextField>
                        </ext:Anchor>
                        
                        <ext:Anchor Horizontal="100%" IsFormField="true">
                            <ext:TextField ID="FMail" runat="server" FieldLabel="Mail Adres">
                            </ext:TextField>
                        </ext:Anchor>
                        
                    </ext:FormLayout>
                </Body>
              <BottomBar>
              
                 <ext:Toolbar ID="Toolbar1" runat="server">
                   <Items>
                     <ext:ToolbarFill></ext:ToolbarFill>
                     
                     <ext:Button ID="btnYeni" runat="server" Text="Yeni" Icon="Add">
                       <Listeners>
                          <Click Handler="#{FormYayinEvi}.getForm().reset(); #{FYayinEvi}.focus();" />
                       </Listeners>
                     </ext:Button>
                     
                     <ext:ToolbarSeparator></ext:ToolbarSeparator>
                     <ext:Button ID="btnKaydet" runat="server" Text="Kaydet" Icon="Disk">
                        <Listeners>
                          <Click Handler="Coolite.AjaxMethods.InsertUpdate();" />
                        </Listeners>
                     </ext:Button>
                    <ext:ToolbarSeparator></ext:ToolbarSeparator>
                     
                     <ext:Button ID="btnKaydetYeni" runat="server" Text="Kaydet+Yeni" Icon="DiskMultiple">
                        <Listeners>
                          <Click Handler="Coolite.AjaxMethods.InsertUpdate(); #{FormYayinEvi}.getForm().reset(); #{FYayinEvi}.focus();" />
                        </Listeners>
                     </ext:Button>
                   </Items>
                 </ext:Toolbar>
                 
              </BottomBar>
            </ext:FormPanel>
        <br />
        
        <!-- Veri Kaynağı Oluşturuluyor (Başlangıç)!-->
        <ext:Store
         ID="dsYayinEvleri"
         runat="server"
         OnRefreshData="dsYayinEvleri_RefreshData">
            <Reader>
                 <ext:JsonReader>
                   <Fields>
                     <ext:RecordField Name="RID"></ext:RecordField>
                     <ext:RecordField Name="YAYINEVI"></ext:RecordField>
                     <ext:RecordField Name="TEL"></ext:RecordField>
                     <ext:RecordField Name="ADRES"></ext:RecordField>
                     <ext:RecordField Name="MAIL"></ext:RecordField>
                   </Fields>
                 </ext:JsonReader>   
            </Reader>
        </ext:Store>
        <!-- Veri Kaynağı Oluşturuluyor (Bitiş)!-->

       
       <!-- Grid Oluşturuluyor (Başlangıç)!-->
           <ext:GridPanel 
                ID="YayinEviGrid" 
                runat="server"
                Height="250"
                Width="750"
                Title="Yayın Evleri Listesi"
                Icon="Application"
                StoreID="dsYayinEvleri"
                Collapsible="true"
                Border="true"
                StripeRows="true" 
                AutoExpandColumn="RID">
                <TopBar>
                      <ext:Toolbar runat="server" ID="tbListe">
                        <Items>
                           <ext:Button runat="server" ID="btnListele" Text="Listele" Icon="ArrowRefresh" OnClientClick="#{YayinEviGrid}.reload();"></ext:Button>
                        </Items>
                      </ext:Toolbar>
                </TopBar>
               
               
               <ColumnModel ID="ColumnModel1" runat="server">
                 <Columns>
                         <ext:RowNumbererColumn/>
                           <ext:CommandColumn  Width="50px" Header="İşlem">
                             <Commands>
                               <ext:GridCommand Icon="Delete" CommandName="cmdSil" ToolTip-Text="Seçili Kaydı Siler" ToolTip-Title="Bilgi"></ext:GridCommand>
                               <ext:CommandSpacer />
                               <ext:GridCommand Icon="DiskEdit" CommandName="cmdDuzelt" ToolTip-Text="aktif Kayıt bilgilerinin düzenler"  ToolTip-Title="bilgi"></ext:GridCommand>
                             </Commands>
                          </ext:CommandColumn>
                  
                   <ext:Column DataIndex="RID"  Header="RID" Hidden="true"></ext:Column>
                   <ext:Column DataIndex="YAYINEVI"  Header="Yayın Evi Adı" Width="300"></ext:Column>
                   <ext:Column DataIndex="TEL"  Header="Telefon" Width="100"></ext:Column>
                   <ext:Column DataIndex="ADRES" Header="Adres" Hidden="true" Width="200"></ext:Column>
                   <ext:Column DataIndex="MAIL" Header="Mail Adresi" Width="200"></ext:Column>
                </Columns>
              </ColumnModel> 
              
                  <Listeners>
                    <Command Handler="if (command=='cmdSil') {Coolite.AjaxMethods.Sil(record.data.RID); #{YayinEviGrid}.deleteSelected(); #{YayinEviGrid}.view.focusEl.focus();} else if(command=='cmdDuzelt'){ #{FRID}.setValue(record.data.RID); #{FYayinEvi}.setValue(record.data.YAYINEVI); #{FTel}.setValue(record.data.TEL); #{FAdres}.setValue(record.data.ADRES); #{FMail}.setValue(record.data.MAIL);}" />
                  </Listeners>
                  <LoadMask ShowMask="true"/>
                  
                  <SelectionModel>
                     <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                         <Listeners>
                         </Listeners>
                     </ext:RowSelectionModel>
                  </SelectionModel>

                  <BottomBar>
                    <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="20" StoreID="dsYayinEvleri"></ext:PagingToolbar>
                  </BottomBar>
                  
           </ext:GridPanel>
       <!-- Grid Oluşturuluyor (Bitiş)!-->

        </Body>
     </ext:Panel>



</asp:Content>
