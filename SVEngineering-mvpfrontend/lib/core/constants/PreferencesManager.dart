import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  // static setPreferences(UserModel user, BuildContext context) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('userID', user.data!.id!.toInt());
  //   prefs.setString('token', user.bearerToken.toString());
  //   prefs.setString('name', user.data!.name.toString());
  //   prefs.setString('mobile', user.data!.mobile.toString());
  //   prefs.setString('email', user.data!.email.toString());
  //   prefs.setString('type', user.data!.type.toString());
  //   prefs.setString('image', user.data!.image.toString());
  //   prefs.setInt('bID', user.data!.business!.id.toInt());
  //   prefs.setString('bName', user.data!.business!.businessName.toString());
  //   prefs.setString('bCat', user.data!.business!.cateId.toString());
  //   prefs.setString('bAddress', user.data!.business!.address.toString());
  //   prefs.setString('bLat', user.data!.business!.lat.toString());
  //   prefs.setString('bLong', user.data!.business!.lon.toString());
  //   prefs.setString('status', user.data!.business!.status.toString());
  //   Provider.of<UserModel>(context, listen: false).updateCurrentUser(user.data);
  //   print('Setting the token in preferences : ${user.data!.bearerToken}');
  // }

  static setPreferences(List<String?> information) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', information[0].toString());
    prefs.setString('userId', information[1].toString());

    print('Setting the token in preferences : ${information[0]}');
  }

  static Future<List<String?>> get getPreferences async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return [prefs.getString('token'), prefs.getString('userId')];
  }

  // static Future<User> get getPreferences async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   return new User(
  //       id: prefs.getInt('userID'),
  //       bearerToken: prefs.getString('token'),
  //       name: prefs.getString('name'),
  //       email: prefs.getString('email'),
  //       type: prefs.getString('type'),
  //       image: prefs.getString('image'),
  //       business: new Business(
  //           id: prefs.getInt('bID')!.toInt(),
  //           userId: prefs.getInt('userID')!.toInt(),
  //           businessName: prefs.getString('bName'),
  //           cateId: prefs.getString('bCat'),
  //           address: prefs.getString('bAddress'),
  //           lat: prefs.getString('bLat'),
  //           lon: prefs.getString('bLong'),
  //           status: prefs.getString('status').toString(),
  //           createdAt: DateTime.now(),
  //           updatedAt: DateTime.now()));
  // }

  static Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
