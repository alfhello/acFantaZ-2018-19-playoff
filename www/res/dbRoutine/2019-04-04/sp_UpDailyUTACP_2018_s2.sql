CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_UpDailyUTACP_2018_s2`(in IN_gmDate varchar(20))
BEGIN

declare updUTACP int;

update ascFanta_UTRoster_DailyLog_NBA_2018_s2 a
left join ascFanta_PlayerStat_NBA_2018_s2 G1 on a.ascFanta_pID_G1 = G1.ascFanta_personId and G1.ascFanta_rStatus = 'CfmRec' and date(G1.ascFanta_sMatchDate) = IN_gmDate
left join ascFanta_PlayerStat_NBA_2018_s2 G2 on a.ascFanta_pID_G2 = G2.ascFanta_personId and G2.ascFanta_rStatus = 'CfmRec' and date(G2.ascFanta_sMatchDate) = IN_gmDate
left join ascFanta_PlayerStat_NBA_2018_s2 F1 on a.ascFanta_pID_F1 = F1.ascFanta_personId and F1.ascFanta_rStatus = 'CfmRec' and date(F1.ascFanta_sMatchDate) = IN_gmDate
left join ascFanta_PlayerStat_NBA_2018_s2 F2 on a.ascFanta_pID_F2 = F2.ascFanta_personId and F2.ascFanta_rStatus = 'CfmRec' and date(F2.ascFanta_sMatchDate) = IN_gmDate
left join ascFanta_PlayerStat_NBA_2018_s2 C1 on a.ascFanta_pID_C1 = C1.ascFanta_personId and C1.ascFanta_rStatus = 'CfmRec' and date(C1.ascFanta_sMatchDate) = IN_gmDate
left join ascFanta_PlayerStat_NBA_2018_s2 B1 on a.ascFanta_pID_B1 = B1.ascFanta_personId and B1.ascFanta_rStatus = 'CfmRec' and date(B1.ascFanta_sMatchDate) = IN_gmDate
set 
a.ascFanta_G1_ACP = ifnull(G1.ascFanta_TACP,0), a.ascFanta_G2_ACP = ifnull(G2.ascFanta_TACP,0),
a.ascFanta_F1_ACP = ifnull(F1.ascFanta_TACP,0), a.ascFanta_F2_ACP = ifnull(F2.ascFanta_TACP,0),
a.ascFanta_C1_ACP = ifnull(C1.ascFanta_TACP,0), a.ascFanta_B1_ACP = ifnull(B1.ascFanta_TACP,0),
a.ascFanta_TodayTACP = ifnull(G1.ascFanta_TACP,0)+ifnull(G2.ascFanta_TACP,0)+ifnull(F1.ascFanta_TACP,0)+ifnull(F2.ascFanta_TACP,0)+ifnull(C1.ascFanta_TACP,0)+ifnull(B1.ascFanta_TACP,0),
a.ascFanta_rStatus = 'UTACPCfm', a.ascFanta_LogKey = uuid()
where a.ascFanta_rStatus = 'RCopyCfm' and a.ascFanta_Active = 1 and a.ascFanta_LogDate = IN_gmDate
;

set updUTACP = ROW_COUNT();

select updUTACP;

END