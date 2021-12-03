import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Screens/Search/SearchForLeague/widgets/league_card.dart';
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
import 'package:sportvisio/utils/debouncer.dart';

class SearchForLeagueScreen extends StatefulWidget {
  const SearchForLeagueScreen({Key? key}) : super(key: key);

  @override
  _SearchForLeagueScreenState createState() => _SearchForLeagueScreenState();
}

class _SearchForLeagueScreenState extends State<SearchForLeagueScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _debouncer = Debouncer();
  late LeaguesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Consumer<LeaguesViewModel>(
      builder: (context, viewModel, child) {
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
                            Text('Search for\nLeague', style: heading3Style),
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
                                hint: "Search by state or league",
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
                              child: LeagueCard(
                                leaguesResponse:
                                    _viewModel.leaguesResponses[index],
                                onSelectLeague: (leagueResponse) {
                                  _navigationService
                                      .navigateTo(
                                        AppRoutes.UPDATE_LEAGUE,
                                        arguments: leagueResponse,
                                      )
                                      .then((value) => _viewModel.getLeagues());
                                },
                              ),
                            );
                          },
                          childCount: _viewModel.leaguesResponses.length,
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
                      onPressed: _handleAddLeague,
                      label: "Add New League and Teams",
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

  Widget errorView() => Text('An error occurred');

  void handleSearchFieldChange(String keyword) {
    _debouncer(() => keyword.isEmpty
        ? _viewModel.getLeagues()
        : _viewModel.getLeaguesKeyword({"Keyword": keyword}));
  }

  void _handleAddLeague() async {
    _navigationService
        .navigateTo(AppRoutes.ADD_LEAGUE)
        .then((value) => _viewModel.getLeagues());
  }
}
