import '/index.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductFilterWidget extends StatefulWidget {
  const ProductFilterWidget({super.key});

  @override
  State<ProductFilterWidget> createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  final List<String> categoryItems = [];
  final List<String> keywordItems = [];

  late FocusNode focusenode1;
  late TextEditingController controller1;
  late FormFieldValidator validator1;

  late FocusNode focusenode2;
  late TextEditingController controller2;
  late FormFieldValidator validator2;

  late int count;
  late int count2;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  void _addCategory(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      categoryItems.add(trimmed);
    });
    controller2.clear();
  }

  void _removeCategory(String item) {
    setState(() {
      categoryItems.remove(item);
    });
  }

  void _addKey(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      keywordItems.add(trimmed);
    });
    controller2.clear();
  }

  void _removeKey(String item) {
    setState(() {
      keywordItems.remove(item);
    });
  }

  @override
  void initState() {
    final locale = AppLocalizations.of(context)!;
    super.initState();
    count = 0;
    count2 = 0;
    super.initState();
    focusenode1 = FocusNode();
    controller1 = TextEditingController();
    validator1 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.stock_cerate_please;
      }
      return null;
    };

    focusenode2 = FocusNode();
    controller2 = TextEditingController();
    validator2 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.stock_cerate_please;
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
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.employee_filter_popup_option,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.interTight(
                    fontWeight: FontWeight.bold, // ou la graisse que tu veux
                    fontStyle: FontStyle.normal, // ou italique si besoin
                    letterSpacing: 0.0,
                    fontSize: 24, // adapte selon la taille souhaitée
                    color: Colors.black, // adapte la couleur
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Champ d'entrée
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0,
                              20,
                              0,
                              5,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  locale.stock_filter_key_word,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller1,
                                    focusNode: focusenode1,
                                    textInputAction:
                                        TextInputAction.done, // Ajouté !
                                    decoration: InputDecoration(
                                      hintText: locale.stock_filter_key_word_hint,
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                    ),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    onFieldSubmitted: _addKey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Affichage des catégories ajoutées
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children:
                                keywordItems.map((item) {
                                  return Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ), // padding horizontal
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize:
                                          MainAxisSize
                                              .min, // <== important pour prendre juste la taille du contenu
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          item,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ), // espace entre texte et bouton
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            onPressed: () => _removeKey(item),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                      /*
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Category : ',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.0,
                                color: Colors.black, // Adapte selon ton thème
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 200,
                                child: TextFormField(
                                  controller: controller2,
                                  focusNode: focusenode2,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'category',
                                    hintStyle: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100, // ou ton thème secondaire
                                  ),
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.0,
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  validator: validator2
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //list categorie
                          

                          /*
                          ---------------------TRADUIT----------------

                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                              child: Container(
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white, // Remplace par ta couleur de fond souhaitée
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Colors.blue, // Remplace par ta couleur primaire
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                        child: Text(
                                          'Text to add', 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.blue, // Couleur du bouton
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            onPressed: () {
                                              //supretion de l'elt
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          */


                        ],
                      ),*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Champ d'entrée
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0,
                              20,
                              0,
                              5,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  locale.stock_filter_key_cat,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller2,
                                    focusNode: focusenode2,
                                    textInputAction:
                                        TextInputAction.done, // Ajouté !
                                    decoration: InputDecoration(
                                      hintText: locale.stock_filter_key_cat_hint,
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                    ),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    onFieldSubmitted: _addCategory,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Affichage des catégories ajoutées
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children:
                                categoryItems.map((item) {
                                  return Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ), // padding horizontal
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize:
                                          MainAxisSize
                                              .min, // <== important pour prendre juste la taille du contenu
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          item,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ), // espace entre texte et bouton
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            onPressed:
                                                () => _removeCategory(item),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            locale.stock_filter_qb,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  FontStyle
                                      .normal, // ou FontStyle.italic si besoin
                              letterSpacing: 0.0,
                              color: Colors.black, // adapte selon ton thème
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              locale.stock_filter_lt,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    FontStyle
                                        .normal, // Remplace par FontStyle.italic si nécessaire
                                letterSpacing: 0.0,
                                color:
                                    Colors
                                        .black, // Adapte la couleur selon ton thème
                              ),
                            ),
                            Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_rounded, size: 24),
                                    color:
                                        count > 0 ? Colors.black : Colors.grey,
                                    onPressed:
                                        count > 0
                                            ? () => setState(() {
                                              count--;
                                            })
                                            : null,
                                  ),
                                  Text(
                                    count.toString(),
                                    style: GoogleFonts.interTight(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add_rounded, size: 24),
                                    color: Colors.blue,
                                    onPressed:
                                        () => setState(() {
                                          count++;
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              locale.stock_filter_mt,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    FontStyle
                                        .normal, // ou FontStyle.italic si nécessaire
                                letterSpacing: 0.0,
                                color:
                                    Colors
                                        .black, // adapte cette couleur selon ton thème
                              ),
                            ),
                            Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.purple, // adapte à ton thème
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_rounded),
                                    color:
                                        count2 > 0
                                            ? Colors.black
                                            : const Color.fromARGB(
                                              255,
                                              247,
                                              186,
                                              186,
                                            ),
                                    onPressed:
                                        count2 > 0
                                            ? () => setState(() {
                                              count2--;
                                            })
                                            : null,
                                    iconSize: 24,
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
                                    ),
                                  ),
                                  Text(
                                    count2.toString(),
                                    style: GoogleFonts.interTight(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add_rounded),
                                    color: Colors.blue,
                                    onPressed:
                                        () => setState(() {
                                          count2++;
                                        }),
                                    iconSize: 24,
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(110, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        locale.employee_display_update_popup_annuler,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontFamily: 'InterTight',
                          fontWeight:
                              Theme.of(
                                context,
                              ).textTheme.titleSmall?.fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.titleSmall?.fontStyle,
                          color: Theme.of(context).colorScheme.onPrimary,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          count = 0;
                        });
                        setState(() {
                          count2 = 0;
                        });
                        setState(() {
                          categoryItems.clear();
                        });
                        setState(() {
                          keywordItems.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(110, 48),
                        padding: EdgeInsets.all(8),
                        backgroundColor:
                            Theme.of(context)
                                .colorScheme
                                .background, // secondaire, adapte si besoin
                        side: BorderSide(
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(
                            0.3,
                          ), // couleur bordure comme "alternate"
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        locale.employee_filter_popup_reset,
                        style: GoogleFonts.interTight(
                          fontWeight: FontWeight.w600, // adapte à ton thème
                          fontSize: 16,
                          color:
                              Theme.of(context)
                                  .colorScheme
                                  .onBackground, // couleur texte principale
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(110, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        locale.employee_filter_popup_apply,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontFamily: 'InterTight',
                          fontWeight:
                              Theme.of(
                                context,
                              ).textTheme.titleSmall?.fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.titleSmall?.fontStyle,
                          color: Theme.of(context).colorScheme.onPrimary,
                          letterSpacing: 0.0,
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
