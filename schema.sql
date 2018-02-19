CREATE EXTENSION pgcrypto;

CREATE TABLE public.maps (
  id serial primary key,
  name text,
  identifier text unique
);

CREATE TABLE public.games (
  id uuid primary key default gen_random_uuid(),
  map_id integer references public.maps(id)
);

CREATE TABLE public.weapons (
  id serial primary key,
  name text,
  identifier text unique
);

CREATE TABLE public.damage_types (
  id serial primary key,
  name text,
  identifier text unique
);

CREATE TABLE public.damage_locations (
  id serial primary key,
  name text,
  identifier text unique
);

CREATE TABLE public.casualties (
  id bigserial primary key,
  game_id uuid references public.games(id),
  line_number bigint not null,
  timestamp text not null,
  line_type text not null,
  victim_team text,
  victim_name text,
  attacker_team text,
  attacker_name text,
  weapon_id integer references public.weapons(id),
  damage_type_id integer references public.damage_types(id),
  damage integer,
  damage_location_id integer references public.damage_locations(id),
  hash text unique
);

CREATE TABLE public.casualties_staging (
  id bigserial primary key,
  game_id uuid references public.games(id),
  line_number bigint not null,
  timestamp text not null,
  line_type text not null,
  victim_team text,
  victim_name text,
  attacker_team text,
  attacker_name text,
  weapon_id integer references public.weapons(id),
  damage_type_id integer references public.damage_types(id),
  damage integer,
  damage_location_id integer references public.damage_locations(id),
  hash text unique
);
