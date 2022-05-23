managed implementation in class zbp_i_proj unique;
//strict;

define behavior for ZI_PROJ //alias <alias_name>
//authorization master ( global )
persistent table ztproj
lock master
etag master LastChangedAt
{

  field ( readonly, numbering : managed ) Id;
  field ( readonly ) ProjectId, Status;
  field ( readonly ) CreatedBy, CreatedAt, LastChangedBy, LastChangedAt;
  field ( mandatory ) BeginDate, EndDate;


  create;
  update;
  delete;

  action ( features : instance ) setStatus result [1] $self;

  // validations
   validation validateDates on save { field BeginDate, EndDate; }

  // determination
  determination deriveProjectID on modify
  { create; }

  mapping for ZTPROJ
  {
    ProjectId = project_id;
    BeginDate = begin_date;
    EndDate = end_date;
    LastChangedAt = last_changed_at;
    Status = status;
    IsSensitive = is_sensitive;
  }
}
