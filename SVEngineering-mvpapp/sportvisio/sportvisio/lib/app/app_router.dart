import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Arena/AddArenaScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Arena/UpdateArenaScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Camera/UpdateCameraScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/ArenaConfirmation/ArenaDeleteConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/CameraConfirmation/CameraUpdateConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/GameConfirmation/GameDeleteConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/LeagueConfirmation/LeagueAddConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/LeagueConfirmation/LeagueDeleteConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/LeagueConfirmation/LeagueUpdateConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/TeamConfirmation/TeamAddConfirmation.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/TeamConfirmation/TeamDeleteConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Confirmation/TeamConfirmation/TeamUpdateConfirmationScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Game/AddGameScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Game/UpdateGameScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/League/AddLeagueScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/League/UpdateLeagueScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Team/AddTeamScreen.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Team/UpdateTeamScreen.dart';
import 'package:sportvisio/Screens/CameraMessageStatusScreen.dart/CameraMessageStatusScreen.dart';
import 'package:sportvisio/Screens/CameraPlacement/CameraPlacementScreen.dart';
import 'package:sportvisio/Screens/EmailVerificationScreen.dart/EmailVerificationScreen.dart';
import 'package:sportvisio/Screens/LiveStream/LiveStreamPlayConfirmation.dart';
import 'package:sportvisio/Screens/LiveStream/LiveStreamScreen.dart';
import 'package:sportvisio/Screens/Login/LoginScreen.dart';
import 'package:sportvisio/Screens/MainMenu/MainMenuScreen.dart';
import 'package:sportvisio/Screens/Registration/RegisterScreen.dart';
import 'package:sportvisio/Screens/ResetPassword/ResetPasswordConfirmScreen.dart';
import 'package:sportvisio/Screens/ResetPassword/ResetPasswordScreen.dart';
import 'package:sportvisio/Screens/RecordSetup/RecordSetupScreen.dart';
import 'package:sportvisio/Screens/Search/SearchForArena/SearchForArenaScreen.dart';
import 'package:sportvisio/Screens/Search/SearchForGame/SearchForGameScreen.dart';
import 'package:sportvisio/Screens/Search/SearchForLeague/SearchForLeagueScreen.dart';
import 'package:sportvisio/Screens/Search/SearchForTeam/SearchForTeamScreen.dart';
import 'package:sportvisio/Screens/SplashScreen.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/data_models/live_stream_play_confirmation_arguments.dart';
import 'package:sportvisio/core/helpers/User.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/network/data_models/GameModelNew.dart';
import 'package:sportvisio/network/data_models/league_model.dart';
import 'package:sportvisio/network/data_models/team_updateModel.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AppRoutes.LOGIN:
        return PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.rightToLeft,
            child: LoginScreen(),
            duration: Duration(milliseconds: 1200));

      case AppRoutes.MAIN_MENU:
        return MaterialPageRoute(builder: (_) => MainMenuScreen());
      case AppRoutes.EMAIL_VERIFICATION:
        User user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => EmailVerificationScreen(user));

      case AppRoutes.CAMERA_MESSAGE_STATUS:
        return MaterialPageRoute(builder: (_) => CameraMessageStatusScreen());

      case AppRoutes.SETUP_RECORD:
        return MaterialPageRoute(builder: (_) => RecordSetupScreen());

      case AppRoutes.LIVE_STREAM:
        return MaterialPageRoute(builder: (_) => LiveStreamScreen());

      case AppRoutes.CAMERA_PLACEMENT:
        {
          return MaterialPageRoute(builder: (_) => CameraPlacement());
        }

      case AppRoutes.LIVE_STREAM_PLAY_CONFIRMATION:
        {
          final args =
              settings.arguments as LiveStreamPlayConfirmationArguments;

          return MaterialPageRoute(
            builder: (_) => LiveStreamPlayConfirmationScreen(
              isPlay: args.isPlay,
              callback: args.callback,
            ),
          );
        }

      case AppRoutes.REGISTER:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case AppRoutes.RESET_PASSWORD:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());

      case AppRoutes.RESET_PASSWORD_CONFIRMATION:
        return MaterialPageRoute(builder: (_) => ResetPasswordConfirmScreen());

      case AppRoutes.UPDATE_CAMERA:
        return MaterialPageRoute(builder: (_) => UpdateCameraScreen());

      case AppRoutes.UPDATE_CAMERA_CONFIRMATION:
        return MaterialPageRoute(
            builder: (_) => CameraUpdateConfirmationScreen());

      //GAME ROUTES
      case AppRoutes.SEARCH_GAME:
        return MaterialPageRoute(builder: (_) => SearchForGameScreen());

      case AppRoutes.ADD_GAME:
        return MaterialPageRoute(builder: (_) => AddGameScreen());

      case AppRoutes.UPDATE_GAME:
        {
          GameModel _gamesResponse = settings.arguments as GameModel;
          return MaterialPageRoute(
            builder: (_) => UpdateGameScreen(gameModel: _gamesResponse),
          );
        }

      case AppRoutes.DELETE_GAME_CONFIRMATION:
        {
          GameModel _gameResponse = settings.arguments as GameModel;
          return MaterialPageRoute(
            builder: (_) => GameDeleteConfirmationScreen(
              gameModel: _gameResponse,
            ),
          );
        }

      //TEAM ROUTES
      case AppRoutes.SEARCH_TEAM:
        return MaterialPageRoute(builder: (_) => SearchForTeamScreen());

      case AppRoutes.ADD_TEAM:
        final leagueName = settings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => AddTeamScreen(
                  leagueName: leagueName,
                ));

      case AppRoutes.UPDATE_TEAM:
        final _leaguesResponse = settings.arguments as LeaguesResponse;

        return MaterialPageRoute(
            builder: (_) => UpdateTeamScreen(
                  leaguesResponse: _leaguesResponse,
                ));

      case AppRoutes.UPDATE_TEAM_CONFIRMATION:
        final _model = settings.arguments as TeamUpdateResponse;

        return MaterialPageRoute(
            builder: (_) => TeamUpdateConfirmationScreen(_model));
      case AppRoutes.ADD_TEAM_CONFIRMATION:
        return MaterialPageRoute(builder: (_) => TeamAddConfirmation());

      case AppRoutes.DELETE_TEAM_CONFIRMATION:
        return MaterialPageRoute(
            builder: (_) => TeamDeleteConfirmationScreen());

      //ARENA ROUTES
      case AppRoutes.SEARCH_ARENA:
        return MaterialPageRoute(builder: (_) => SearchForArenaScreen());

      case AppRoutes.ADD_ARENA:
        return MaterialPageRoute(builder: (_) => AddArenaScreen());

      case AppRoutes.UPDATE_ARENA:
        {
          UpdateArenaScreen arguments = settings.arguments as UpdateArenaScreen;

          return MaterialPageRoute(
              builder: (_) => UpdateArenaScreen(
                    isAdd: arguments.isAdd,
                    arenaModel: arguments.arenaModel,
                  ));
        }

      case AppRoutes.DELETE_ARENA_CONFIRMATION:
        Arena arguments = settings.arguments as Arena;

        return MaterialPageRoute(
          builder: (_) => ArenaDeleteConfirmationScreen(
            arenaModel: arguments,
          ),
        );

      //LEAGUE ROUTES
      case AppRoutes.SEARCH_LEAGUE:
        return MaterialPageRoute(builder: (_) => SearchForLeagueScreen());

      case AppRoutes.ADD_LEAGUE:
        return MaterialPageRoute(builder: (_) => AddLeagueScreen());

      case AppRoutes.UPDATE_LEAGUE:
        {
          final _leaguesResponse = settings.arguments as LeaguesResponse;
          return MaterialPageRoute(
            builder: (_) => UpdateLeagueScreen(
              leaguesResponse: _leaguesResponse,
            ),
          );
        }

      case AppRoutes.ADD_LEAGUE_CONFIRMATION:
        return MaterialPageRoute(builder: (_) => LeagueAddConfirmationScreen());

      case AppRoutes.UPDATE_LEAGUE_CONFIRMATION:
        final payload = settings.arguments as List<LeaguesResponse>;
        return MaterialPageRoute(
          builder: (_) => LeagueUpdateConfirmationScreen(
            leagueResponse: payload[0],
            leagueResponseNew: payload[1],
          ),
        );

      case AppRoutes.DELETE_LEAGUE_CONFIRMATION:
        final payload = settings.arguments as List<LeaguesResponse>;
        return MaterialPageRoute(
            builder: (_) =>
                LeagueDeleteConfirmationScreen(leaguesResponse: payload[0]));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
