# zdemo_stuff

Some examples  
Built using abapGit

ZEQUIP - select from I_Equipment  
ZMN_JOINS - some joins VBAK -> VBAP -> MAKT  
ZMN_USE_PO_CDS - EKPO -> EKKO compared with i_purchaseorderitemapi01  
ZPRODUCT - get some materials plus language texts including fallback  
ZMN_ROWNUMBER - get row_number in SELECT  
ZMN_EML access entity via EML  
ZMNTAB - table plus some CDS/RAP to show features plus authorizations
ZAMDP_EXAMPLE and ZUSE_AMDP - use of AMDP  
ZUSE_CTE - using common table expression  
ZMNDEMO - Fiori app as a BSP app

ZAMDP_MATERIAL_SEARCH and ZMN_GETMATERIALS - fuzzy search 

ZSPFLI view, access control, and program to read the view ZMN_USE_CDS_AC  

ZMN_EMP* - examples of hiding/masking fields and using EML  

ZMN_MULTIPLE_COND - IF with multiple method conditions  


If problems during abapGit import 
================================= 
remove existing VANs using /o/IWBEP/REG_VOCAN  
remove old gateway services using /o/iwbep/reg_Service  

# minimal Fiori app framework

There is a zip file, minimal_Fiori_app.zip, with enough files to make a simple Fiori app 
which is suitable for adding to a Fiori launch pad.  

Unpack the zip file to a new folder.  

Edit Component.js

- replace AAAAAA with a unique application name.

Edit manifest.json
- replace AAAAAAA with the unique application name
- replace SSSSSSS with your service binding name
- replace VVVVVV with your CDS view name

Edit i18n/i18n.properties
  - replace TTTTTT with your app's title
  - replace DDDDDD with your app's description
 
In SAPGUI, run program /UI5/UI5_REPOSITORY_LOAD and use the option to upload a new SAPUI5 app. Give it a name, and description, and package.  

When finished, use transaction /UI2/FLPAM to add a new technical catalog and include your new Fiori app.  

Optionally, you can make pages and spaces.  

Add the catalog to a PFCG role, as normal, and chek that you have access to the OData services etc.



