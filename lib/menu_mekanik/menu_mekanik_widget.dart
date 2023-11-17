import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../chatv2/chatsv2.dart';
import '../daftar_catatan_daily_mekanik/daftar_catatan_daily_mekanik_widget.dart';
import '../daftar_catatan_daily_operator/daftar_catatan_daily_operator_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../menu_operatorv2/menu_operatorv2_widget.dart';
import '../notifikasi_mekanik/notifikasi_mekanik_widget.dart';
import '../profile_mekanik/profile_mekanik_widget.dart';
import '../repai_repor_m_e_k_a_n_i_k/repai_repor_m_e_k_a_n_i_k_widget.dart';
import '../support/support_widget.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuMekanikWidget extends StatefulWidget {
  const MenuMekanikWidget({Key? key}) : super(key: key);

  @override
  _MenuMekanikWidgetState createState() => _MenuMekanikWidgetState();
}

class _MenuMekanikWidgetState extends State<MenuMekanikWidget> {
  ApiCallResponse? getTask;
  Completer<ApiCallResponse>? _apiRequestCompleter;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7B54),
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: FlutterFlowTheme.of(context).title2.override(
            fontFamily: 'Lato',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotifikasiMekanikWidget(),
                ),
              );
            },
            child: Icon(
              Icons.notifications,
              color: FlutterFlowTheme.of(context).primaryBtnText,
              size: 24,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 7, 0),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileMekanikWidget(),
                  ),
                );
              },
              child: Icon(
                Icons.person,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Welcome,',
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 0, 0),
                                  child: Text(
                                    FFAppState().userName,
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF1C51D8),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 4, 0, 0),
                                child: Text(
                                  'Selamat beraktifitas kembali.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                color: Color(0x4B1A1F24),
                                offset: Offset(0, 2),
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF4B39EF),
                                Color(0xFFEE8B60)
                              ],
                              stops: [0, 1],
                              begin: AlignmentDirectional(0.94, -1),
                              end: AlignmentDirectional(-0.94, 1),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 24, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      dateTimeFormat(
                                        'MMMMEEEEd',
                                        getCurrentTimestamp,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 8, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FutureBuilder<ApiCallResponse>(
                                      future: GetTaskCall.call(
                                        authtoken: FFAppState().authtoken,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child:
                                              CircularProgressIndicator(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          );
                                        }
                                        final textGetMekanikTaskResponse =
                                        snapshot.data!;
                                        return Text(
                                          GetTaskCall.task(
                                            textGetMekanikTaskResponse
                                                .jsonBody,
                                          ).toString() == 'null' ? 'Task' : GetTaskCall.task(
                                            textGetMekanikTaskResponse
                                                .jsonBody,
                                          ).toString(),
                                          style: FlutterFlowTheme.of(
                                              context)
                                              .title1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 12, 20, 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '05/25',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                        fontFamily: 'Roboto Mono',
                                        color: Color(0x00FFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() => _apiRequestCompleter = null);
                      await waitForApiRequestCompleter();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.width * 0.98,
                            height: MediaQuery.of(context).size.height * 0.480,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).overlay30,
                            ),
                            child: FutureBuilder<ApiCallResponse>(
                              future: (_apiRequestCompleter ??=
                              Completer<ApiCallResponse>()
                                ..complete(GetticketsCall.call(
                                  authtoken: FFAppState().authtoken,
                                )))
                                  .future,
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.data != null) {
                                    final listViewGetticketsResponse =
                                    snapshot.data!;
                                    return Builder(
                                      builder: (context) {
                                        final listKerusakanMekanikLV = getJsonField(
                                          listViewGetticketsResponse.jsonBody,
                                          r'''$.datas''',
                                        ).toList().take(10).toList();
                                        return RefreshIndicator(
                                          onRefresh: () async {
                                            setState(() =>
                                            _apiRequestCompleter = null);
                                            await waitForApiRequestCompleter();
                                          },
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: listKerusakanMekanikLV.length,
                                            itemBuilder: (context,
                                                listKerusakanMekanikLVIndex) {
                                              final listKerusakanMekanikLVItem =
                                              listKerusakanMekanikLV[
                                              listKerusakanMekanikLVIndex];
                                              return Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 5, 12, 0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    FFAppState().update(() {
                                                      FFAppState().IDTICKETSS = getJsonField(
                                                        listKerusakanMekanikLVItem,
                                                        r'''$.id''',
                                                      ).toString();
                                                    });
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => Chatv2Widget(
                                                          ticketid: FFAppState().IDTICKETSS,
                                                        ),
                                                      ),
                                                    );
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          FFAppState().IDTICKETSS,
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                          ),
                                                        ),
                                                        duration: Duration(milliseconds: 4000),
                                                        backgroundColor: Color(0x00000000),
                                                      ),
                                                    );
                                                  },
                                                  child: Card(
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    color: Color(0xFFF5F5F5),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                          AlignmentDirectional(-1, 0),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                                12, 4, 12, 4),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Align(
                                                                  alignment: AlignmentDirectional(-0.05, 0),
                                                                  child: Padding(
                                                                    padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0, 4, 0, 0),
                                                                    child: Text(
                                                                      getJsonField(
                                                                        listKerusakanMekanikLVItem,
                                                                        r'''$.waktu_insiden''',
                                                                      ).toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyText2
                                                                          .override(
                                                                        fontFamily: 'Lexend Deca',
                                                                        color: Color(
                                                                            0xFF0A55C0),
                                                                        fontSize: 14,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Row(children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 12),
                                                            child: Text("ID Tickets   : #00",style: FlutterFlowTheme.of(context).bodyText1.override(
                                                              fontFamily: 'Poppins',
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w900,
                                                            ),),
                                                          ),
                                                          Text(
                                                            getJsonField(
                                                              listKerusakanMekanikLVItem,
                                                              r'''$.id''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                              fontFamily: 'Poppins',
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w900,
                                                            ),
                                                          ),
                                                        ],),
                                                        Divider(
                                                          thickness: 1,
                                                          color: Colors.black,
                                                        ),
                                                        Container(
                                                          width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.85,
                                                          height: 1,
                                                          decoration: BoxDecoration(
                                                            color: Color(0xFFF1F4F8),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              12, 5, 12, 4),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Text("Nama Pembuat :",
                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                  fontFamily: 'Poppins',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 8),
                                                                child: Text(
                                                                  getJsonField(
                                                                    listKerusakanMekanikLVItem,
                                                                    r'''$.pembuat''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                    fontFamily: 'Poppins',
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 12,),
                                                            child: Text("No Lambung :",
                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                fontFamily: 'Poppins',
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional.fromSTEB(10,
                                                                0, 0, 0),
                                                            child: Text(
                                                              getJsonField(
                                                                listKerusakanMekanikLVItem,
                                                                r'''$.no_lambung''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.w900,
                                                              ),
                                                            ),
                                                          ),
                                                        ],),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 4),
                                                          child: Row(children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 12),
                                                              child: Text("Nama Unit :",
                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                  fontFamily: 'Poppins',
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional.fromSTEB(10,
                                                                  0, 0, 0),
                                                              child: Text(
                                                                getJsonField(
                                                                  listKerusakanMekanikLVItem,
                                                                  r'''$.nama_unit''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight.w900,
                                                                ),
                                                              ),
                                                            ),
                                                          ],),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              12, 4, 12, 8),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Text(
                                                                'Status  :',
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyText1,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(4,
                                                                    0, 0, 0),
                                                                child: Text(
                                                                  getJsonField(
                                                                    listKerusakanMekanikLVItem,
                                                                    r'''$.status''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                    'Lexend Deca',
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  else {
                                    return Text("Loading");
                                  }
                                }
                                else {
                                  return Text('No data found');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: Color(0xFFFF7B54),
        items: [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.calendar_today),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          if(i == 0){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuMekanikWidget(),
              ),
            );
          }if(i == 1){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DaftarCatatanDailyMekanikWidget(),
              ),
            );
          }
        },
      ),

    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
