ALTER TABLE loans_lifecycles
ADD COLUMN reshelve_by date DEFAULT CURRENT_DATE + INTERVAL '3 days';
