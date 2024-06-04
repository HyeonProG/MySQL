create table tb_team(
	team_id int auto_increment,
    team_name varchar(50) not null,
    home_city varchar(50),
    established_year year,
    primary key(team_id)
);

create table tb_player(
	player_id int auto_increment,
    player_name varchar(20) not null,
    position varchar(20),
    birth_date date,
    team_id int,
    primary key(player_id),
    foreign key(team_id) references tb_team(team_id)
);