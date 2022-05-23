@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for Project Table'
define root view entity ZI_PROJ
  as select from ztproj as proj
  association [0..*] to ZI_Boolean as _is_sensitive on $projection.IsSensitive = _is_sensitive.Type
{
  key id              as Id,
      project_id      as ProjectId,
      description     as Description,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_BOOLEAN', element: 'Type'  }
      }]
      is_sensitive    as IsSensitive,
      status          as Status,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      _is_sensitive

}
