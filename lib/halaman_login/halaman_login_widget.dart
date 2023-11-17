import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../menu_mekanik/menu_mekanik_widget.dart';
import '../menu_operatorv2/menu_operatorv2_widget.dart';
import '../shared_pref.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HalamanLoginWidget extends StatefulWidget {
  const HalamanLoginWidget({Key? key}) : super(key: key);

  @override
  _HalamanLoginWidgetState createState() => _HalamanLoginWidgetState();
}

class _HalamanLoginWidgetState extends State<HalamanLoginWidget> {
  ApiCallResponse? loginResult;
  TextEditingController? emailAddressController;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    emailAddressController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Marielle_Price.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 420, 0, 0),
                    child: TextFormField(
                      controller: emailAddressController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'manegement@neumedira.com',
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyText2
                            .override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(
                            8, 12, 0, 24),
                        suffixIcon:
                        emailAddressController!.text.isNotEmpty
                            ? InkWell(
                          onTap: () async {
                            emailAddressController?.clear();
                            setState(() {});
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 22,
                          ),
                        )
                            : null,
                      ),
                      style: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                        fontFamily: 'Outfit',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        hintText: '************',
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyText2
                            .override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            8, 12, 0, 24),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                                () => passwordVisibility =
                            !passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF57636C),
                            size: 22,
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF0F1113),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      minLines: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            loginResult = await LoginCall.call(
                              email: emailAddressController!.text,
                              password: passwordController!.text,
                            );
                            if ((loginResult?.succeeded ?? true)) {
                              FFAppState().update(() {
                                FFAppState().authtoken = getJsonField(
                                  (loginResult?.jsonBody ?? ''),
                                  r'''$.access_token''',
                                ).toString();
                                FFAppState().userName = LoginCall.userName(
                                  (loginResult?.jsonBody ?? ''),
                                ).toString();
                                FFAppState().noTelp = LoginCall.userTelp(
                                  (loginResult?.jsonBody ?? ''),
                                ).toString();
                                FFAppState().role = LoginCall.userRole(
                                  (loginResult?.jsonBody ?? ''),
                                ).toString();
                                FFAppState().email = LoginCall.useremail(
                                  (loginResult?.jsonBody ?? ''),
                                ).toString();
                                FFAppState().password = LoginCall.useremail(
                                  (loginResult?.jsonBody ?? ''),
                                ).toString();
                                FFAppState().idUsers = LoginCall.idUser(
                                  (loginResult?.jsonBody ?? ''),
                                ).toString();

                              });
                              //Save User Local Storage
                              SaveUser.saveAuthToken();
                              SaveUser.saveEmail();
                              SaveUser.saveNoTelp();
                              SaveUser.savePassword();
                              SaveUser.saveRole();
                              SaveUser.saveUserName();
                              SaveUser.saveIdUser();

                              if (LoginCall.userRole(
                                (loginResult?.jsonBody ?? ''),
                              ).toString() ==
                                  '4') {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MenuOperatorv2Widget(),
                                  ),
                                );
                              } else {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuMekanikWidget(),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Gagal melakukan login',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                                ),
                              );
                            }

                            setState(() {});
                          },
                          text: 'Login',
                          options: FFButtonOptions(
                            width: 313,
                            height: 50,
                            color: Color(0xFF1C51D8),
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle1
                                .override(
                              fontFamily: 'Outfit',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox.fromSize(size: Size.fromHeight(25),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}


