import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/Screens/Search/SearchForGame/widgets/game_card.dart';
import 'package:sportvisio/Widgets/CustomTextField.dart';
import 'package:sportvisio/Widgets/background_icons/background_icon_search.dart';
import 'package:sportvisio/Widgets/buttons/primary_button.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/loading_widget.dart';
import 'package:sportvisio/Widgets/sliver_appbar_delegate.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/core/view_models/arena_viewModel.dart';
import 'package:sportvisio/core/view_models/games_viewModel.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/utils/debouncer.dart';

class SearchForGameScreen extends StatefulWidget {
  const SearchForGameScreen({Key? key}) : super(key: key);

  @override
  _SearchForGameScreenState createState() => _SearchForGameScreenState();
}

class _SearchForGameScreenState extends State<SearchForGameScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _debouncer = Debouncer();
  late GamesViewModel _viewModel;
  var token;
  var accountId;
  List<Arena> _arenas = [];

  @override
  void initState() {
    super.initState();
    getPref();
    Provider.of<ArenaViewModel>(context, listen: false)
        .getArenas()
        .then((value) {
      _arenas = value;
    });

    // final postMdl = Provider.of<GamesViewModel>(context, listen: false);
    // postMdl.registerDevice().then((value) {});
  }

  void getPref() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token");
      accountId = pref.getString("id");
    });
    String deviceid = await DeviceId.getID;
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    String startTimeStamp = timeStamp.toString();
    String endTimeStamp = (timeStamp + 1).toString();

    var payload = {
      "accountId": "",
      "deviceId": deviceid + startTimeStamp,
      "name": "video" + startTimeStamp + endTimeStamp
    };
    final postMdl = Provider.of<GamesViewModel>(context, listen: false);
    postMdl.registerDevice(token, payload).then((value) {
      print(value.body.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Consumer<GamesViewModel>(
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
          backgroundColor: HexColor("#EFEFEF"),
          body: Container(
            //  padding: EdgeInsets.fromLTRB(20, statusBarHeight, 20, 16),
            child: Stack(
              children: [
                BackgroundIconSearch(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, statusBarHeight, 20, 16),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Search for Games', style: heading3Style),
                            UIHelper.verticalSpaceSm,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          maxHeight: 60,
                          minHeight: 60,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextField(
                                hint: "Search by date or team",
                                onChanged: handleSearchFieldChange,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                onTap: () {
                                  // var payload = {
                                  //   "description": "string",
                                  //   "leagueId":
                                  //       _viewModel.gamesResponses[index].league,
                                  //   "courtId":
                                  //       _viewModel.gamesResponses[index].court,
                                  //   "teams":
                                  //       _viewModel.gamesResponses[index].teams,
                                  //   "startTime": "1630969121",
                                  //   "endTime": (1630969121 + 1).toString(),
                                  //   "accountId": accountId.toString()
                                  // };
                                  // print(payload);
                                  // _viewModel.SheduleGame(token, payload)
                                  //     .then((value) {
                                  //   print(value.body.toString());
                                  // });
                                },
                                child: GameCard(
                                  game: _viewModel.gameResponses[index],
                                  arenas: _arenas,
                                  onSelectGame: (gameResponse) {
                                    _navigationService
                                        .navigateTo(
                                          AppRoutes.UPDATE_GAME,
                                          arguments: gameResponse,
                                        )
                                        .then((value) =>
                                            _viewModel.getGamesNew());
                                  },
                                ),
                              ),
                            );
                          },
                          childCount: _viewModel.gameResponses.length,
                        ),
                      ),
                      SliverToBoxAdapter(child: UIHelper.verticalSpaceL)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, statusBarHeight, 20, 16),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: PrimaryButton(
                      onPressed: _handleAddGame,
                      label: "Add New Game",
                    ),
                  ),
                ),
                _viewModel.loading ? LoadingWidget() : Container(),
                customBnner(navigationService: _navigationService),
              ],
            ),
          ),
        );
      },
    );
  }

  void handleSearchFieldChange(String keyword) {
    _debouncer(() => keyword.isEmpty
        ? _viewModel.getGamesNew()
        : _viewModel.getGamesNewKeyword(keyword));
  }

  void _handleAddGame() async {
    _navigationService.navigateTo(AppRoutes.ADD_GAME).then((value) async {
      _viewModel.getGamesNew();
    });
  }
}
