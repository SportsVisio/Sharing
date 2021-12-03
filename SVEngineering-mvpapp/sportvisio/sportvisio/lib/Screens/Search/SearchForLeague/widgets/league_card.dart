import 'package:flutter/material.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/network/data_models/league_model.dart';

class LeagueCard extends StatelessWidget {
  final LeaguesResponse leaguesResponse;

  final Function(LeaguesResponse) onSelectLeague;

  const LeagueCard({
    Key? key,
    required this.leaguesResponse,
    required this.onSelectLeague,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 130,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/players.png"),
            ),
          ),
        ),
        UIHelper.horizontalSpaceSm,
        Expanded(child: Text(' ${leaguesResponse.league}', style: cardStyle)),
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: InkWell(
            onTap: () => onSelectLeague(leaguesResponse),
            child: Image.asset(
              "images/edit.png",
              width: 20,
              height: 20,
            ),
          ),
        )
      ],
    );
  }
}
