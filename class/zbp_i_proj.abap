CLASS lhc_Z_I_PROJ DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_proj RESULT result.

    METHODS setStatus FOR MODIFY
      IMPORTING keys FOR ACTION zi_proj~setStatus RESULT result.

    METHODS deriveProjectID FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_proj~deriveProjectID.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_proj~validateDates.

ENDCLASS.

CLASS lhc_Z_I_PROJ IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD setStatus.

    MODIFY ENTITIES OF zi_proj IN LOCAL MODE
    ENTITY zi_proj
    UPDATE FROM VALUE #( FOR key IN keys (
          Id = key-Id
          Status = 'A' " approved
          %control-Status = if_abap_behv=>mk-on
    ) )

    FAILED failed
    REPORTED reported.

    READ ENTITIES OF zi_proj IN LOCAL MODE
    ENTITY zi_proj
    FROM VALUE #( FOR key IN keys (
                                        Id = key-Id
                                        %control = VALUE #(
                                            BeginDate       = if_abap_behv=>mk-on
                                            CreatedAt       = if_abap_behv=>mk-on
                                            CreatedBy       = if_abap_behv=>mk-on
                                            Description     = if_abap_behv=>mk-on
                                            EndDate         = if_abap_behv=>mk-on
                                            IsSensitive     = if_abap_behv=>mk-on
                                            LastChangedAt   = if_abap_behv=>mk-on
                                            LastChangedBy   = if_abap_behv=>mk-on
                                            ProjectId       = if_abap_behv=>mk-on
                                            Status          = if_abap_behv=>mk-on
                                        )
                    ) ) RESULT DATA(lt_project).
    result = VALUE #( FOR lw_project IN lt_project (
                                            id = lw_project-Id
                                            %param = lw_project
    ) ).
  ENDMETHOD.

  METHOD deriveProjectID.

    READ ENTITIES OF zi_proj IN LOCAL MODE
    ENTITY zI_proj FIELDS ( ProjectId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_project).

    DELETE lt_project WHERE ProjectId IS NOT INITIAL.
    IF lines( lt_project ) GT 0.
      SELECT COUNT( * ) FROM ztproj INTO @DATA(lv_count).

      MODIFY ENTITIES OF zi_proj IN LOCAL MODE
         ENTITY zi_proj
         UPDATE FIELDS ( ProjectId )
         WITH VALUE #(
            FOR lw_proj IN lt_project INDEX INTO i (
            %key = lw_proj-%key
            ProjectId = COND #( WHEN lw_proj-IsSensitive EQ 'Y'
                                    THEN |S-{  sy-timlo  }|
                                    ELSE |N-{ sy-timlo }| )
        ) )
     REPORTED DATA(lt_reported).
    ENDIF.

  ENDMETHOD.

  METHOD validateDates.

    READ ENTITY zi_proj\\zi_proj FROM VALUE #(
    FOR <root_key>  IN keys ( %key-Id = <root_key>-Id
                                %control = VALUE #( BeginDate = if_abap_behv=>mk-on
                                                    EndDate =  if_abap_behv=>mk-on
                                 ) )

     ) RESULT DATA(lt_project).

    LOOP AT lt_project INTO DATA(lw_project).

      IF lw_project-BeginDate LT cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %key = lw_project-%key
                                      id = lw_project-Id
                       ) TO failed-zi_proj.
        APPEND VALUE #( %key = lw_project-%key
                  %msg = new_message( id       = 'ZSOM_MSG'
                                            number   = 011
                                            severity = if_abap_behv_message=>severity-error )
                  %element-BeginDate = if_abap_behv=>mk-on

 ) TO reported-zi_proj.
      ELSEIF lw_project-BeginDate GT lw_project-EndDate.
        APPEND VALUE #( %key = lw_project-%key
                              id = lw_project-Id
               ) TO failed-zi_proj.

        APPEND VALUE #( %key = lw_project-%key
                        %msg = new_message( id = 'ZSOM_MSG'
                                             number   = 010
                                             v1       = lw_project-BeginDate
                                             v2       = lw_project-EndDate
                                             v3 = lw_project-ProjectId
                                             severity = if_abap_behv_message=>severity-error
                         )
                        %element-BeginDate = if_abap_behv=>mk-on
                        %element-EndDate = if_abap_behv=>mk-on
       ) TO reported-zi_proj.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
