
#1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select * from ipl_bidding_details;
select bidder_id,
round(sum(case when BID_STATUS="Won" then 1 else 0 end)*100/count(BID_STATUS),2) as Percentage_of_wins
from ipl_bidding_details
group by bidder_id ;

#2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
select * from ipl_match_schedule;
select * from ipl_stadium;

select ist.STADIUM_ID,STADIUM_NAME,CITY,count(MATCH_ID) no_of_matches
from ipl_stadium ist
join ipl_match_schedule ims
on ist.STADIUM_ID=ims.STADIUM_ID
group by ist.STADIUM_ID;

#3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
select * from ipl_match_schedule;
select * from ipl_match;

select STADIUM_NAME,
round(sum(case when im.TOSS_WINNER=im.MATCH_WINNER then 1 else 0 end)*100/count(*),2) as Percentage_of_wins_team_toss
from ipl_match_schedule ims 
join  ipl_stadium ist
on ims.STADIUM_ID=ist.STADIUM_ID
join  ipl_match im
on ims.MATCH_ID=im.MATCH_ID
group by STADIUM_NAME ;

#4.	Show the total bids along with bid team and team name.

select * from ipl_bidder_points;
select * from ipl_bidding_details;
select * from ipl_team;

select team_id,team_name,count(BIDDER_ID) as Total_bids
from ipl_bidding_details ibd
join ipl_team it
on ibd.bid_team=it.team_id
group by bid_team;


#5.	Show the team id who won the match as per the win details.

select * from ipl_match;
select * from ipl_team;
select MATCH_ID,TEAM_ID1,TEAM_ID2,MATCH_WINNER,
case when MATCH_WINNER=1 then TEAM_ID1 
else TEAM_ID2 
end  winnig_team_id ,WIN_DETAILS
from ipl_match;

#6.	Display total matches played, total matches won and total matches lost by team along with its team name.
select * from ipl_team_standings;
select TEAM_name,sum(MATCHES_PLAYED),sum(MATCHES_WON),sum(MATCHES_LOST)
from ipl_team_standings its
join ipl_team it
on  its.TEAM_ID=it.TEAM_ID
group by its.TEAM_ID;

#7.	Display the bowlers for Mumbai Indians team.
select * from ipl_team;
select * from ipl_team_players;
select team_name,PLAYER_ROLE,player_name
from ipl_team it
join ipl_team_players itp
on it.team_id=itp.team_id
join ipl_player ip
on itp.PLAYER_ID=ip.PLAYER_ID
where TEAM_NAME='mumbai Indians' and Player_role='bowler';

#8.	How many all-rounders are there in each team, 
#Display the teams with more than 4 all-rounder in descending order.

select * from ipl_team;
select * from ipl_team_players;
select TEAM_NAME,count(player_name) as no_of_allrounders
from ipl_team it
join ipl_team_players itp
on it.team_id=itp.team_id
join ipl_player ip
on itp.PLAYER_ID=ip.PLAYER_ID
where Player_role='all-rounder'
group by TEAM_NAME
having count(player_name)>4
order by count(player_name) desc;
