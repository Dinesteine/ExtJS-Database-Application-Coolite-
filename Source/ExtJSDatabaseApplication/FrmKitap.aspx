<%@ Page Language="C#" MasterPageFile="~/HastirPage.Master" AutoEventWireup="true" CodeBehind="FrmKitap.aspx.cs" Inherits="ExtJSDatabaseApplication.FrmKitap" Title="Kitap Kayıt Formu" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        
    <ext:Panel ID="Panel1" runat="server"  Title="Kitap Kayıt İşlem formu"
        Icon="ApplicationForm" BodyStyle="padding:5px;">
        <Body >
            

            <ext:FormPanel ID="FormKitap" runat="server" BodyStyle="padding:5px;" ButtonAlign="Right"
                Frame="false" AutoHeight="true" Title="Kitap Kayıt Bilgileri" Width="600" Icon="Application">
             <Defaults>
                   <ext:Parameter Name="AllowBlank" Value="false" Mode="Raw" />
                   <ext:Parameter Name="MsgTarget" Value="side" />
             </Defaults>
             
                <Body>
                    <ext:FormLayout ID="FormLayout1" runat="server">
                        <ext:Anchor Horizontal="100%">
                            <ext:TextField ID="FRID" runat="server" FieldLabel="Kayıt No" Disabled="true" Hidden="true">
                            </ext:TextField>
                        </ext:Anchor>
                        
                        <ext:Anchor Horizontal="100%">
                            <ext:TextField ID="FKitapAd" runat="server" FieldLabel="Kitap Adı">
                            </ext:TextField>
                        </ext:Anchor>
                        
                        <ext:Anchor Horizontal="100%">
                          <ext:MultiField runat="server" FieldLabel="Yazar ">
                            <Fields>
                                <ext:ComboBox 
                                    runat="server" 
                                    ID="FYazar" 
                                    FieldLabel="Yazar" 
                                    EmptyText="Yazar Seçiniz"
                                    SelectOnFocus="true"
                                    Width="450">
                                </ext:ComboBox>
                                
                               <ext:Button runat="server" ID="btnYenileYazarlar" Icon="ArrowRefreshSmall">
                                <Listeners>
                                  <Click Handler="Coolite.AjaxMethods.GetYazarlar();" />
                                </Listeners>
                               </ext:Button>
                            </Fields>
                          </ext:MultiField>
                        </ext:Anchor>
                        
                        
                        
                        <ext:Anchor Horizontal="100%">
                          <ext:MultiField runat="server" FieldLabel="Türü">
                             <Fields>
                                      <ext:ComboBox 
                                        runat="server" 
                                        ID="FTur" 
                                        EmptyText="Tür Seçiniz"
                                        SelectOnFocus="true"
                                        Width="450">
                                    </ext:ComboBox>
                                     <ext:Button runat="server" ID="btnYenileTurler" Icon="ArrowRefreshSmall">
                                       <Listeners>
                                         <Click Handler="Coolite.AjaxMethods.GetTurler();"/>
                                       </Listeners>
                                     </ext:Button>
                             </Fields>
                          </ext:MultiField>
                        </ext:Anchor>
                        
                        <ext:Anchor Horizontal="100%">
                          <ext:MultiField runat="server" FieldLabel="Yayın Evi">
                             <Fields>
                                    <ext:ComboBox 
                                        runat="server" 
                                        ID="FYayinEv" 
                                        FieldLabel="Yayın Evi" 
                                        EmptyText="Yayın Evi Seçiniz"
                                        SelectOnFocus="true"
                                        Width="450">
                                    </ext:ComboBox>
                                    <ext:Button runat="server" ID="btnYenileYayEv" Icon="ArrowRefreshSmall"> 
                                     <Listeners>
                                       <Click Handler="Coolite.AjaxMethods.GetYayinEvleri();" />
                                     </Listeners>
                                    </ext:Button>
                             </Fields>
                          </ext:MultiField>
                        </ext:Anchor>
                        
                        
                        <ext:Anchor Horizontal="100%">
                           <ext:MultiField runat="server" FieldLabel="ISBN- Sayfa S.">
                              <Fields>
                                    <ext:TextField runat="server" ID="FISBN" Width="400"></ext:TextField>
                                    <ext:NumberField runat="server" ID="FSAdet" Width="75" ></ext:NumberField>
                              </Fields>
                           </ext:MultiField>
                        </ext:Anchor>
    
                        
                        <ext:Anchor Horizontal="100%">
                           <ext:MultiField runat="server" FieldLabel="B. Yılı / K.Tarihi">
                             <Fields>
                               <ext:NumberField runat="server" ID="FBasimYili" Width="75"></ext:NumberField>
                               <ext:DateField runat="server" ID="FKayitTarihi" Width="400"></ext:DateField>
                             </Fields>
                           </ext:MultiField>
                        </ext:Anchor>                          
                        
                  
                        <ext:Anchor Horizontal="100%">
                            <ext:NumberField runat="server" ID="FBirimFiyat" FieldLabel="Birim Fiyatı"></ext:NumberField>
                        </ext:Anchor>   
                            
                    </ext:FormLayout>
                </Body>
              <BottomBar>
              
                 <ext:Toolbar runat="server">
                   <Items>
                      <ext:ToolbarFill></ext:ToolbarFill>
                     <ext:Button ID="btnYeni" runat="server" Text="Yeni" Icon="Add">
                       <Listeners>
                          <Click Handler="#{FormKitap}.getForm().reset(); #{FKitapAd}.focus();" />
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
                          <Click Handler="Coolite.AjaxMethods.InsertUpdate(); #{FormKitap}.getForm().reset(); #{FKitapAd}.focus();" />
                        </Listeners>
                     </ext:Button>
                   </Items>
                 </ext:Toolbar>
                 
              </BottomBar>
            </ext:FormPanel>
            <br />
            
 
           <!-- Veri Kaynağı Oluşturuluyor (Başlangıç)!-->
            <ext:Store 
                ID="dsKitaplar" 
                runat="server"
                OnRefreshData="dsKitaplar_RefreshData">
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
        <!-- Veri Kaynağı Oluşturuluyor (Bitiş) !-->
    
 
 
    <!-- Grid Oluşturuluyor !-->
            <ext:GridPanel 
                ID="KitapGrid" 
                runat="server"
                Height="250"
                Width="750"
                Title="Kitap Listesi"
                Icon="Application"
                StoreID="dsKitaplar"
                Border="true"
                StripeRows="true" 
                ClicksToEdit="1"
                AutoExpandColumn="RID">
                 <TopBar>
                  <ext:Toolbar runat="server" ID="tbListe">
                    <Items>
                       <ext:Button runat="server" ID="btnListele" Text="Listele" Icon="ArrowRefresh" OnClientClick="#{KitapGrid}.reload();"></ext:Button>
                    </Items>
                  </ext:Toolbar>
                </TopBar>
              
              <ColumnModel runat="server">
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
              
              <Listeners>
                <Command Handler="if (command=='cmdSil') {Coolite.AjaxMethods.Sil(record.data.RID); #{KitapGrid}.deleteSelected(); #{KitapGrid}.view.focusEl.focus();} else if(command=='cmdDuzelt'){ var kayit=record.data;   #{FRID}.setValue(kayit.RID); #{FKitapAd}.setValue(kayit.KITAPAD); #{FYazar}.setValue(kayit.YAZARRID); #{FTur}.setValue(kayit.TURRID);  #{FYayinEv}.setValue(kayit.YAYINEVIRID);  #{FISBN}.setValue(kayit.ISBN); #{FSAdet}.setValue(kayit.SADET); #{FBasimYili}.setValue(kayit.BASIMTARIHI); #{FKayitTarihi}.setValue(kayit.KAYITTARIHI);  #{FBirimFiyat}.setValue(kayit.BIRIMFIYATI); }" />
              </Listeners>
              
              
              <LoadMask ShowMask="true"/>
              
              <SelectionModel>
                 <ext:RowSelectionModel runat="server" SingleSelect="true">
                   <Listeners>
                   </Listeners>
                 </ext:RowSelectionModel>
              </SelectionModel>

              <BottomBar>
                <ext:PagingToolbar runat="server" PageSize="20" StoreID="dsKitaplar"></ext:PagingToolbar>
              </BottomBar>
              
              
            </ext:GridPanel><br />
     <!-- Grid Oluşturuluyor !-->

         
        </Body>
    </ext:Panel>
 
</asp:Content>

