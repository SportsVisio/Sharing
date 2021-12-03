import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class customSearchDropdown extends StatelessWidget {
  List<String> _list;
  void Function(String?)? onChanged;
  String? selectedItem;
  customSearchDropdown(this._list, this.onChanged, {this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            child: DropdownSearch<String>(
                mode: Mode.DIALOG,
                showSearchBox: true,
                selectedItem: selectedItem != null ? selectedItem : null,
                hint: "League",
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                showAsSuffixIcons: true,
                dropDownButton: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: HexColor("#B8B8B8")),
                    child: Icon(MdiIcons.chevronDown, color: Colors.white)),
                //searchBoxDecoration: InputDecoration(hintText: "League name"),
                items: _list,
                //itemAsString: (String u) => u,
                onChanged: onChanged),
          ),
        )),
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {},
            child: SvgPicture.string(
              // Icon ionic-ios-add-circle-outline
              '<svg viewBox="0.0 0.0 50.0 50.0" ><path transform="translate(-1.62, -1.62)" d="M 40.31591796875 24.20349502563477 L 29.04478454589844 24.20349502563477 L 29.04478454589844 12.93236541748047 C 29.04478454589844 11.6010103225708 27.95549392700195 10.51171875 26.62413787841797 10.51171875 C 25.29278564453125 10.51171875 24.20349502563477 11.6010103225708 24.20349502563477 12.93236541748047 L 24.20349502563477 24.20349502563477 L 12.93236541748047 24.20349502563477 C 11.6010103225708 24.20349502563477 10.51171875 25.11123657226562 10.51171875 26.62413787841797 C 10.51171875 28.13704299926758 11.64639759063721 29.04478454589844 12.93236541748047 29.04478454589844 C 14.21833324432373 29.04478454589844 24.20349502563477 29.04478454589844 24.20349502563477 29.04478454589844 C 24.20349502563477 29.04478454589844 24.20349502563477 38.87865829467773 24.20349502563477 40.31591796875 C 24.20349502563477 41.75317764282227 25.26252746582031 42.7365608215332 26.62413787841797 42.7365608215332 C 27.98575592041016 42.7365608215332 29.04478454589844 41.64727020263672 29.04478454589844 40.31591796875 L 29.04478454589844 29.04478454589844 L 40.31591796875 29.04478454589844 C 41.64727020263672 29.04478454589844 42.7365608215332 27.95549392700195 42.7365608215332 26.62413787841797 C 42.7365608215332 25.29278564453125 41.64727020263672 24.20349502563477 40.31591796875 24.20349502563477 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-3.38, -3.38)" d="M 28.37499809265137 6.740385055541992 C 34.15625 6.740385055541992 39.58893966674805 8.987980842590332 43.67548370361328 13.07451915740967 C 47.76202011108398 17.16106033325195 50.00961303710938 22.59374809265137 50.00961303710938 28.37499809265137 C 50.00961303710938 34.15625 47.76202011108398 39.58893966674805 43.67548370361328 43.67548370361328 C 39.58893966674805 47.76202011108398 34.15625 50.00961303710938 28.37499809265137 50.00961303710938 C 22.59374809265137 50.00961303710938 17.16106033325195 47.76202011108398 13.07451915740967 43.67548370361328 C 8.987980842590332 39.58893966674805 6.740385055541992 34.15625 6.740385055541992 28.37499809265137 C 6.740385055541992 22.59375190734863 8.987980842590332 17.16106033325195 13.07451915740967 13.07451915740967 C 17.16106033325195 8.987980842590332 22.59374809265137 6.740385055541992 28.37499809265137 6.740385055541992 M 28.37499809265137 3.375000238418579 C 14.56490325927734 3.375000238418579 3.375000238418579 14.56490325927734 3.375000238418579 28.37499809265137 C 3.375000238418579 42.18509674072266 14.56490325927734 53.375 28.37499809265137 53.375 C 42.18509674072266 53.375 53.375 42.18509674072266 53.375 28.37499809265137 C 53.375 14.56490135192871 42.18509674072266 3.375000238418579 28.37499809265137 3.375000238418579 L 28.37499809265137 3.375000238418579 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 50.0,
              height: 50.0,
            ),
          ),
        )
      ]),
    );
  }
}
