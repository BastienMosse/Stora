import '/index.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class ProductDisplayWidget extends StatefulWidget {
  const ProductDisplayWidget({super.key});

  static String routeName = 'ProductDisplay';
  static String routePath = '/productDisplay';

  @override
  State<ProductDisplayWidget> createState() => _ProductDisplayWidgetState();
}

class _ProductDisplayWidgetState extends State<ProductDisplayWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (ApiService.jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.login);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final Random random = Random();
    final int pointCount = 5;
    final spots = List.generate(
      5,
      (i) => FlSpot(i.toDouble(), random.nextDouble() * 10),
    );
    //appelle api get id
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.purple, // équivalent à .info
                  size: 24,
                ),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).maybePop(); // équivalent de context.safePop()
                },
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder:
                (context) => Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 15),
                  child: InkWell(
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
                            alignment: AlignmentDirectional(
                              0,
                              0,
                            ).resolve(Directionality.of(context)),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(dialogContext).unfocus();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: ProductUpdateWidget(),
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1610483178766-8092d96033f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMnx8bGVnb3xlbnwwfHx8fDE3NDc4MDgxMTJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    15,
                                    10,
                                    0,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jojo',//Fixme
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
                                        'id : 908765742',//Fixme
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight:
                                              Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.fontWeight,
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
                                      const SizedBox(height: 10),
                                      Text(
                                        'Description : ',
                                        style: GoogleFonts.inter(
                                          fontWeight:
                                              Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.fontWeight,
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
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    locale.stock_display_ship,
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  Text(
                                    '5', //Fixme
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    locale.stock_cerate_quantity,
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  Text(
                                    '58',//FIXME
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    locale.stock_cerate_quantity_dell,
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  Text(
                                    '2',//FIXME
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Position : ',
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  Text(
                                    'Bat. '+'A'+locale.stock_cerate_row+ 'B' +' Col. '+'4'+ locale.stock_cerate_height +'7', //FIXME
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
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Note',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      FontStyle
                                          .normal, // à adapter si tu veux un style italique ou autre
                                  letterSpacing: 0.0,
                                  color:
                                      Colors
                                          .black, // Choisis la couleur que tu veux ici
                                ),
                              ),
                            ),
                            Container(
                              width: 450,
                              height: 100,
                              decoration: BoxDecoration(
                                color:
                                    Colors
                                        .grey
                                        .shade100, // Remplace par ta couleur secondaire de fond
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color:
                                      Colors
                                          .blue, // Remplace par ta couleur primaire
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  10,
                                  10,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  'low quality product -> reduce quantity',//FIXME
                                  style: GoogleFonts.inter(
                                    fontWeight:
                                        FontWeight
                                            .normal, // Ajuste selon besoin
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.0,
                                    color:
                                        Colors.black87, // Exemple couleur texte
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                0,
                                5,
                                0,
                                0,
                              ),
                              child: Container(
                                width: 370,
                                height: 196.31,
                                child: LineChart(
                                  LineChartData(
                                    backgroundColor: Colors.blue,
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
                                        axisNameWidget:  Text(
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
                                        axisNameWidget:  Text(
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
                                        color: Colors.orange,
                                        barWidth: 2,
                                        belowBarData: BarAreaData(
                                          show: true,
                                          color: Colors.green,
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
                                    backgroundColor:
                                        Colors
                                            .blue, // Remplace par ta couleur primaire
                                    elevation: 0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                    locale.stock_dispay_week,
                                    style: GoogleFonts.interTight(
                                      fontSize:
                                          14, // ajuste la taille selon besoin
                                      fontWeight:
                                          FontWeight
                                              .w600, // par exemple semi-bold
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
                                    backgroundColor:
                                        Colors
                                            .blue, // Remplace par ta couleur principale
                                    elevation: 0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                      fontWeight:
                                          FontWeight.w600, // exemple semi-bold
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
                                    backgroundColor:
                                        Colors
                                            .blue, // Remplace par ta couleur principale
                                    elevation: 0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                      fontWeight:
                                          FontWeight.w600, // exemple semi-bold
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print(locale.stock_dispay_button_press);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors
                                            .blue, // Remplace par ta couleur principale
                                    elevation: 0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          16,
                                          0,
                                          16,
                                          0,
                                        ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    locale.stock_dispay_del,
                                    style: GoogleFonts.interTight(
                                      fontSize: 14, // adapte selon besoin
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                              ),
                              Builder(
                                builder:
                                    (context) => SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                  0,
                                                  0,
                                                ).resolve(
                                                  Directionality.of(context),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(
                                                      dialogContext,
                                                    ).unfocus();
                                                    FocusManager
                                                        .instance
                                                        .primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: ProductUpdateWidget(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors
                                                  .blue, // Remplace par ta couleur principale
                                          elevation: 0,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                16,
                                                0,
                                                16,
                                                0,
                                              ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          locale.stock_dispay_edit,
                                          style: GoogleFonts.interTight(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                        ),
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
          ),
        ),
      ),
    );
  }
}
