class ApiEndPoints {
  // static const BASE_URL =
  //     "https://e0gcs528ad.execute-api.us-east-1.amazonaws.com/Prod/";

  static const BASE_URL =
      "https://e0gcs528ad.execute-api.us-east-1.amazonaws.com/Prod_V2/";

  static const BASE_URL_SWAGGER = "https://dev.sportsvisio-api.com";

  //LEAGUES URLS
  // static const GET_LEAGUES = "leagues";
  // static const GET_LEAGUES_KEYWORD = "leagues/keyword";
  // static const CREATE_LEAGUE = "leagues/league";
  // static const DELETE_LEAGUE = "leagues/league";
  // static const UPDATE_LEAGUE = "leagues/update";
  // static const UPDATE_TEAM = "leagues/team/update";

  // static const GET_GAMES = "games";
  // static const CREATE_GAME = "games";
  // static const DELETE_GAME = "games";
  // static const GET_GAMES_KEYWORD = "games/keyword";

  // static const UPDATE_GAME = "games/update";

  // //ARENAS URLS
  // static const GET_ARENAS = "arenas";
  // static const GET_ARENAS_KEYWORD = "arenas/keyword";
  // static const CREATE_ARENA = "arenas/arena";
  // static const DELETE_ARENA = "arenas/arena";
  // static const DELETE_COURT = "arenas/court";
  // static const CREATE_COURT = "arenas/court";
  // static const UPDATE_ARENA = "arenas/update";

  //TEAM URLS
  static const CREATE_TEAM = "leagues/team";
  static const DELETE_TEAM = "leagues/team";
  static const DELETE_PLAYER = "leagues/player";
  static const ADDLEAGUE = "";

  //authentication
  static const AUTH_LOGIN = BASE_URL_SWAGGER + "/auth/login";
  static const AUTH_EXCHANGE = BASE_URL_SWAGGER + "/auth/exchange";
  static const USER_SIGNUP = BASE_URL_SWAGGER + "/users/signup";
  static const FORGOTPASSWORD = BASE_URL_SWAGGER + "/users/recover";
  static const GETCURRENTUSER = BASE_URL_SWAGGER + "/users";

  //player profile
  static const GETPLAYERPROFILE = BASE_URL_SWAGGER + "/player-profiles";
  static const GETFOLLOWEDPROFILES =
      BASE_URL_SWAGGER + "/player-profiles/following";

  static const FOLLOWAPLAYER = BASE_URL_SWAGGER + "/player-profiles/follow";
  static const UNFOLLOWAPLAYER = BASE_URL_SWAGGER + "/player-profiles/unfollow";
  static const CLAIMTEAMPLAYER = BASE_URL_SWAGGER + "/player-profiles/claim/";
  static const GETSTATS = BASE_URL + "/player-profiles/stats";
  static const SEARCHPROFILE = BASE_URL + "/player-profiles/search";

  //teams
  static const GETALLTEAMS = BASE_URL + "/teams/list";

  //ForgotPassword
}
