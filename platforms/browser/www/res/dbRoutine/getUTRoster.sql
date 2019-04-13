select 
'G' as UTR_Pos, p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_G1 = p.ascFanta_pID
union
select 
'G' as UTR_Pos, p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_G2 = p.ascFanta_pID
union
select 
'F' as UTR_Pos, p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_F1 = p.ascFanta_pID
union
select 
'F' as UTR_Pos, p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_F2 = p.ascFanta_pID
union
select 
'C' as UTR_Pos, p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_C1 = p.ascFanta_pID
union
select 
'B' as UTR_Pos, p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_B1 = p.ascFanta_pID
