@EndUserText.label : 'DB Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table ztproj {
  key client      : abap.clnt not null;
  key id          : sysuuid_x16 not null;
  project_id      : abap.char(10);
  description     : abap.char(50);
  is_sensitive    : abap.char(1);
  status          : abap.char(1);
  begin_date      : /dmo/begin_date;
  end_date        : /dmo/end_date;
  created_by      : syuname;
  created_at      : timestampl;
  last_changed_by : syuname;
  last_changed_at : timestampl;

}
