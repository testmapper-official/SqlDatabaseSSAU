SELECT
    (SELECT facility FROM cd.facilities ORDER BY monthlymaintenance DESC LIMIT 1) as 'rich',
    (SELECT facility FROM cd.facilities ORDER BY monthlymaintenance ASC LIMIT 1) as 'econom'