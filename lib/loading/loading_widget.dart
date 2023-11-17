

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:aneka/shared_pref.dart';

import '../backend/api_requests/api_calls.dart';
import '../backend/api_requests/api_manager.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../halaman_login/halaman_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../menu_mekanik/menu_mekanik_widget.dart';
import '../menu_operatorv2/menu_operatorv2_widget.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? getUrl;

  @override
  void initState(){
    super.initState();
    main();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      WidgetsFlutterBinding.ensureInitialized();
      await Future.delayed(const Duration(milliseconds: 2000));
      setState(() {

        autoLogIn();
      });
      //   // await Navigator.push(
      //   //   context,
      //   //   MaterialPageRoute(
      //   //     builder: (context) => HalamanLoginWidget(),
      //   //   ),
      //   // );
    });
  }
  void main() async {
    String url =
        "https://neumedira.com/public/anekaUrl.json";
    final response = await http.get(Uri.parse(url));
    // print(response.body);

    Root userDetails = Root.fromJson(jsonDecode(response.body));
    // print(userDetails.anekBaseUrl);

    getUrl = userDetails.anekBaseUrl;
    // print('asdsad : $getUrl');

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final key = 'kUrl';
      final value = getUrl!;
      prefs.setString(key, value);
      // print('save : $value');
      final String? kUrl = prefs.getString('kUrl');
      FFAppState().update(() {
        FFAppState().urlaneka = kUrl!;
        print(FFAppState().urlaneka);
      });

    });

  }

  void autoLogIn() async {

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final role = pref.getString('kRole');
    final authToken = pref.getString('kToken');

    if (authToken != null) {
      setState(() async {
        if (role == '4') {
          GetUser.updateUser();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuOperatorv2Widget(),
            ),
          );
        } else {
          GetUser.updateUser();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuMekanikWidget(),
            ),
          );
        }
      });
      return;
    }
    else {
      setState(() async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HalamanLoginWidget(),
          ),
        );
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E2429),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(),
      ),
    );
  }
}

class Root {
  String? anekBaseUrl;

  Root({this.anekBaseUrl});

  Root.fromJson(Map<String, dynamic> json) {
    anekBaseUrl = json['aneka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['aneka'] = anekBaseUrl;
    return data;
  }
}