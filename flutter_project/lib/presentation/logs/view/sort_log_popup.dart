import '/index.dart';
import 'package:google_fonts/google_fonts.dart';

class LogSortWidget extends StatefulWidget {
  const LogSortWidget({super.key});

  @override
  State<LogSortWidget> createState() => _LogSortWidgetState();
}

class _LogSortWidgetState extends State<LogSortWidget> {
  final List<String> order = [];

  late bool isActiveName;
  late bool isActiveID;
  late bool isActiveQuantity;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  void moveUp(int index) {
    if (index > 0) {
      setState(() {
        final temp = order[index];
        order[index] = order[index - 1];
        order[index - 1] = temp;
      });
    }
  }

  void moveDown(int index) {
    if (index < order.length - 1) {
      setState(() {
        final temp = order[index];
        order[index] = order[index + 1];
        order[index + 1] = temp;
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      order.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    isActiveID = false;
    isActiveName = false;
    isActiveQuantity = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locale.sort_log_popup_sort_logs,
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.headlineMedium?.fontWeight,
                    fontStyle:
                        Theme.of(context).textTheme.headlineMedium?.fontStyle,
                    letterSpacing: 0.0,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color:
                      Theme.of(
                        context,
                      ).colorScheme.secondary, // ou une couleur de ton choix
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      locale.sort_log_popup_sort_by,
                      style: GoogleFonts.interTight(
                        fontWeight:
                            Theme.of(
                              context,
                            ).textTheme.titleMedium?.fontWeight ??
                            FontWeight.normal,
                        fontStyle:
                            Theme.of(
                              context,
                            ).textTheme.titleMedium?.fontStyle ??
                            FontStyle.normal,
                        letterSpacing: 0.0,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date',
                              style: GoogleFonts.inter(
                                fontWeight:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontWeight ??
                                    FontWeight.normal,
                                fontStyle:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontStyle ??
                                    FontStyle.normal,
                                letterSpacing: 0.0,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.swap_vert,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color ??
                                    Colors
                                        .grey, // Pour secondaryText, on peut prendre bodySmall color ou une couleur grise par défaut
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  isActiveName = !isActiveName;
                                  if (isActiveName) {
                                    // 🔵 Action A : bouton activé
                                    setState(() {
                                      order.add("Date");
                                    });
                                    // Par exemple : trier ta liste en ascendant
                                  } else {
                                    // ⚪ Action B : bouton désactivé
                                    setState(() {
                                      order.remove("Date");
                                    });
                                    // Par exemple : trier ta liste en descendant
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.filter_log_popup_product_id,
                              style: GoogleFonts.inter(
                                fontWeight:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontWeight ??
                                    FontWeight.normal,
                                fontStyle:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontStyle ??
                                    FontStyle.normal,
                                letterSpacing: 0.0,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.swap_vert,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color ??
                                    Colors
                                        .grey, // Pour secondaryText, on peut prendre bodySmall color ou une couleur grise par défaut
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  isActiveID = !isActiveID;
                                  if (isActiveID) {
                                    // 🔵 Action A : bouton activé
                                    setState(() {
                                      order.add(locale.filter_log_popup_product_id);
                                    });
                                    // Par exemple : trier ta liste en ascendant
                                  } else {
                                    // ⚪ Action B : bouton désactivé
                                    setState(() {
                                      order.remove(locale.filter_log_popup_product_id);
                                    });
                                    // Par exemple : trier ta liste en descendant
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.filter_log_popup_employee_id,
                              style: GoogleFonts.inter(
                                fontWeight:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontWeight ??
                                    FontWeight.normal,
                                fontStyle:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontStyle ??
                                    FontStyle.normal,
                                letterSpacing: 0.0,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.swap_vert,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color ??
                                    Colors
                                        .grey, // Pour secondaryText, on peut prendre bodySmall color ou une couleur grise par défaut
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  isActiveQuantity = !isActiveQuantity;
                                  if (isActiveQuantity) {
                                    // 🔵 Action A : bouton activé
                                    setState(() {
                                      order.add(locale.filter_log_popup_employee_id);
                                    });
                                    // Par exemple : trier ta liste en ascendant
                                  } else {
                                    // ⚪ Action B : bouton désactivé
                                    setState(() {
                                      order.remove(locale.filter_log_popup_employee_id);
                                    });
                                    // Par exemple : trier ta liste en descendant
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.sort_log_popup_employee_name,
                              style: GoogleFonts.inter(
                                fontWeight:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontWeight ??
                                    FontWeight.normal,
                                fontStyle:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.fontStyle ??
                                    FontStyle.normal,
                                letterSpacing: 0.0,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.swap_vert,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color ??
                                    Colors
                                        .grey, // Pour secondaryText, on peut prendre bodySmall color ou une couleur grise par défaut
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  isActiveQuantity = !isActiveQuantity;
                                  if (isActiveQuantity) {
                                    // 🔵 Action A : bouton activé
                                    setState(() {
                                      order.add(locale.sort_log_popup_employee_name);
                                    });
                                    // Par exemple : trier ta liste en ascendant
                                  } else {
                                    // ⚪ Action B : bouton désactivé
                                    setState(() {
                                      order.remove(locale.sort_log_popup_employee_name);
                                    });
                                    // Par exemple : trier ta liste en descendant
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color:
                      Theme.of(
                        context,
                      ).dividerColor, // ou une couleur personnalisée
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      locale.sort_log_popup_priotity_order,
                      style: GoogleFonts.interTight(
                        textStyle: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(letterSpacing: 0.0),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /*Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                order.map((item) {



                                }).toList();


                              ]

                            ),*/
                            Column(
                              children: List.generate(order.length, (index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Texte
                                    Text(
                                      '${index + 1}. ${order[index]}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                    ),

                                    // Icônes
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.arrow_upward,
                                            color:
                                                index == 0
                                                    ? Colors.grey
                                                    : Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                            size: 20,
                                          ),
                                          onPressed:
                                              index == 0
                                                  ? null
                                                  : () => moveUp(index),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.arrow_downward,
                                            color:
                                                index == order.length - 1
                                                    ? Colors.grey
                                                    : Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                            size: 20,
                                          ),
                                          onPressed:
                                              index == order.length - 1
                                                  ? null
                                                  : () => moveDown(index),
                                        ),
                                        SizedBox(width: 8),
                                        IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.error,
                                            size: 20,
                                          ),
                                          onPressed: () => removeItem(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.1),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(8),
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.1),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          // Usually secondaryBackground maps to colorScheme.secondary or surface
                        ),
                        child: Text(
                          locale.filter_log_popup_cancel,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // spacing between buttons
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(8),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          locale.sort_log_popup_apply,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Theme.of(context).colorScheme.onPrimary,
                            letterSpacing: 0.0,
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
      ),
    );
  }
}
