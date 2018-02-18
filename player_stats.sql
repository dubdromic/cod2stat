with game as (
  select
    *
  from casualties c
  where c.game_id = (select game_id from casualties order by line_number desc limit 1)
), players as (
  select distinct g.attacker_name as name
  from game g
  where g.attacker_name != '' and g.attacker_name != :'pn'
), kills as (
  select g.victim_name as name, count(*)
  from game g
  where line_type = 'K' and attacker_name = :'pn'
  group by g.victim_name
), deaths as (
  select g.attacker_name as name, count(*)
  from game g
  where line_type = 'K' and victim_name = :'pn'
  group by g.attacker_name
), grenade_kills as (
  select g.victim_name as name, count(*)
  from game g
  left join weapons w on g.weapon_id = w.id
  where line_type = 'K' and attacker_name = :'pn' and w.name = 'Grenade'
  group by g.victim_name
)
select
  :'pn' as name,
  p.name,
  k.count as kills,
  d.count as deaths,
  case d.count
    when 0 then 0
    else round(coalesce(cast(cast(k.count as double precision) / cast(d.count as double precision) as numeric), 0), 2)
  end as ratio,
  coalesce(gk.count, 0) as grenade_kills
from game g, players p
left join kills k on k.name = p.name
left join deaths d on d.name = p.name
left join grenade_kills gk on gk.name = p.name
group by p.name, k.count, d.count, gk.count
order by ratio desc;
