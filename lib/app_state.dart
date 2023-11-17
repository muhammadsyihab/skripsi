import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _isOperator = '4';
  String get isOperator => _isOperator;
  set isOperator(String _value) {
    _isOperator = _value;
  }

  String _userName = '';
  String get userName => _userName;
  set userName(String _value) {
    _userName = _value;
  }
  String _role = '';
  String get role => _role;
  set role(String _value) {
    _role = _value;
  }
  String _idUsers = '';
  String get idUsers => _idUsers;
  set idUsers(String _value) {
    _idUsers = _value;
  }
  String _latLong = '';
  String get latLong => _latLong;
  set latLong(String _value) {
    _latLong = _value;
  }

  String _page = '';
  String get page => _page;
  set page(String _value) {
    _page = _value;
  }

  String _authtoken = '';
  String get authtoken => _authtoken;
  set authtoken(String _value) {
    _authtoken = _value;
  }

  String _email = '';
  String get email => _email;
  set email(String _value) {
    _email = _value;
  }
  String _noTelp = '';
  String get noTelp => _noTelp;
  set noTelp(String _value) {
    _noTelp = _value;
  }
  String _password = '';
  String get password => _password;
  set password(String _value) {
    _password = _value;
  }
  String _urlaneka = '';
  String get urlaneka => _urlaneka;
  set urlaneka(String _value) {
    _urlaneka = _value;
  }

  int _ticketId = 0;
  int get ticketId => _ticketId;
  set ticketId(int _value) {
    _ticketId = _value;
  }

  String _statusdaily = '';
  String get statusdaily => _statusdaily;
  set statusdaily(String _value) {
    _statusdaily = _value;
  }

  String _photoUrltmp = '';
  String get photoUrltmp => _photoUrltmp;
  set photoUrltmp(String _value) {
    _photoUrltmp = _value;
  }

  String _photoTmp = '';
  String get photoTmp => _photoTmp;
  set photoTmp(String _value) {
    _photoTmp = _value;
  }

  String _isNull = 'null';
  String get isNull => _isNull;
  set isNull(String _value) {
    _isNull = _value;
  }
  String _IDTICKETSS = 'null';
  String get IDTICKETSS => _IDTICKETSS;
  set IDTICKETSS(String _value) {
    _IDTICKETSS = _value;
  }
  String _UrlPost = 'http://192.168.1.17:8000';
  String get UrlPost => _UrlPost;
  set UrlPost(String _value) {
    _UrlPost = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
