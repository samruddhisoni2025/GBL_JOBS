SELECT *
FROM (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY gbal_hrcy_node_id
           ORDER BY eff_dt DESC
         ) rn
  FROM {{ ref('gbl_hrcy_node_valid') }}
)
WHERE rn = 1