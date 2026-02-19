@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'product plus group plus description'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMN_PRODUCT_SIMPLE as select from I_Product

{
    @UI.lineItem: [{ position: 10 }]
    key Product,
     @UI.lineItem: [{ position: 20 }]
    ProductGroup,
  
     @UI.lineItem: [{ position: 30 }]
    coalesce(_Text[Language = $session.system_language].ProductName, 
    _Text[Language = 'E'].ProductName) as Description
    }
