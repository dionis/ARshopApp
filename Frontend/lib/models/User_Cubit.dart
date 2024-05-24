// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'User.dart';

// class UserCubit extends Cubit<User> {
//   UserCubit(super.initialState);
// }

import 'package:flutter/material.dart';

import 'User.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

  User get getUser => _user;

  setUser(User newList) {
    _user = newList;
    notifyListeners();
  }
}
