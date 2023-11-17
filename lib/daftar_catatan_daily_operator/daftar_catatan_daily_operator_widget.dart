import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../backend/api_requests/api_calls.dart';
import '../catatan_daily_operator/catatan_daily_operator_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../menu_operatorv2/menu_operatorv2_widget.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../report_alat_operator/report_alat_operator_widget.dart';

class DaftarCatatanDailyOperatorWidget extends StatefulWidget {
  const DaftarCatatanDailyOperatorWidget({Key? key}) : super(key: key);

  @override
  _DaftarCatatanDailyOperatorWidgetState createState() =>
      _DaftarCatatanDailyOperatorWidgetState();
}

class _DaftarCatatanDailyOperatorWidgetState
    extends State<DaftarCatatanDailyOperatorWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A55C0),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportAlatOperatorWidget(),
              ),
            );
          },
          child: Icon(
            Icons.security_update_warning,
            color: FlutterFlowTheme.of(context).primaryBtnText,
            size: 30,
          ),
        ),
        title: Text(
          'Aktivitas Operator',
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Lexend Deca',
                color: FlutterFlowTheme.of(context).primaryBtnText,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 3, 5),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatatanDailyOperatorWidget(),
                  ),
                );
              },
              child: Icon(
                Icons.file_present_sharp,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: InkWell(
              onTap: () async {
                setState(() => _apiRequestCompleter = null);
                await waitForApiRequestCompleter();
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.98,
                      height: MediaQuery.of(context).size.height * 0.760,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).overlay30,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: FutureBuilder<ApiCallResponse>(
                          future: (_apiRequestCompleter ??=
                                  Completer<ApiCallResponse>()
                                    ..complete(GetDailyOperatorCall.call(
                                      authtoken: FFAppState().authtoken,
                                    )))
                              .future,
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
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
                            final listViewGetDailyOperatorResponse =
                                snapshot.data!;
                            return Builder(
                              builder: (context) {
                                final daftarDailyOperatorLV = getJsonField(
                                  listViewGetDailyOperatorResponse.jsonBody,
                                  r'''$.datas''',
                                ).toList().take(5).toList();
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  itemCount: daftarDailyOperatorLV.length,
                                  itemBuilder:
                                      (context, daftarDailyOperatorLVIndex) {
                                    final daftarDailyOperatorLVItem =
                                        daftarDailyOperatorLV[
                                            daftarDailyOperatorLVIndex];
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 8, 8, 4),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        getJsonField(
                                                          daftarDailyOperatorLVItem,
                                                          r'''$.jam_kerja''',
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
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.black,
                                                ),
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12, 4, 12, 4),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        "No Lambung :"
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10, 0,
                                                                    0, 0),
                                                        child: Text(
                                                          getJsonField(
                                                            daftarDailyOperatorLVItem,
                                                            r'''$.no_lambung''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                Row(children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12),
                                                    child: Text("Nama Unit :"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(10, 0,
                                                        0, 0),
                                                    child: Text(
                                                      getJsonField(
                                                        daftarDailyOperatorLVItem,
                                                        r'''$.nama_unit''',
                                                      ).toString(),
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Poppins',
                                                        color: Colors
                                                            .black,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],),

                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12, 5, 12, 4),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'HM :',
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5, 0, 0, 0),
                                                        child: Text(
                                                          getJsonField(
                                                            daftarDailyOperatorLVItem,
                                                            r'''$.hm''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 4, 12, 8),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    4, 0, 0, 0),
                                                        child: Text(
                                                          'Jenis : catatan ',
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
                                                          daftarDailyOperatorLVItem,
                                                          r'''$.status''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: Color(0xFF1C51D8),
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
                builder: (context) => MenuOperatorv2Widget(),
              ),
            );
          }if(i == 1){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DaftarCatatanDailyOperatorWidget(),
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
