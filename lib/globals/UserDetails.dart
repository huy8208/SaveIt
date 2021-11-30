import 'package:budget_tracker_ui/pages/sign_in_page.dart';

class UserDetails {
  static var uid = null;
  Future<String> getCurrentUID() async {
    return (await SignInPage.userCredentials.currentUser)!.uid;
  }
}
