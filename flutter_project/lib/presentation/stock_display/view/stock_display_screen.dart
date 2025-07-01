import '/index.dart';

import 'popup/stock_display_update_popup.dart';
import '../viewmodel/stock_display_screen_vm.dart';

class StockDisplayScreen extends StatefulWidget {
  final String productId;

  const StockDisplayScreen({super.key, required this.productId});

  @override
  State<StockDisplayScreen> createState() => _StockDisplayScreenState();
}

class _StockDisplayScreenState extends State<StockDisplayScreen> {
  late StockDisplayScreenViewModel viewModel;

  late ThemeController theme;
  late AppLocalizations locale;
  final Random random = Random();

  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    viewModel = StockDisplayScreenViewModel();

    if (ApiService.jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }

    viewModel = StockDisplayScreenViewModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.watch<AppState>().isAdmin) {
      context.go(Routes.home);
    }

    theme = context.watch<ThemeController>();
    locale = AppLocalizations.of(context)!;

    viewModel.init(context);
    _fetchAndRefresh();
  }

  Future<void> _fetchAndRefresh() async {
    await viewModel.fetchProductId(widget.productId);
    if (mounted) setState(() {});
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    await viewModel.fetchProductId(widget.productId);

    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.4;
    final imageHeight = MediaQuery.of(context).size.height * 0.2;
    // TODO: faire le endpoint avec la liste de points

    final int pointCount = 5;
    final spots = List.generate(
      5,
      (i) => FlSpot(i.toDouble(), random.nextDouble() * 10),
    ); //FIXME

    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      appBar: AppBar(
        backgroundColor: theme.currentTheme.Primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.currentTheme.PrimaryBackground,
          ),
          onPressed: () => context.go(Routes.stock),
        ),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: imageWidth,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.currentTheme.Primary,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child:
                                (viewModel.product?.photo != null &&
                                        viewModel.product!.photo.isNotEmpty)
                                    ? Image.network(
                                      viewModel.product!.photo,
                                      width: imageWidth,
                                      height: imageHeight,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                                child: Icon(
                                                  Icons.person,
                                                  size: 64,
                                                  color:
                                                      theme
                                                          .currentTheme
                                                          .SecondaryText,
                                                ),
                                              ),
                                    )
                                    : Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 64,
                                        color: theme.currentTheme.SecondaryText,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (viewModel.product != null) ...[
                                Text(
                                  viewModel.product!.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontStyle,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'id : ${viewModel.product!.id}',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontWeight,
                                    fontStyle:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontStyle,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Category : ${viewModel.product!.category}',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontWeight,
                                    fontStyle:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontStyle,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Price : ${viewModel.product!.price}',
                                  style: GoogleFonts.inter(
                                    fontWeight:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontWeight,
                                    fontStyle:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontStyle,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            locale.stock_create_quantity_sel,
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                          Text(
                            viewModel.product?.sellQuantity.toString() ?? '0',
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontWeight,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            locale.stock_create_quantity_sto,
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                          Text(
                            viewModel.product?.stockQuantity.toString() ?? '0',
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontWeight,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            locale.stock_create_quantity_del,
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                          Text(
                            viewModel.product?.deliveryQuantity.toString() ??
                                '0',
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontWeight,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '${locale.stock_create_position}: ',
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                          Text(
                            viewModel.product?.position ?? '',
                            style: GoogleFonts.inter(
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize,
                              fontWeight:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontWeight,
                              fontStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontStyle,
                              color: theme.currentTheme.PrimaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Note',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.currentTheme.PrimaryText,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.currentTheme.SecondaryBackground,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: theme.currentTheme.Primary,
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          viewModel.product?.note ?? '',
                          style: GoogleFonts.interTight(
                            color: theme.currentTheme.PrimaryText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Descrption',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.currentTheme.PrimaryText,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.currentTheme.SecondaryBackground,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: theme.currentTheme.Primary,
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          viewModel.product?.description ?? '',
                          style: GoogleFonts.interTight(
                            color: theme.currentTheme.PrimaryText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Container(
                      width: 370,
                      height: 196.31,
                      child: LineChart(
                        LineChartData(
                          backgroundColor:
                              theme.currentTheme.SecondaryBackground,
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: (pointCount - 1).toDouble(),
                          minY: 0,
                          maxY: 10,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                              ),
                              axisNameWidget: Text(
                                locale.stock_display_quantity,
                                style: TextStyle(fontSize: 14),
                              ),
                              axisNameSize: 20,
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 32,
                              ),
                              axisNameWidget: Text(
                                locale.stock_display_temps,
                                style: TextStyle(fontSize: 14),
                              ),
                              axisNameSize: 20,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: theme.currentTheme.Primary,
                              barWidth: 2,
                              belowBarData: BarAreaData(
                                show: true,
                                color: theme.currentTheme.Primary.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print(locale.stock_dispay_button_press);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                          elevation: 0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16,
                            0,
                            16,
                            0,
                          ),
                          minimumSize: const Size(0, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          locale.stock_dispay_week,
                          style: GoogleFonts.interTight(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //EDIT month endpoint
                          print(locale.stock_dispay_button_press);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                          elevation: 0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16,
                            0,
                            16,
                            0,
                          ),
                          minimumSize: const Size(
                            0,
                            30,
                          ), // hauteur fixe, largeur flexible
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          locale.stock_dispay_month,
                          style: GoogleFonts.interTight(
                            fontSize: 14, // ajuste selon besoin
                            fontWeight: FontWeight.w600, // exemple semi-bold
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(locale.stock_dispay_button_press);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.currentTheme.Primary,
                          elevation: 0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16,
                            0,
                            16,
                            0,
                          ),
                          minimumSize: const Size(
                            0,
                            30,
                          ), // hauteur fixe, largeur flexible
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          locale.stock_dispay_year,
                          style: GoogleFonts.interTight(
                            fontSize: 14, // adapte selon besoin
                            fontWeight: FontWeight.w600, // exemple semi-bold
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => ProductUpdatePopup(
                                product: viewModel.product!,
                              ),
                        );
                        await _refreshData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.currentTheme.Primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(
                        locale.employee_display_page_modify,
                        style: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryBackground,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          viewModel.deleteProduct(widget.productId);
                          context.go(Routes.stock);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                locale.employee_display_page_supr_log,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.currentTheme.Primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(
                        locale.employee_display_page_supr,
                        style: GoogleFonts.interTight(
                          color: theme.currentTheme.PrimaryBackground,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
