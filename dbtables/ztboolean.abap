@EndUserText.label : 'Boolean Value List'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table ztboolean {
  key client : abap.clnt not null;
  key type   : abap.char(1) not null;
  value      : abap.char(10);

}
