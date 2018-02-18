with game as (
  select
    *
  from casualties c
  where c.game_id = (select game_id from casualties order by line_number desc limit 1)
), kills as (
  select g.attacker_name as name,
  count(*) filter (where g.line_type = 'K' and g.attacker_team != g.victim_team) as count
  from game g
  group by g.attacker_name
), team_kills as (
  select g.attacker_name as name, count(*)
  from game g where g.line_type = 'K' and g.attacker_team = g.victim_team
  group by g.attacker_name
), deaths as (
  select g.victim_name as name,
  count(*) filter (where g.line_type = 'K' and g.attacker_team != g.victim_team) as count
  from game g
  group by g.victim_name
)
select
  attacker_name as name,
  k.count as kills,
  d.count as deaths,
  case d.count
    when 0 then 0
    else round(cast(cast(k.count as double precision) / cast(d.count as double precision) as numeric), 2)
  end as ratio,
  tk.count as tks
from game g
left join kills k on g.attacker_name = k.name
left join deaths d on g.attacker_name = d.name
left join team_kills tk on g.attacker_name = tk.name
where attacker_name != ''
group by attacker_name, k.count, d.count, tk.count
order by ratio desc;
