INSERT INTO public.maps
  (name, identifier)
VALUES
  ('HM2', 'lnl_hm2'),
  ('Anzio', 'mp_anzio'),
  ('Bassano', 'mp_bassano'),
  ('Breakout', 'mp_breakout'),
  ('Brecourt', 'mp_brecourt'),
  ('Burgundy', 'mp_burgundy'),
  ('Carentan', 'mp_carentan'),
  ('Dawnville', 'mp_dawnville'),
  ('Depot', 'mp_depot'),
  ('Downtown', 'mp_downtown'),
  ('Farmhouse', 'mp_farmhouse'),
  ('Harbor', 'mp_harbor'),
  ('Leningrad', 'mp_leningrad'),
  ('Hotmata', 'mp_matmata'),
  ('Night Gorge', 'mp_night_gorge'),
  ('Omaha', 'mp_omaha_v2a'),
  ('POW Camp', 'mp_powcamp'),
  ('Railyard', 'mp_railyard'),
  ('Rhine', 'mp_rhine'),
  ('TJ', 'mp_toujane'),
  ('Train Station', 'mp_trainstation'),
  ('Tripoli', 'mp_tripoli')
ON CONFLICT (identifier) DO NOTHING;

INSERT INTO public.weapons
  (name, identifier)
VALUES
  ('Bren', 'bren_mp'),
  ('Lee-Enfield Scoped', 'enfield_scope_mp'),
  ('Lee-Enfield', 'enfield_mp'),
  ('Mosin Scoped', 'mosin_nagant_sniper_mp'),
  ('Mosin', 'mosin_nagant_mp'),
  ('Grenade', 'frag_grenade_british_mp'),
  ('Grenade', 'frag_grenade_american_mp'),
  ('Grenade', 'frag_grenade_russian_mp'),
  ('Grenade', 'frag_grenade_german_mp'),
  ('Gewher', 'g43_mp'),
  ('Kar 98', 'kar98k_mp'),
  ('Kar 98 Sniper', 'kar98k_sniper_mp'),
  ('Luger', 'luger_mp'),
  ('Springfield', 'springfield_mp'),
  ('M1 Garand', 'm1garand_mp'),
  ('M1 Carbine', 'm1carbine_mp'),
  ('MG42', 'mg42_bipod_stand_mp'),
  ('MP44', 'mp44_mp'),
  ('MP40', 'mp40_mp'),
  ('Panzerschreck', 'panzerschreck_mp'),
  ('SVT40', 'SVT40_mp'),
  ('PPS42', 'PPS42_mp'),
  ('PPSH', 'ppsh_mp'),
  ('g30 Cal', '30cal_stand_mp'),
  ('BAR', 'bar_mp'),
  ('Grease Gun', 'greasegun_mp'),
  ('None', 'none'),
  ('Shotgun', 'shotgun_mp'),
  ('Sten', 'sten_mp'),
  ('Thompson', 'thompson_mp'),
  ('Webley', 'webley_mp'),
  ('TT30', 'TT30_mp'),
  ('Colt', 'colt_mp')
ON CONFLICT (identifier) DO NOTHING;

INSERT INTO public.damage_types
  (name, identifier)
VALUES
  ('Trigger Hurt', 'MOD_TRIGGER_HURT'),
  ('Projectile', 'MOD_PROJECTILE'),
  ('Projectile', 'MOD_PROJECTILE_SPLASH'),
  ('Explosive', 'MOD_EXPLOSIVE'),
  ('Falling', 'MOD_FALLING'),
  ('Grenade', 'MOD_GRENADE_SPLASH'),
  ('Head Shot', 'MOD_HEAD_SHOT'),
  ('Thwack', 'MOD_MELEE'),
  ('Pistol', 'MOD_PISTOL_BULLET'),
  ('Rifle', 'MOD_RIFLE_BULLET'),
  ('Suicide', 'MOD_SUICIDE')
ON CONFLICT (identifier) DO NOTHING;

INSERT INTO public.damage_locations
  (name, identifier)
VALUES
  ('Head', 'head'),
  ('Lower Left Arm', 'left_arm_lower'),
  ('Upper Left Arm', 'left_arm_upper'),
  ('Left Foot', 'left_foot'),
  ('Left Hand', 'left_hand'),
  ('Lower Left Leg', 'left_leg_lower'),
  ('Upper Left Leg', 'left_leg_upper'),
  ('Neck', 'neck'),
  ('None', 'none'),
  ('Lower Right Arm', 'right_arm_lower'),
  ('Upper Right Arm', 'right_arm_upper'),
  ('Right Foot', 'right_foot'),
  ('Right Hand', 'right_hand'),
  ('Lower Right Leg', 'right_leg_lower'),
  ('Upper Right Leg', 'right_leg_upper'),
  ('Lower Torso', 'torso_lower'),
  ('Upper Torso', 'torso_upper')
ON CONFLICT (identifier) DO NOTHING;
