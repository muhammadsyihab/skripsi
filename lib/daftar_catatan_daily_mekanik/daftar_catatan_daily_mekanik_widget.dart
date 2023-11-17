import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../backend/api_requests/api_calls.dart';
import '../catatan_daily_mekanik/catatan_daily_mekanik_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../menu_mekanik/menu_mekanik_widget.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DaftarCatatanDailyMekanikWidget extends StatefulWidget {
  const DaftarCatatanDailyMekanikWidget({Key? key}) : super(key: key);

  @override
  _DaftarCatatanDailyMekanikWidgetState createState() =>
      _DaftarCatatanDailyMekanikWidgetState();
}

class _DaftarCatatanDailyMekanikWidgetState
    extends State<DaftarCatatanDailyMekanikWidget> {
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
        // leading: InkWell(
        //   onTap: () async {
        //     await Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => MenuMekanikWidget(),
        //       ),
        //     );
        //   },
        //   child: Icon(
        //     Icons.arrow_back_rounded,
        //     color: FlutterFlowTheme.of(context).primaryBtnText,
        //     size: 30,
        //   ),
        // ),
        title: Text(
          'Aktivitas Mekanik',
          style: FlutterFlowTheme.of(context).title1.override(
            fontFamily: 'Lexend Deca',
            color: FlutterFlowTheme.of(context).primaryBtnText,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatatanDailyMekanikWidget(),
                  ),
                );
              },
              child: Icon(
                Icons.file_present,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 30,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.fromSize(
              size: Size.fromHeight(20),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.800,
              child: FutureBuilder<ApiCallResponse>(
                future:
                (_apiRequestCompleter ??= Completer<ApiCallResponse>()
                  ..complete(GetDailyMekanikCall.call(
                    authtoken: FFAppState().authtoken,
                  )))
                    .future,
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color:
                            FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    if (snapshot.data != null) {
                      final listViewGetDailyMekanikResponse =
                      snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final daftarCatataDailyLV = getJsonField(
                            listViewGetDailyMekanikResponse.jsonBody,
                            r'''$.datas''',
                          ).toList().take(5).toList();
                          return RefreshIndicator(
                            onRefresh: () async {
                              setState(() => _apiRequestCompleter = null);
                              await waitForApiRequestCompleter();
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: daftarCatataDailyLV.length,
                              itemBuilder:
                                  (context, daftarCatataDailyLVIndex) {
                                final daftarCatataDailyLVItem =
                                daftarCatataDailyLV[
                                daftarCatataDailyLVIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 8),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          color: Color(0x430F1113),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.85,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF1F4F8),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12, 4, 12, 4),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0,
                                                        4, 0, 0),
                                                    child: Text(
                                                      getJsonField(
                                                        daftarCatataDailyLVItem,
                                                        r'''$.tanggal''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color: Color(
                                                            0xFF0A55C0),
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                              const EdgeInsets.only(
                                                  top: 4),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 15),
                                                    child: Text(
                                                      "No Lambung  :",
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Poppins',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(10,
                                                        0, 0, 0),
                                                    child: Text(
                                                      getJsonField(
                                                        daftarCatataDailyLVItem,
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
                                                        FontWeight
                                                            .w800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  top: 4),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 15),
                                                    child: Text(
                                                      "Nama Unit  :",
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Poppins',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(25,
                                                        0, 0, 0),
                                                    child: Text(
                                                      getJsonField(
                                                        daftarCatataDailyLVItem,
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
                                                        FontWeight
                                                            .w800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12, 4, 0, 0),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        0, 0, 0),
                                                    child: Text(
                                                      'Perbaikan HM :',
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
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        0, 0, 0),
                                                    child: Text(
                                                      getJsonField(
                                                        daftarCatataDailyLVItem,
                                                        r'''$.perbaikan_hm''',
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
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12, 4, 12, 0),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        0, 0, 0),
                                                    child: Text(
                                                      'Perbaikan :',
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
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        0, 0, 0),
                                                    child: Text(
                                                      getJsonField(
                                                        daftarCatataDailyLVItem,
                                                        r'''$.perbaikan''',
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
                                                            .w800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12, 4, 12, 8),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        0, 0, 0),
                                                    child: Text(
                                                      'Estimasi : ',
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
                                                  Text(
                                                    getJsonField(
                                                      daftarCatataDailyLVItem,
                                                      r'''$.estimasi_perbaikan_hm''',
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
                                                          .w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 2),
                                                    child: Text("Jam",
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily:
                                                          'Lexend Deca',
                                                          color: Colors
                                                              .black,
                                                          fontSize:
                                                          11,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12, 4, 12, 8),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        0, 0, 0),
                                                    child: Text(
                                                      'Status Unit : ',
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
                                                  Text(
                                                    getJsonField(
                                                      daftarCatataDailyLVItem,
                                                      r'''$.status''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("Loading");
                    }
                  } else {
                    return Text('No Data Found');
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
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
        initialActiveIndex: 1,
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
