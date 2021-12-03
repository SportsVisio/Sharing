import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/network/data_models/GameModelNew.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  final List<Arena> arenas;

  final Function(GameModel) onSelectGame;

  const GameCard(
      {Key? key,
      required this.game,
      required this.onSelectGame,
      required this.arenas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 130,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/players.png"),
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 4,
            direction: Axis.vertical,
            children: [
              Text(
                '${game.formattedStartDate} @ ${game.formattedStartTime} - ${game.formattedEndTime}',
                style: cardStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              if (game.court != null)
                Text(
                  '${getArena(game.court!.id)} @ ${game.court!.name}',
                  style: cardStyle,
                ),
              Text(
                '${game.league.name}',
                style: cardStyle,
              ),
              Text(
                '${game.teamGameAssn[0].team.name} vs ${game.teamGameAssn[1].team.name}',
                style: cardStyle,
              ),
            ],
          ),
        ),
        UIHelper.horizontalSpaceSm,
        Container(
          transform: Matrix4.translationValues(0, 20, 0),
          child: InkWell(
            onTap: () => onSelectGame(game),
            child: Icon(IconData(57882, fontFamily: 'MaterialIcons'),
                color: HexColor("#30BCED"), size: 30),
          ),
        )
      ],
    );
  }

  String getArena(courtId) {
    Arena? arena;
    for (Arena a in arenas) {
      if (a.courts.any((element) => element.id == courtId)) {
        arena = a;
        break;
      }
    }
    return arena != null ? arena.name : '';
  }
}
