<%@ Page Language="C#" MasterPageFile="~/HastirPage.Master" AutoEventWireup="true" CodeBehind="FrmKitapTur.aspx.cs" Inherits="ExtJSDatabaseApplication.FrmKitapTur" Title="Kitap Tür Kayıt Formu" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <ext:Panel ID="Panel1" runat="server"  Title="Tür Kayıt İşlem Formu"
        Icon="ApplicationForm" BodyStyle="padding:5px;">
        <Body>
          
           <ext:FormPanel ID="FormTur" runat="server" BodyStyle="padding:5px;" ButtonAlign="Right"
                Frame="false"  AutoHeight="true" Title="Tür Kayıt Bilgileri" Width="600">
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
                            <ext:TextField ID="FTurAd" runat="server" FieldLabel="Tür Adı">
                            </ext:TextField>
                        </ext:Anchor>
                        
                        <ext:Anchor Horizontal="100%" IsFormField="true">
                            <ext:TextField ID="FTanim" runat="server" FieldLabel="Tanımı">
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
                          <Click Handler="#{FormTur}.getForm().reset(); #{FTurAd}.focus();" />
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
                          <Click Handler="Coolite.AjaxMethods.InsertUpdate(); #{FormTur}.getForm().reset(); #{FTurAd}.focus();" />
                        </Listeners>
                     </ext:Button>
                   </Items>
                 </ext:Toolbar>
                 
              </BottomBar>
            </ext:FormPanel>
        <br />
        
        <!-- Veri Kaynağı Oluşturuluyor (Başlangıç)!-->
        <ext:Store
         ID="dsTurler"
         runat="server"
         OnRefreshData="dsTurler_RefreshData">
            <Reader>
                 <ext:JsonReader>
                   <Fields>
                     <ext:RecordField Name="RID"></ext:RecordField>
                     <ext:RecordField Name="TURAD"></ext:RecordField>
                     <ext:RecordField Name="TANIM"></ext:RecordField>
                   </Fields>
                 </ext:JsonReader>   
            </Reader>
        </ext:Store>
        <!-- Veri Kaynağı Oluşturuluyor (Bitiş)!-->
       
  

       
       <!-- Grid Oluşturuluyor (Başlangıç)!-->
           <ext:GridPanel 
                ID="TurGrid" 
                runat="server"
                Height="250"
                Width="750"
                Title="Tür Listesi"
                Icon="Application"
                StoreID="dsTurler"
                Collapsible="true"
                Border="true"
                StripeRows="true" 
                AutoExpandColumn="RID">
                <TopBar>
                      <ext:Toolbar runat="server" ID="tbListe">
                        <Items>
                           <ext:ToolbarFill></ext:ToolbarFill>
                           <ext:Button runat="server" ID="btnListele" Text="Listele" Icon="ArrowRefresh" OnClientClick="#{TurGrid}.reload();"></ext:Button>
                        </Items>
                      </ext:Toolbar>
                </TopBar>
               
               
               <ColumnModel ID="ColumnModel1" runat="server">
                 <Columns>
                         <ext:RowNumbererColumn/>
                           <ext:CommandColumn  Width="75" Header="İşlem">
                             <Commands>
                               <ext:GridCommand Icon="Delete" CommandName="cmdSil" ToolTip-Text="Seçili Kaydı Siler" ToolTip-Title="Bilgi"></ext:GridCommand>
                               <ext:CommandSpacer />
                               <ext:GridCommand Icon="DiskEdit" CommandName="cmdDuzelt" ToolTip-Text="aktif Kayıt bilgilerinin düzenler"  ToolTip-Title="bilgi"></ext:GridCommand>
                               <ext:CommandSpacer />
                               <ext:GridCommand Icon="ApplicationGo" CommandName="cmdGetDetay" ToolTip-Text="Tür Ait Kitapları görmek için tıklayın"  ToolTip-Title="bilgi"></ext:GridCommand>
                             </Commands>
                          </ext:CommandColumn>
                  
                   <ext:Column DataIndex="RID"  Header="RID" Hidden="true"></ext:Column>
                   <ext:Column DataIndex="TURAD"  Header="Tür Adı" Width="150"></ext:Column>
                   <ext:Column DataIndex="TANIM"  Header="Tanımı" Width="500"></ext:Column>
                </Columns>
              </ColumnModel> 
              
                  <Listeners>
                    <Command Handler="if (command=='cmdSil') {Coolite.AjaxMethods.Sil(record.data.RID); #{TurGrid}.deleteSelected(); #{TurGrid}.view.focusEl.focus();} else if(command=='cmdDuzelt'){ #{FRID}.setValue(record.data.RID); #{FTurAd}.setValue(record.data.TURAD); #{FTanim}.setValue(record.data.TANIM);} else if (command=='cmdGetDetay') { Coolite.AjaxMethods.GetKitaplarofTur(record.data.RID); #{KitapGrid}.setTitle(record.data.TURAD+' Türüne Ait Kitaplar');}" />
                  </Listeners>
                  <LoadMask ShowMask="true"/>
                  
                  <SelectionModel>
                     <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                         <Listeners>
                         </Listeners>
                     </ext:RowSelectionModel>
                  </SelectionModel>

                  <BottomBar>
                    <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="20" StoreID="dsTurler"></ext:PagingToolbar>
                  </BottomBar>
                  
           </ext:GridPanel>
       <!-- Grid Oluşturuluyor (Bitiş)!-->
       
       
       
       
       
       
             <!-- Veri Kaynağı Oluşturuluyor (Başlangıç)! Detay Kaynak-->
        <ext:Store
         ID="dsKitaplar"
         runat="server">
            <Reader>
                 <ext:JsonReader>
                   <Fields>
                       <ext:RecordField Name="RID"/>
                       <ext:RecordField Name="YAZARRID"/>
                       <ext:RecordField Name="TURRID"/>
                       <ext:RecordField Name="YAYINEVIRID"/>
                       <ext:RecordField Name="ADSOYAD"/>
                       <ext:RecordField Name="YAYINEVI"/>
                       <ext:RecordField Name="TURAD"/>
                       <ext:RecordField Name="KITAPAD"/>
                       <ext:RecordField Name="ISBN"/>
                       <ext:RecordField Name="SADET"/>
                       <ext:RecordField Name="BASIMTARIHI"/>
                       <ext:RecordField Name="KAYITTARIHI" Type="Date"/>
                       <ext:RecordField Name="BIRIMFIYATI" Type="Float"/>
                   </Fields>
                 </ext:JsonReader>   
            </Reader>
        </ext:Store>
        <!-- Veri Kaynağı Oluşturuluyor (Bitiş)!-->
        
        
        <br />
         <!-- Grid Oluşturuluyor !-->
            <ext:GridPanel 
                ID="KitapGrid" 
                runat="server"
                Height="150"
                Width="750"
                Title=" "
                Icon="Application"
                StoreID="dsKitaplar"
                Border="true"
                StripeRows="true" 
                ClicksToEdit="1"
                AutoExpandColumn="RID">
              
              <ColumnModel ID="ColumnModel2" runat="server">
                 <Columns>
                         <ext:RowNumbererColumn/>
                           <ext:Column DataIndex="RID"  Header="RID" Hidden="true"></ext:Column>
                           <ext:Column DataIndex="KITAPAD"  Header="Kitap Adı"></ext:Column>
                           <ext:Column DataIndex="YAZARRID"  Header="Yazar" Hidden="true"></ext:Column>
                           <ext:Column DataIndex="TURRID"  Header="Türü" Hidden="true"></ext:Column>
                           <ext:Column DataIndex="YAYINEVIRID"  Header="Yayın Evi" Hidden="true"></ext:Column>
                           <ext:Column DataIndex="ADSOYAD"  Header="Yazarı"></ext:Column>
                           <ext:Column DataIndex="TURAD"  Header="Türü"></ext:Column>
                           <ext:Column DataIndex="YAYINEVI"  Header="Yayın Evi"></ext:Column>
                           <ext:Column DataIndex="ISBN"  Header="ISBN"></ext:Column>
                           <ext:Column DataIndex="SADET"  Header="Adet" Width="40"></ext:Column>
                           <ext:Column DataIndex="BASIMTARIHI"  Header="Basım Yılı" Width="75"></ext:Column>
                           <ext:Column DataIndex="KAYITTARIHI"  Header="Kayıt Tarihi" Width="75">
                             <Renderer Fn="Ext.util.Format.dateRenderer('d.m.Y')" />
                           </ext:Column>
                           <ext:Column DataIndex="BIRIMFIYATI"  Header="Fiyatı"></ext:Column>
                </Columns>
              </ColumnModel>


              <LoadMask ShowMask="true"/>
              
              <SelectionModel>
                 <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true">
                   <Listeners>
                   </Listeners>
                 </ext:RowSelectionModel>
              </SelectionModel>

              <BottomBar>
                <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="20" StoreID="dsKitaplar"></ext:PagingToolbar>
              </BottomBar>
              
            </ext:GridPanel>
     <!-- Grid Oluşturuluyor !-->
     

        </Body>
     </ext:Panel>

</asp:Content>
