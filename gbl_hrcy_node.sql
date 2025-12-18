{{ config(
    materialized='table',
    tags=['gbl','gbl_hrcy_node_load','mart']
) }}

SELECT *
FROM {{ ref('gbl_hrcy_node_dedup') }}