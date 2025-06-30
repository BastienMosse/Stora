import '/index.dart';

class GestionLogsWidget extends StatefulWidget {
  const GestionLogsWidget({super.key});

  static String routeName = 'gestionLogs';
  static String routePath = '/gestionLogs';

  @override
  State<GestionLogsWidget> createState() => _GestionLogsWidgetState();
}

class _GestionLogsWidgetState extends State<GestionLogsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late FocusNode focusenode;
  late TextEditingController controller;
  late FormFieldValidator validator;

  late AppLocalizations locale;

  @override
  void initState() {
    super.initState();

    if (ApiService.jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }

    focusenode = FocusNode();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = AppLocalizations.of(context)!;

    validator = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey, size: 24),
          onPressed: () {
            context.pop();
          },
        ),
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            locale!.stock_manage_page_title,
            style: GoogleFonts.interTight(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Colors.grey,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          iconSize: 40, // correspond à buttonSize
                          padding:
                              EdgeInsets
                                  .zero, // optionnel, à ajuster selon le style
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              barrierColor: const Color.fromARGB(
                                137,
                                19,
                                17,
                                17,
                              ), // ou transparent si tu veux
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    // child: const LogFilterWidget(), //,
                                  ),
                                );
                              },
                            );
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.filter_alt,
                              color:
                                  Colors
                                      .blueAccent, // adapte selon FlutterFlowTheme.of(context).info
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: 200,
                              child: TextFormField(
                                controller: controller,
                                focusNode: focusenode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  hintText:
                                      locale.stock_manage_page_bar_de_recherche,
                                  hintStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pink,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.black,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.search,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ),
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.0,
                                  color: Colors.red,
                                ),
                                cursorColor: Colors.green,
                                validator: validator,
                              ),
                            ),
                          ),
                        ),
                        Builder(
                          builder:
                              (context) => Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.sort,
                                    color:
                                        Colors
                                            .orange, // ou autre couleur équivalente à `.info`
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                            0,
                                            0,
                                          ).resolve(Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(
                                                dialogContext,
                                              ).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: const LogSortWidget(),
                                          ),
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
                  //elt
                  /*
                  Builder(
                    builder: (context) => InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (dialogContext) {
                            return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0, 0)
                                    .resolve(Directionality.of(context)),
                                child: GestureDetector(
                                onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: LogDetailWidget(),
                                ),
                            );
                            },
                        );
                        },
                        child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                    child: Text(
                                        'id : 123456789',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                            ),
                                    ),
                                    ),
                                ),
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                    Text(
                                        'Modification of the date of birth of \nTOUT JÃ©rÃ©mie (id : 135792468)',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.inter(
                                                fontWeight: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                                fontStyle: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                            ),
                                    ),
                                    Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 0, 0),
                                        child: Text(
                                            '20-05-2025',
                                            style:
                                                FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.inter(
                                                        fontWeight: FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                    ),
                                                    fontSize: 13,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                    fontStyle: FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                    ),
                                        ),
                                        ),
                                    ),
                                    ],
                                ),
                                ],
                            ),
                            ),
                        ],
                        ),
                    ),
                    )
                  */
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
