{{ config(
    materialized='ephemeral',
    tags=['gbl','gbl_hrcy_node_load','mart']
) }}

SELECT
    n.*,
    c.ctry_iso2_abbr_cd,
    t.hrcy_lvl_typ_id
FROM {{ source('raw','gbl_hrcy_node') }} n
LEFT JOIN {{ source('bronze','gbl_ctry') }} c
LEFT JOIN {{ source('bronze','gbl_hrcy_lvl_typ') }} t