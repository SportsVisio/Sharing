class ApiEndPoints {
  // static const BASE_URL =
  //     "https://e0gcs528ad.execute-api.us-east-1.amazonaws.com/Prod/";

  static const BASE_URL =
      "https://e0gcs528ad.execute-api.us-east-1.amazonaws.com/Prod_V2/";

  static const BASE_URL_SWAGGER = "https://dev.sportsvisio-api.com";

  //LEAGUES URLS
  static const GET_LEAGUES_NEW = "leagues/list";
  static const GET_LEAGUE_NEW = "leagues/";
  static const UPDATE_LEAGUES_NEW = "leagues/";
  static const DELETE_LEAGUES_NEW = "leagues/";
  static const CREATE_LEAGUES_NEW = "leagues";

  static const GET_LEAGUES = "leagues";
  static const GET_LEAGUES_KEYWORD = "leagues/keyword";
  static const CREATE_LEAGUE = "leagues/league";
  static const DELETE_LEAGUE = "leagues/league";
  static const UPDATE_LEAGUE = "/leagues/league/update";
  static const UPDATE_TEAM = "leagues/team/update";

  // GAMES URLS
  static const GET_GAMES_NEW = "scheduled-games/list/";
  static const GET_GAME_NEW = "scheduled-games/";
  static const UPDATE_GAME_NEW = "scheduled-games/";
  static const CREATE_GAME_NEW = "scheduled-games";
  static const DELETE_GAMES_NEW = "scheduled-games/";

  static const GET_GAMES = "games";
  static const CREATE_GAME = "games";
  static const DELETE_GAME = "games";
  static const GET_GAMES_KEYWORD = "games/keyword";

  static const UPDATE_GAME = "games/update";

  //ARENAS URLS
  static const GET_ARENAS = "arenas/list";
  static const CREATE_ARENA = "arenas";
  static const CREATE_COURT = "arenas/courts/";
  static const DELETE_ARENA = "arenas/";
  static const UPDATE_ARENA = "arenas/";
  static const DELETE_COURT = "arenas/courts/";
  static const UPDATE_COURT = "arenas/courts/";
  static const GET_COURT = "/arenas/courts/";

  //TEAM URLS
  static const CREATE_TEAM = "leagues/team";
  static const DELETE_TEAM = "leagues/team";
  static const DELETE_PLAYER = "leagues/player";

  //authentication
  static const AUTH_LOGIN = BASE_URL_SWAGGER + "/auth/login";
  static const AUTH_EXCHANGE = BASE_URL_SWAGGER + "/auth/exchange";
  static const USER_SIGNUP = BASE_URL_SWAGGER + "/users/signup";

  static String REGISTERDEVICE = BASE_URL_SWAGGER + "/devices/register";
  static String UNREGISTERDEVICE = BASE_URL_SWAGGER + "/devices/unregister";
  static String DEVICEATTACH = BASE_URL_SWAGGER + "/devices/attach";
  static String GAMESCHEDULE = BASE_URL_SWAGGER + "/account/games/schedule";

  static String GET_TEAMS = "teams/list";
}
