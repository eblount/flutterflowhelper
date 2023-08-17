import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflowhelper/CodeConverter.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class HomePageWidgetTheme {
  BuildContext context;

  HomePageWidgetTheme(this.context);

  static HomePageWidgetTheme of(BuildContext context) {
    return HomePageWidgetTheme(context);
  }

  Color get primary => Theme.of(context).colorScheme.primary;
  Color get primaryBackground => Theme.of(context).colorScheme.background;
  TextStyle? get headlineMedium => Theme.of(context).textTheme.headlineMedium;
  TextStyle? get bodyMedium => Theme.of(context).textTheme.bodyMedium;
  TextStyle? get labelMedium => Theme.of(context).textTheme.labelMedium;
  Color get alternate => Theme.of(context).colorScheme.secondary;
  Color get error => Theme.of(context).colorScheme.error;
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;

  String builtCode = '';

  @override
  void initState() {
    super.initState();
    textController1 ??= TextEditingController();
    textController2 ??= TextEditingController();
    textController3 ??= TextEditingController();
    textController4 ??= TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    super.dispose();
  }

  void convertCode() {
    final inputCode = textController1?.text ?? '';
    final inputModel = textController2?.text ?? '';
    var className = '';

    if (inputCode.isEmpty) {
      return;
    }

    var converted = CodeConverter().convertCode(inputCode, inputModel);

    textController3?.text = converted.className;
    textController4?.text = converted.widgetCode;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: HomePageWidgetTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: HomePageWidgetTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'FlutterFlow Converter',
            style: HomePageWidgetTheme.of(context).headlineMedium?.copyWith(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Input Code',
                      style: HomePageWidgetTheme.of(context).bodyMedium,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: (MediaQuery.sizeOf(context).height * 0.5) - 100,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: textController1,
                          autofocus: true,
                          obscureText: false,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          onChanged: (String input) => convertCode(),
                          decoration: InputDecoration(
                            labelText: 'Paste Code...',
                            labelStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            hintStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    HomePageWidgetTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: HomePageWidgetTheme.of(context).bodyMedium,
                          maxLines: null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'Input Model',
                        style: HomePageWidgetTheme.of(context).bodyMedium,
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: (MediaQuery.sizeOf(context).height * 0.5) - 100,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: textController2,
                          autofocus: true,
                          obscureText: false,
                          expands: true,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          onChanged: (String input) => convertCode(),
                          decoration: InputDecoration(
                            labelText: 'Paste Model...',
                            labelStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            hintStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    HomePageWidgetTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: HomePageWidgetTheme.of(context).bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Class Filename',
                            style: HomePageWidgetTheme.of(context).bodyMedium,
                          ),
                        ),
                        // Copy button
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 10, 0, 0),
                          child: IconButton(
                            icon: const Icon(Icons.copy),
                            tooltip: 'Copy to Clipboard',
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text: textController3?.text ?? ''));
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: textController3,
                          autofocus: true,
                          readOnly: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            hintStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    HomePageWidgetTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: HomePageWidgetTheme.of(context).bodyMedium,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Converted Code',
                            style: HomePageWidgetTheme.of(context).bodyMedium,
                          ),
                        ),
                        // Copy button
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 10, 0, 0),
                          child: IconButton(
                            icon: const Icon(Icons.copy),
                            tooltip: 'Copy to Clipboard',
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text: textController4?.text ?? ''));
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: MediaQuery.sizeOf(context).height - 220,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: textController4,
                          autofocus: true,
                          readOnly: true,
                          obscureText: false,
                          expands: true,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            hintStyle:
                                HomePageWidgetTheme.of(context).labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    HomePageWidgetTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: HomePageWidgetTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: HomePageWidgetTheme.of(context).bodyMedium,
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
  }
}
