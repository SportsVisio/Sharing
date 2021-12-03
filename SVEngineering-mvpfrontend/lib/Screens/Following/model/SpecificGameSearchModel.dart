class SpecificGameSearchModel {
  var title;
  List<TeamAndDate>? arrGames;
  SpecificGameSearchModel({this.arrGames, this.title});
}

class TeamAndDate {
  var teams;
  var date;
  TeamAndDate({this.date, this.teams});
}
