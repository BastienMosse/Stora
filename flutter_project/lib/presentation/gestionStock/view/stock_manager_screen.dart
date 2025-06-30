import '/index.dart';

class GestionStockWidget extends StatefulWidget {
  const GestionStockWidget({super.key});

  static String routeName = 'gestionStock';
  static String routePath = '/gestionStock';

  @override
  State<GestionStockWidget> createState() => _GestionStockWidgetState();
}

class _GestionStockWidgetState extends State<GestionStockWidget> {
  late FocusNode focusenode;
  late TextEditingController controller;
  late FormFieldValidator validator;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;
  late AppLocalizations locale;


  late StockScreenViewModel viewModel;

  bool _isRefreshing = false;

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
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };
  }
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.watch<AppState>().isAdmin) {
      context.go(Routes.home);
    }

    appState = context.read<AppState>();
    theme = context.read<ThemeController>();
    locale = AppLocalizations.of(context)!;

    viewModel.init(context);
    //routeObserver.subscribe(this, ModalRoute.of(context)!);EDIT
  }

  @override
  void didPopNext() {
    //EDIT routeObserver.unsubscribe(this);
    viewModel.dispose();
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    await viewModel.refreshProductList();

    setState(() {
      _isRefreshing = false;
    });
  }

  Widget buildStockCard(Product product){
    return InkWell(
      onTap: () {
        context.push(Routes.stockDisplay, extra: product.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        product.photoUrl.isNotEmpty
                            ? Image.network(
                              product.photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Colors.grey,
                                );
                              },
                            )
                            : Icon(Icons.person, size: 32, color: Colors.grey),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'id: ${product.id}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Text(
                '${product.price} \$'
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                                    child: const ProductFilterWidget(), //,
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
                                      locale!
                                          .stock_manage_page_bar_de_recherche,
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
                                            child: const ProductSortWidget(),
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
                  Expanded(
                    child:
                    _isRefreshing
                        ? Center(child: CircularProgressIndicator())
                        : FutureBuilder<void>(
                          future: viewModel.fetchProductList(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(locale.employee_screen_err+': ${snapshot.error}'),
                                    ElevatedButton(
                                      onPressed: _refreshData,
                                      child: Text(locale.employee_screen_retry),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return RefreshIndicator(
                                onRefresh: _refreshData,
                                child: ListView.builder(
                                  itemCount: viewModel.filteredProductList.length,
                                  itemBuilder: (context, index) {
                                    return buildStockCard(
                                      viewModel.filteredProductList[index],
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                  ),
                ],
              ),
              Builder(
                builder:
                    (context) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: 250,
                        height: 40,
                        child: ElevatedButton(
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
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: const ProductCreateWidget(),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            textStyle: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontFamily: GoogleFonts.interTight().fontFamily,
                            ),
                          ),
                          child: const Text('+'),
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
