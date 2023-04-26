#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#echo $($PSQL "CREATE DATABASE worldcup")
#echo $($PSQL "\c worldcup")
echo $($PSQL "TRUNCATE TABLE games, teams")
#Add each unique team to teams
#what happens if I try to add teams when the column has unique constraint?
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then
    #get team id
    TEAM=$($PSQL "SELECT * FROM teams WHERE name='$WINNER'")
    #if not found
    if [[ -z $TEAM ]]
    then
     #insert team name
      echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")  
    fi
  fi
  #insert any missing opponent teams
  if [[ $OPPONENT != opponent ]]
  then
  #get team id
    OPP=$($PSQL "SELECT * FROM teams where name='$OPPONENT'")
  #if not found
    if [[ -z $OPP ]]
    then
  #insert team name
      echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    fi
  fi
  if [[ $YEAR != year ]]
  then
  #set winner id to var from teams
    WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  #set opponent id to var from teams
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  #insert into games
    echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WIN_ID, $OPP_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  fi
done