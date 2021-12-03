import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Arena/UpdateArenaScreen.dart';
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
import 'package:sportvisio/utils/debouncer.dart';

class SearchForArenaScreen extends StatefulWidget {
  const SearchForArenaScreen({Key? key}) : super(key: key);

  @override
  _SearchForArenaScreenState createState() => _SearchForArenaScreenState();
}

class _SearchForArenaScreenState extends State<SearchForArenaScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _debouncer = Debouncer();
  var token;
  late ArenaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    this.setToken();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Consumer<ArenaViewModel>(
      builder: (context, viewModel, child) {
        _viewModel = viewModel;
        return Scaffold(
          backgroundColor: HexColor("#EFEFEF"),
          body: Container(
            child: Stack(
              children: [
                BackgroundIconSearch(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 60, 20, 16),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Search for Arena and Courts',
                                style: heading3Style),
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
                                hint: "Search by Arena or Court",
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
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 130,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "images/players.png"))),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            UIHelper.verticalSpaceSm,
                                            Text.rich(
                                              TextSpan(
                                                style: TextStyle(
                                                  fontFamily: 'regu',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  height: 1.0,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.16),
                                                      offset: Offset(0, 3.0),
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${_viewModel.arenas[index].name}\n',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          _viewModel
                                                              .arenas[index]
                                                              .courts
                                                              .join(" , "),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        transform: Matrix4
                                                            .translationValues(
                                                                0, 0, 0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            _navigationService
                                                                .navigateTo(
                                                              AppRoutes
                                                                  .UPDATE_ARENA,
                                                              arguments: UpdateArenaScreen(
                                                                  isAdd: false,
                                                                  arenaModel:
                                                                      _viewModel
                                                                              .arenas[
                                                                          index]),
                                                            );
                                                          },
                                                          child: Icon(
                                                              IconData(57882,
                                                                  fontFamily:
                                                                      'MaterialIcons'),
                                                              color: HexColor(
                                                                  "#30BCED"),
                                                              size: 30),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          childCount: _viewModel.arenas.length,
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
                      onPressed: () {
                        _navigationService
                            .navigateTo(AppRoutes.ADD_ARENA)
                            .then((value) => _viewModel.getArenas());
                      },
                      label: "Add New Arena and Court",
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

  void setToken() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token");
    });
  }

  void handleSearchFieldChange(String keyword) {
    _debouncer(() => keyword.isEmpty
        ? _viewModel.getArenas()
        : _viewModel.getArenasKeyword(keyword, true));
  }
}
