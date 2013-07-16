Product      : Coolite Toolkit Professional Edition
Version      : 0.8.2
Last Updated : 2009-12-21


--------------------------------------------------------------------------
                             CONTENTS
--------------------------------------------------------------------------

I.    ADD TO VISUAL STUDIO TOOLBOX INSTRUCTIONS
II.   SAMPLE WEB.CONFIG
III.  CREDITS
	
	
--------------------------------------------------------------------------
            I. ADD TO VISUAL STUDIO TOOLBOX INSTRUCTIONS
--------------------------------------------------------------------------

If you ran the automatic installer (.msi), the Coolite Toolkit component
icons should be automatically installed to your Visual Studio 2005/2008
Toolbox. 

The .msi installer does not automatically install the Toolbox icons to the
Visual Web Developer 2005/2008 Toolbox. They must be added manually.

The following steps are required to manually install the controls into 
your Visual Studio or Visual Web Developer Express Toolbox. 
		
	1.  Open Visual Studio or Visual Web Developer Express.

	2.  Open an existing web site or create a new web site project.
	
	3.  Open or create a new .aspx page.

	4.  Open the ToolBox panel, typically located on the left side in a 
	    fly-out panel (Ctrl + Alt + x).

	5.  Create a new "Coolite Toolkit" Tab, by...
		  a. Right-Click in the ToolBox area.
		  b. Select "Add Tab".
		  c. Enter "Coolite Toolkit".

	6.  Inside the "Coolite Toolkit" tab, Right-Click and select 
	    "Choose Items...".

	7.  Under the ".NET Framework Components" Tab select the "Browse" 
	    button.

	8.  Navigate to and select the Coolite.Ext.Web.dll file, choose open.
			
          NOTE: If the automatic installer has been run previously, the 
                Coolite.Ext.Web.dll can typically be found in the 
                following location:

                C:\Program Files\Coolite\Coolite Toolkit Professional v0.8.2\

	9.  The component items should now be added to the list and 
	    pre-checked. You can confirm by sorting the list by "Namespace" 
	    and scrolling to "Coolite.Ext.Web"

	10. Click "OK". The icons should be added to your ToolBox. You should 
	    now be able to drag/drop a Coolite component onto your WebForm.
	
	11. Enjoy.


--------------------------------------------------------------------------
                        III. SAMPLE WEB.CONFIG
--------------------------------------------------------------------------

