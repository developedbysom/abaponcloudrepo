@EndUserText.label: 'Consumption View Project'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI: {
 headerInfo: { typeName: 'Project', typeNamePlural: 'Projects', title: { type: #STANDARD, value: 'projectd' } } }
@Search.searchable: true

define root view entity ZC_PROJ
  provider contract transactional_query
  as projection on ZI_PROJ
{
      @UI.facet: [      {  id:                 'GeneralData',
                           purpose:         #STANDARD,
                           type:            #COLLECTION,
                           label:           'Project Header',
                           position:        10 },

                       {

                          type: #FIELDGROUP_REFERENCE,
                          position: 10,
                          targetQualifier: 'GeneralData1',
                          parentId: 'GeneralData',
                          isSummary: true,
                          isPartOfPreview: true
                       },

                       {
                          type: #FIELDGROUP_REFERENCE,
                          position: 20,
                          targetQualifier: 'GeneralData2',
                          parentId: 'GeneralData',
                          isSummary: true,
                          isPartOfPreview: true
                      }]

      @UI.hidden: true
  key Id,


      @UI: {
              lineItem: [ { position: 10, importance: #HIGH , label: 'Project IDr#'} ],
              selectionField: [{position: 10 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 10,importance: #HIGH }]
      }
      @EndUserText:{label: 'Project ID'}
      @Search.defaultSearchElement: true
      ProjectId     as projectd,

      @UI: {
              lineItem: [ { position: 20, importance: #HIGH , label: 'Project Descriptionr#'} ],
              fieldGroup: [{qualifier: 'GeneralData1',position: 20,importance: #HIGH }],
              selectionField: [{position: 20 }]
      }
      @EndUserText:{label: 'Project Description'}

      Description,

      @UI: {    lineItem: [ { position: 30, importance: #HIGH , label: 'Sensitive'} ],
                fieldGroup: [{qualifier: 'GeneralData1',position: 30,importance: #HIGH }]
      }
      @EndUserText:{label: 'Sensitive'}
      
      IsSensitive,     

      @UI: {
       lineItem:       [ { position: 60, importance: #HIGH },
                         { type: #FOR_ACTION, dataAction: 'setStatus', label: 'Approve' } ],
                         fieldGroup: [{qualifier: 'GeneralData1',position: 40,importance: #HIGH }],
       identification: [ { position: 60, label: 'Status [O(Open)|C(Closed)]' } ]  }
      @EndUserText:{label: 'Status'}
      Status,

      @UI: {
              lineItem: [ { position: 50, importance: #MEDIUM , label: 'Begin Date'} ],
              fieldGroup: [{qualifier: 'GeneralData2',position: 10,importance: #HIGH }]
      }
      @EndUserText:{label: 'Begin Date'}

      BeginDate,
      @UI: {
             lineItem: [ { position: 60, importance: #MEDIUM , label: 'End Date'} ],
              fieldGroup: [{qualifier: 'GeneralData2',position: 20,importance: #HIGH }]
      }
      @EndUserText:{label: 'End Date'}
      EndDate,

      @UI.hidden: true
      LastChangedAt as LastChangedAt
}
