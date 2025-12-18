{{ config(
    materialized='ephemeral',
    tags=['gbl','gbl_hrcy_node_load','mart']
) }}

SELECT
    h.*,
    t.hrcy_lvl_typ_id AS hrcy_lvl_typ_lkp_id,
    c.ctry_iso2_abbr_cd
FROM {{ source('raw','gbl_hrcy_lvl') }} h
LEFT JOIN {{ source('bronze','gbl_hrcy_lvl_typ') }} t
LEFT JOIN {{ source('bronze','gbl_ctry') }} c