<?xml version="1.0"?>
<configuration>
	<configSections>
		<section name="coolite" type="Coolite.Web.UI.GlobalConfig" requirePermission="false" />
	</configSections>
  
	<!--  
    COOLITE GLOBAL CONFIGURATION PROPERTIES
      
    ajaxEventUrl : string
		The url to request for all AjaxEvents.
        Default is "".
                      
	ajaxMethodNamespace : string
		Specifies a custom namespace prefix to use for the AjaxMethods. Example "CompanyX".
		Default is "Coolite.AjaxMethods". 

	ajaxMethodProxy : ClientProxy
		Specifies whether server-side Methods marked with the [AjaxMethod] attribute will output configuration script to the client. 
		If false, the AjaxMethods can still be called, but the Method proxies are not automatically generated. 
		Specifies ajax method proxies creation. The Default value is to Create the proxy for each ajax method.
		Default is 'Default'. Options include [Default|Include|Ignore]

	ajaxViewStateMode : ViewStateMode
		Specifies whether the ViewState should be returned and updated on the client during an AjaxEvent. 
		The Default value is to Exclude the ViewState from the Response.
		Default is 'Default'. Options include [Default|Exclude|Include]

	cleanResourceUrl : boolean
		The Coolite controls can clean up the autogenerate WebResource Url so they look presentable.        
		Default is 'true'. Options include [true|false]

	clientInitAjaxMethods : boolean
		Specifies whether server-side Methods marked with the [AjaxMethod] attribute will output configuration script to the client. 
		If false, the AjaxMethods can still be called, but the Method proxies are not automatically generated. 
		Default is 'false'. Options include [true|false]

	idMode : IDMode
		Specifies how the Client ID for the control should be sent to the client. Similar in functionality to ASP.NET 4.0 ClientIDMode property. 
		The Default value is Legacy.
		Default is 'Legacy'. Options include [Legacy|Inherit|Static|Ignore|Explicit]

	initScriptMode : InitScriptMode
		Specifies how the initialization JavaScript code will be rendered in the client. 
		Inline will place the Ext.onReady block within the Page <head>.
		Linked will create a link to the init block and download in a separate request. 
		The Default value is Inline.
		Default is 'Inline'. Options include [Inline|Linked]          

	locale : string
		Specifies language of the ExtJS resources to use.    
		Default is to return the System.Threading.Thread.CurrentThread.CurrentUICulture if available. 
	                  
	gzip : boolean
		Whether to automatically render scripts with gzip compression.        
		Only works when renderScripts="Embedded" and/or renderStyles="Embedded".       
		Default is true. Options include [true|false]

	scriptAdapter : ScriptAdapter
		Gets or Sets the current script Adapter.     
		Default is "Ext". Options include [Ext|jQuery|Prototype|YUI]

	removeViewState : boolean
		True to completely remove the __VIEWSTATE field from the client. 
		If true, the VIEWSTATE is not sent to, nor returned from the client. 
		Default is "false". Options include [true|false]

	renderScripts : ResourceLocationType
		Whether to have the coolite controls output the required JavaScript includes or not.       
		Gives developer option of manually including required <script> files.        
		Default is Embedded. Options include [Embedded|File|None] 

	renderStyles : ResourceLocationType
		Whether to have the coolite controls output the required StyleSheet includes or not.       
		Gives developer option of manually including required <link> or <style> files.       
		Default is Embedded. Options include [Embedded|File|None]

	resourcePath : string
		Gets the prefix of the Url path to the base ~/Coolite/ folder containing the resources files for this project. 
		The path can be Absolute or Relative.

	scriptMode : ScriptMode
		Whether to include the Release (condensed) or Debug (with inline documentation) Ext JavaScript files.       
		Default is "Release". Options include [Release|Debug]

	sourceFormatting : boolean
		Specifies whether the scripts rendered to the page should be formatted. 'True' = formatting, 'False' = minified/compressed. 
		Default is 'false'. Options include [true|false]

	stateProvider : StateProvider
		Gets or Sets the current script Adapter.
		Default is 'PostBack'. Options include [PostBack|Cookie|None]

	theme : Theme
		Which embedded theme to use.       
		Default is "Default". Options include [Default|Gray|Slate]

	quickTips : boolean
		Specifies whether to render the QuickTips. Provides attractive and customizable tooltips for any element.
		Default is 'true'. Options include [true|false]
	-->

	<coolite theme="Default" />

  
	<!-- 
		The following system.web section is only requited for running ASP.NET AJAX under Internet
		Information Services 6.0 (or earlier).  This section is not necessary for IIS 7.0 or later.
	-->
	<system.web>
		<httpHandlers>
			<add path="*/coolite.axd" verb="*" type="Coolite.Ext.Web.ResourceManager" validate="false" />
		</httpHandlers>
		<httpModules>
			<add name="AjaxRequestModule" type="Coolite.Ext.Web.AjaxRequestModule, Coolite.Ext.Web" />
		</httpModules>
	</system.web>
  
	<!-- 
		The system.webServer section is required for running ASP.NET AJAX under Internet Information Services 7.0.
		It is not necessary for previous version of IIS.
	-->
	<system.webServer>
		<validation validateIntegratedModeConfiguration="false"/>
		<modules>
			<add name="AjaxRequestModule" preCondition="managedHandler" type="Coolite.Ext.Web.AjaxRequestModule, Coolite.Ext.Web" />
		</modules>
		<handlers>
			<add name="AjaxRequestHandler" verb="*" path="*/coolite.axd" preCondition="integratedMode" type="Coolite.Ext.Web.ResourceManager"/>
		</handlers>
	</system.webServer>
</configuration>

	
--------------------------------------------------------------------------
                             IV. CREDITS
--------------------------------------------------------------------------
	
1.  FamFamFam Icons provided by Mark James 
    http://www.famfamfam.com/lab/icons/silk/
	
    See \Build\Resources\Coolite\Licenses\FamFamFam.txt for more information.

2.  Json.NET provided by James Newton-King
    http://www.codeplex.com/json/
    
    See \Build\Resources\Coolite\Licenses\Newtonsoft.Json.txt
    
3.  Ext JS - JavaScript Library provided by ExtJS LLC
    http://www.extjs.com/    
    
    See \Build\Resources\Coolite\Licenses\ExtJS.txt


--------------------------------------------------------------------------
                               
--------------------------------------------------------------------------
	
        Copyright 2006-2009 Coolite Inc., All rights reserved.

                             Coolite Inc.
                        208, 10113 104 Street
                   Edmonton, Alberta, Canada T5J 1A1
                           +1(888)775-5888
                           www.coolite.com
                         support@coolite.com