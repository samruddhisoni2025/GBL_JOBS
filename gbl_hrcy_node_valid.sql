SELECT *
FROM {{ ref('gbl_hrcy_node_lkp') }}
WHERE gbal_hrcy_node_na <> 'N'
  AND ctry_iso2_abbr_cd IS NOT NULL