// import '../backend/api_requests/api_calls.dart';
// import '../daftar_catatan_daily_operator/daftar_catatan_daily_operator_widget.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
// import '../notifikasi_operator/notifikasi_operator_widget.dart';
// import '../profile_operator/profile_operator_widget.dart';
// import '../report_alat_operator/report_alat_operator_widget.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// class MenuOperatorv2Widget extends StatefulWidget {
//   const MenuOperatorv2Widget({Key? key}) : super(key: key);
//
//   @override
//   _MenuOperatorv2WidgetState createState() => _MenuOperatorv2WidgetState();
// }
//
// class _MenuOperatorv2WidgetState extends State<MenuOperatorv2Widget> {
//   ApiCallResponse? getHM;
//   ApiCallResponse? getJadwalOperator;
//   LatLng? currentUserLocationValue;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   Completer<ApiCallResponse>? _apiRequestCompleter;
//
//   @override
//   void initState() {
//     super.initState();
//     // On page load action.
//     SchedulerBinding.instance.addPostFrameCallback((_) async {
//       currentUserLocationValue =
//       await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
//       getJadwalOperator = await GetJadwalUserCall.call(
//         authtoken: FFAppState().authtoken,
//       );
//       getHM = await GetHmOperatorCall.call(
//         authtoken: FFAppState().authtoken,
//         tanggal: GetJadwalUserCall.getJamKerja(
//           (getJadwalOperator?.jsonBody ?? ''),
//         ).toString(),
//       );
//       FFAppState().update(() {
//         FFAppState().latlong = currentUserLocationValue!.toString();
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     context.watch<FFAppState>();
//
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xFFF1F4F8),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF1C51D8),
//         automaticallyImplyLeading: false,
//         title: Text(
//           'MANAGEMENT',
//           style: FlutterFlowTheme.of(context).title2.override(
//             fontFamily: 'Lato',
//             color: Colors.white,
//             fontSize: 22,
//           ),
//         ),
//         actions: [
//           Align(
//             alignment: AlignmentDirectional(0.05, 0),
//             child: Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(0, 5, 3, 5),
//               child: InkWell(
//                 onTap: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NotifikasiOperatorWidget(),
//                     ),
//                   );
//                 },
//                 child: Icon(
//                   Icons.notifications,
//                   color: FlutterFlowTheme.of(context).primaryBtnText,
//                   size: 24,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(15, 0, 7, 0),
//             child: InkWell(
//               onTap: () async {
//                 await Navigator.push(
//                   context,
//                   PageTransition(
//                     type: PageTransitionType.fade,
//                     duration: Duration(milliseconds: 300),
//                     reverseDuration: Duration(milliseconds: 300),
//                     child: ProfileOperatorWidget(),
//                   ),
//                 );
//               },
//               child: Icon(
//                 Icons.person,
//                 color: FlutterFlowTheme.of(context).primaryBtnText,
//                 size: 24,
//               ),
//             ),
//           ),
//         ],
//         centerTitle: false,
//         elevation: 2,
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Column(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Card(
//                                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                                   color: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(40),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         2, 2, 2, 2),
//                                     child: Container(
//                                       width: 60,
//                                       height: 60,
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Image.network(
//                                         'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding:
//                               EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Text(
//                                         'Welcome,',
//                                         style: FlutterFlowTheme.of(context)
//                                             .title3
//                                             .override(
//                                           fontFamily: 'Lexend Deca',
//                                           color: Color(0xFF090F13),
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             4, 0, 0, 0),
//                                         child: Text(
//                                           FFAppState().userName,
//                                           style: FlutterFlowTheme.of(context)
//                                               .title3
//                                               .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: Color(0xFF1C51D8),
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0, 4, 0, 0),
//                                     child: Text(
//                                       'Selamat beraktifitas kembali.',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyText1
//                                           .override(
//                                         fontFamily: 'Lexend Deca',
//                                         color: Color(0xFF090F13),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.92,
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 6,
//                                     color: Color(0x4B1A1F24),
//                                     offset: Offset(0, 2),
//                                   )
//                                 ],
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0xFF4B39EF),
//                                     Color(0xFFEE8B60)
//                                   ],
//                                   stops: [0, 1],
//                                   begin: AlignmentDirectional(0.94, -1),
//                                   end: AlignmentDirectional(-0.94, 1),
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         20, 24, 20, 0),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Text(
//                                           dateTimeFormat(
//                                             'MMMMEEEEd',
//                                             getCurrentTimestamp,
//                                             locale: FFLocalizations.of(context)
//                                                 .languageCode,
//                                           ),
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyText1
//                                               .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: Colors.white,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         20, 8, 20, 0),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         FutureBuilder<ApiCallResponse>(
//                                           future: GetHmOperatorCall.call(
//                                             authtoken: FFAppState().authtoken,
//                                           ),
//                                           builder: (context, snapshot) {
//                                             // Customize what your widget looks like when it's loading.
//                                             if (!snapshot.hasData) {
//                                               return Center(
//                                                 child: SizedBox(
//                                                   width: 50,
//                                                   height: 50,
//                                                   child:
//                                                   CircularProgressIndicator(
//                                                     color: FlutterFlowTheme.of(
//                                                         context)
//                                                         .primaryColor,
//                                                   ),
//                                                 ),
//                                               );
//                                             }
//                                             final textGetHmOperatorResponse =
//                                             snapshot.data!;
//                                             return Text(
//                                               GetHmOperatorCall.hm(
//                                                 textGetHmOperatorResponse
//                                                     .jsonBody,
//                                               ).toString(),
//                                               style: FlutterFlowTheme.of(
//                                                   context)
//                                                   .title1
//                                                   .override(
//                                                 fontFamily: 'Lexend Deca',
//                                                 color: Colors.white,
//                                                 fontSize: 32,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         20, 12, 20, 16),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           '05/25',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyText1
//                                               .override(
//                                             fontFamily: 'Roboto Mono',
//                                             color: Color(0x00FFFFFF),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           setState(() => _apiRequestCompleter = null);
//                           await waitForApiRequestCompleter();
//                         },
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width * 0.98,
//                                 height:
//                                 MediaQuery.of(context).size.height * 0.527,
//                                 decoration: BoxDecoration(
//                                   color: FlutterFlowTheme.of(context).overlay30,
//                                 ),
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0, 0.1),
//                                   child: FutureBuilder<ApiCallResponse>(
//                                     future: (_apiRequestCompleter ??=
//                                     Completer<ApiCallResponse>()
//                                       ..complete(GetJadwalUserCall.call(
//                                         authtoken:
//                                         FFAppState().authtoken,
//                                       )))
//                                         .future,
//                                     builder: (context, snapshot) {
//                                       // Customize what your widget looks like when it's loading.
//                                       if (!snapshot.hasData) {
//                                         return Center(
//                                           child: SizedBox(
//                                             width: 50,
//                                             height: 50,
//                                             child: CircularProgressIndicator(
//                                               color:
//                                               FlutterFlowTheme.of(context)
//                                                   .primaryColor,
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                       final listViewGetJadwalUserResponse =
//                                       snapshot.data!;
//                                       return Builder(
//                                         builder: (context) {
//                                           final jadwalUserLV = getJsonField(
//                                             listViewGetJadwalUserResponse
//                                                 .jsonBody,
//                                             r'''$.datas''',
//                                           ).toList().take(5).toList();
//                                           return RefreshIndicator(
//                                             onRefresh: () async {
//                                               setState(() =>
//                                               _apiRequestCompleter = null);
//                                               await waitForApiRequestCompleter();
//                                             },
//                                             child: ListView.builder(
//                                               padding: EdgeInsets.zero,
//                                               scrollDirection: Axis.vertical,
//                                               itemCount: jadwalUserLV.length,
//                                               itemBuilder:
//                                                   (context, jadwalUserLVIndex) {
//                                                 final jadwalUserLVItem =
//                                                 jadwalUserLV[
//                                                 jadwalUserLVIndex];
//                                                 return Padding(
//                                                   padding: EdgeInsetsDirectional
//                                                       .fromSTEB(12, 5, 12, 0),
//                                                   child: Card(
//                                                     clipBehavior: Clip
//                                                         .antiAliasWithSaveLayer,
//                                                     color: Color(0xFFF5F5F5),
//                                                     child: InkWell(
//                                                       onTap: () async {
//                                                         ScaffoldMessenger.of(
//                                                             context)
//                                                             .showSnackBar(
//                                                           SnackBar(
//                                                             content: Text(
//                                                               'Jadwal anda',
//                                                               style: TextStyle(
//                                                                 color: FlutterFlowTheme.of(
//                                                                     context)
//                                                                     .primaryText,
//                                                               ),
//                                                             ),
//                                                             duration: Duration(
//                                                                 milliseconds:
//                                                                 4000),
//                                                             backgroundColor:
//                                                             Color(
//                                                                 0x00000000),
//                                                           ),
//                                                         );
//                                                       },
//                                                       child: Column(
//                                                         mainAxisSize:
//                                                         MainAxisSize.max,
//                                                         children: [
//                                                           Padding(
//                                                             padding:
//                                                             EdgeInsetsDirectional
//                                                                 .fromSTEB(
//                                                                 12,
//                                                                 4,
//                                                                 12,
//                                                                 4),
//                                                             child: Row(
//                                                               mainAxisSize:
//                                                               MainAxisSize
//                                                                   .max,
//                                                               children: [
//                                                                 Padding(
//                                                                   padding: EdgeInsetsDirectional
//                                                                       .fromSTEB(
//                                                                       0,
//                                                                       4,
//                                                                       0,
//                                                                       0),
//                                                                   child: Text(
//                                                                     getJsonField(
//                                                                       jadwalUserLVItem,
//                                                                       r'''$.judul_jam_kerja''',
//                                                                     ).toString(),
//                                                                     style: FlutterFlowTheme.of(
//                                                                         context)
//                                                                         .bodyText2
//                                                                         .override(
//                                                                       fontFamily:
//                                                                       'Lexend Deca',
//                                                                       color:
//                                                                       Color(0xFF0A55C0),
//                                                                       fontSize:
//                                                                       14,
//                                                                       fontWeight:
//                                                                       FontWeight.w600,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Divider(
//                                                             thickness: 1,
//                                                             color: Colors.black,
//                                                           ),
//                                                           Container(
//                                                             width: MediaQuery.of(
//                                                                 context)
//                                                                 .size
//                                                                 .width *
//                                                                 0.85,
//                                                             height: 1,
//                                                             decoration:
//                                                             BoxDecoration(
//                                                               color: Color(
//                                                                   0xFFF1F4F8),
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             EdgeInsetsDirectional
//                                                                 .fromSTEB(
//                                                                 12,
//                                                                 4,
//                                                                 12,
//                                                                 4),
//                                                             child: Row(
//                                                               mainAxisSize:
//                                                               MainAxisSize
//                                                                   .max,
//                                                               children: [
//                                                                 Text(
//                                                                   FFAppState()
//                                                                       .userName,
//                                                                   style: FlutterFlowTheme.of(
//                                                                       context)
//                                                                       .bodyText1
//                                                                       .override(
//                                                                     fontFamily:
//                                                                     'Poppins',
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize:
//                                                                     12,
//                                                                   ),
//                                                                 ),
//                                                                 Padding(
//                                                                   padding: EdgeInsetsDirectional
//                                                                       .fromSTEB(
//                                                                       20,
//                                                                       0,
//                                                                       0,
//                                                                       0),
//                                                                   child: Text(
//                                                                     getJsonField(
//                                                                       jadwalUserLVItem,
//                                                                       r'''$.no_lambung''',
//                                                                     ).toString(),
//                                                                     style: FlutterFlowTheme.of(
//                                                                         context)
//                                                                         .bodyText1
//                                                                         .override(
//                                                                       fontFamily:
//                                                                       'Poppins',
//                                                                       color:
//                                                                       Colors.black,
//                                                                       fontSize:
//                                                                       12,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 Padding(
//                                                                   padding: EdgeInsetsDirectional
//                                                                       .fromSTEB(
//                                                                       20,
//                                                                       0,
//                                                                       0,
//                                                                       0),
//                                                                   child: Text(
//                                                                     getJsonField(
//                                                                       jadwalUserLVItem,
//                                                                       r'''$.nama_unit''',
//                                                                     ).toString(),
//                                                                     style: FlutterFlowTheme.of(
//                                                                         context)
//                                                                         .bodyText1
//                                                                         .override(
//                                                                       fontFamily:
//                                                                       'Poppins',
//                                                                       color:
//                                                                       Colors.black,
//                                                                       fontSize:
//                                                                       12,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             EdgeInsetsDirectional
//                                                                 .fromSTEB(
//                                                                 12,
//                                                                 4,
//                                                                 12,
//                                                                 8),
//                                                             child: Row(
//                                                               mainAxisSize:
//                                                               MainAxisSize
//                                                                   .max,
//                                                               children: [
//                                                                 Padding(
//                                                                   padding: EdgeInsetsDirectional
//                                                                       .fromSTEB(
//                                                                       0,
//                                                                       0,
//                                                                       0,
//                                                                       4),
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .timer_sharp,
//                                                                     color: Color(
//                                                                         0xFF21F34D),
//                                                                     size: 20,
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   getJsonField(
//                                                                     jadwalUserLVItem,
//                                                                     r'''$.jam_kerja_masuk''',
//                                                                   ).toString(),
//                                                                   style: FlutterFlowTheme.of(
//                                                                       context)
//                                                                       .bodyText1
//                                                                       .override(
//                                                                     fontFamily:
//                                                                     'Poppins',
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize:
//                                                                     12,
//                                                                   ),
//                                                                 ),
//                                                                 Padding(
//                                                                   padding: EdgeInsetsDirectional
//                                                                       .fromSTEB(
//                                                                       10,
//                                                                       0,
//                                                                       0,
//                                                                       4),
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .timer_off_outlined,
//                                                                     color: Color(
//                                                                         0xFFFC0606),
//                                                                     size: 20,
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   getJsonField(
//                                                                     jadwalUserLVItem,
//                                                                     r'''$.jam_kerja_keluar''',
//                                                                   ).toString(),
//                                                                   style: FlutterFlowTheme.of(
//                                                                       context)
//                                                                       .bodyText1
//                                                                       .override(
//                                                                     fontFamily:
//                                                                     'Poppins',
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize:
//                                                                     12,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: AlignmentDirectional(0, 0.85),
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.66,
//                 height: MediaQuery.of(context).size.height * 0.05,
//                 decoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).secondaryBackground,
//                 ),
//                 child: FFButtonWidget(
//                   onPressed: () async {
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ReportAlatOperatorWidget(),
//                       ),
//                     );
//                   },
//                   text: 'Report Unit',
//                   options: FFButtonOptions(
//                     width: 130,
//                     height: 40,
//                     color: Color(0xFFFB0505),
//                     textStyle: FlutterFlowTheme.of(context).subtitle2.override(
//                       fontFamily: 'Poppins',
//                       color: Colors.white,
//                     ),
//                     borderSide: BorderSide(
//                       color: Colors.transparent,
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: AlignmentDirectional(0, 0.98),
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.66,
//                 height: MediaQuery.of(context).size.height * 0.05,
//                 decoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).secondaryBackground,
//                 ),
//                 child: FFButtonWidget(
//                   onPressed: () async {
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             DaftarCatatanDailyOperatorWidget(),
//                       ),
//                     );
//                   },
//                   text: 'Daily Operator',
//                   options: FFButtonOptions(
//                     color: FlutterFlowTheme.of(context).primaryColor,
//                     textStyle: FlutterFlowTheme.of(context).subtitle2.override(
//                       fontFamily: 'Poppins',
//                       color: Colors.white,
//                     ),
//                     borderSide: BorderSide(
//                       color: Colors.transparent,
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future waitForApiRequestCompleter({
//     double minWait = 0,
//     double maxWait = double.infinity,
//   }) async {
//     final stopwatch = Stopwatch()..start();
//     while (true) {
//       await Future.delayed(Duration(milliseconds: 50));
//       final timeElapsed = stopwatch.elapsedMilliseconds;
//       final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
//       if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
//         break;
//       }
//     }
//   }
// }
