import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/User.dart';
import '../../models/User_Cubit.dart';
import '../components/Body.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late User user;
  @override
  void initState() {
    super.initState();
    user = context.read<UserProvider>().getUser;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: MyBody(user: user),
    );
  }
}
