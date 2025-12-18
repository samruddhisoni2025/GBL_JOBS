{{ config(
    materialized='view',
    database=var('gcp_project'),
    schema=var('bronze_dataset','rmdw_bronze'),
    tags=['gbl','gbl_hrcy_node_load','reject'],
    post_hook=[ "{{ load_reject_records(source_relation=this,
      target_table='prj-cp-dagdwstr-dev01.rmdw_reject.restaurant_gold_reject') }}" ]
) }}

WITH final_select AS (
  SELECT *
  FROM {{ ref('gbl_hrcy_node_lkp') }}
  WHERE hrcy_lvl_typ_id IS NULL
)

SELECT
  PARSE_JSON(TO_JSON_STRING(t)) AS rejected_record,
  'hierarchy type invalid' AS reject_reason,
  'hrcy_lvl_typ' AS model_name,
  "{{ var('dw_file_id') }}" AS source_file_id,
  CURRENT_TIMESTAMP() AS insert_ts,
  'HrcyLvlTyp_invalid' AS reject_name,
  "{{ var('dw_parent_job_id') }}" AS process_id,
  'GBL' AS product
FROM final_select t
