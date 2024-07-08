import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/size_config.dart';
import '../components/body.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: kprimaryColor,
      body: MyBody(),
    );
  }
}
