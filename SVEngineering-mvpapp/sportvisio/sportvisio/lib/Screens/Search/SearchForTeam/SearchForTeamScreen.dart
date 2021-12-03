import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:sportvisio/Controller/Constants.dart';
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
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:sportvisio/network/data_models/league_model.dart';
import 'package:sportvisio/utils/debouncer.dart';

class SearchForTeamScreen extends StatefulWidget {
  const SearchForTeamScreen({Key? key}) : super(key: key);

  @override
  _SearchForTeamScreenState createState() => _SearchForTeamScreenState();
}

class _SearchForTeamScreenState extends State<SearchForTeamScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _debouncer = Debouncer();
  late LeaguesViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Consumer<LeaguesViewModel>(builder: (context, viewModel, child) {
      _viewModel = viewModel;
      return Scaffold(
        backgroundColor: HexColor("#EFEFEF"),
        body: Container(
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
                          Text('Search for\nTeam', style: heading3Style),
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
                              hint: "Search by team or player",
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
                              padding: const EdgeInsets.only(bottom: 0),
                              child: ListView.builder(
                                  itemCount: _viewModel
                                      .leaguesResponses[index].teams.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, mindex) {
                                    return TeamCard(
                                        leaguesResponse:
                                            _viewModel.leaguesResponses[index],
                                        onSelectLeague: (leagueResponse) {
                                          _navigationService
                                              .navigateTo(
                                                AppRoutes.UPDATE_TEAM,
                                                arguments: leagueResponse,
                                              )
                                              .then((value) =>
                                                  _viewModel.getLeagues());
                                        },
                                        teamIndex: mindex);
                                  }));
                        },
                        childCount: _viewModel.leaguesResponses.length,
                      ),
                    ),
                    SliverToBoxAdapter(child: UIHelper.verticalSpaceL)
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(20, statusBarHeight, 20, 16),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: PrimaryButton(
              //       onPressed: () {
              //         _navigationService.navigateTo(AppRoutes.ADD_TEAM);
              //       },
              //       label: "Add New Team",
              //     ),
              //   ),
              // ),

              _viewModel.loading ? LoadingWidget() : Container(),
              customBnner(navigationService: _navigationService),
            ],
          ),
        ),
      );
    });
  }

  void handleSearchFieldChange(String keyword) {
    _debouncer(() => keyword.isEmpty
        ? _viewModel.getLeagues()
        : _viewModel.getLeaguesKeyword({"Keyword": keyword}));
  }

  Container TeamCard(
      {required LeaguesResponse leaguesResponse,
      required Function(LeaguesResponse) onSelectLeague,
      var teamIndex}) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 130,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/players.png"))),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'regu',
                      fontSize: 10.0,
                      color: const Color(0xFFDE1C1C),
                      height: 1.0,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.16),
                          offset: Offset(0, 3.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    children: [
                      WidgetSpan(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "League: " +
                                      leaguesResponse.league.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                Text(
                                  "Team: " +
                                      leaguesResponse.teams[teamIndex].name,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                // Row(
                                //     children: leaguesResponse.players
                                //         .map((item) =>
                                //             new Text(item.name + ", "))
                                //         .toList())
                              ],
                            ),
                          ),
                          Container(
                            transform: Matrix4.translationValues(0, -15, 0),
                            child: InkWell(
                              onTap: () {
                                _navigationService
                                    .navigateTo(
                                      AppRoutes.UPDATE_TEAM,
                                      arguments: leaguesResponse,
                                    )
                                    .then((value) => _viewModel.getLeagues());
                              },
                              child: Image.asset(
                                "images/edit.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
