#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo "$($PSQL "CREATE TABLE games(game_id serial primary key);")"

echo "$($PSQL "ALTER TABLE games add year int")"

echo "$($PSQL "ALTER TABLE games add round varchar(30)")"

echo "$($PSQL "ALTER TABLE games add winner varchar(20)")"

echo "$($PSQL "ALTER TABLE games add opponent varchar(20)")"

echo "$($PSQL "Alter TAble games Add winner_goals int")"

echo "$($PSQL "Alter Table games Add opponent_goals int")"

echo "$($PSQL "\d games")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ YEAR != 'year' ]]
then
#add db entry
echo "$($PSQL "INSERT INTO games(year, round, winner, opponent, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', '$WINNER', '$OPPONENT', $WINNER_GOALS, $OPPONENT_GOALS)")"

fi
done
echo "$($PSQL "select * from games")"
# echo "$($PSQL "")"
