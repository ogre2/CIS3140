.mode csv
.output extract2.csv
WITH cte AS (
  SELECT *, 
       Racer_Turbo + Racer_Supercharged + Racer_Performance + Racer_Horsepower + 
       Car_Overall + 
       Engine_Modifications + Engine_Performance + Engine_Chrome + Engine_Detailing + Engine_Cleanliness + 
       Body_Frame_Undercarriage + Body_Frame_Suspension + Body_Frame_Chrome + Body_Frame_Detailing + Body_Frame_Cleanliness + 
       Mods_Paint + Mods_Body + Mods_Wrap + Mods_Rims + Mods_Interior + Mods_Other + Mods_ICE + Mods_Aftermarket + Mods_WIP + Mods_Overall Total
  FROM Cars
)
SELECT ROW_NUMBER() OVER (ORDER BY Make, Total DESC) Ranking,
       Car_ID, Year, Make, Model, Total
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY Make ORDER BY Total) rn FROM cte) 
WHERE rn <= 3
ORDER BY Make, Total DESC;
