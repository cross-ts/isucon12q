DELETE FROM tenant WHERE id > 100;
DELETE FROM visit_history WHERE created_at >= '1654041600';
UPDATE id_generator SET id=2678400000 WHERE stub='a';
ALTER TABLE id_generator AUTO_INCREMENT=2678400000;

TRUNCATE visit_history2;
INSERT INTO visit_history2 (`tenant_id`, `competition_id`, `player_id`, `min_created_at`)
SELECT tenant_id, competition_id, player_id, MIN(created_at)
FROM visit_history GROUP BY tenant_id, competition_id, player_id;
