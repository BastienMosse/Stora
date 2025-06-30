import '/index.dart';

class StockCreatePopup extends StatefulWidget {
  const StockCreatePopup({super.key});

  @override
  State<StockCreatePopup> createState() => _StockCreatePopupState();
}

class _StockCreatePopupState extends State<StockCreatePopup> {
  late FocusNode focusenode1;
  late TextEditingController controller1;
  late FormFieldValidator validator1;

  late FocusNode focusenode2;
  late TextEditingController controller2;
  late FormFieldValidator validator2;

  late FocusNode focusenode3;
  late TextEditingController controller3;
  late FormFieldValidator validator3;

  late FocusNode focusenode4;
  late TextEditingController controller4;
  late FormFieldValidator validator4;

  late FocusNode focusenode5;
  late TextEditingController controller5;
  late FormFieldValidator validator5;

  late FocusNode focusenode6;
  late TextEditingController controller6;
  late FormFieldValidator validator6;

  late FocusNode focusenode7;
  late TextEditingController controller7;
  late FormFieldValidator validator7;

  late int count;
  late int count2;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    final locale = AppLocalizations.of(context)!;
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

    focusenode3 = FocusNode();
    controller3 = TextEditingController();
    validator3 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.stock_cerate_please;
      }
      return null;
    };
    focusenode4 = FocusNode();
    controller4 = TextEditingController();
    validator4 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.stock_cerate_please;
      }
      return null;
    };
    focusenode5 = FocusNode();
    controller5 = TextEditingController();
    validator5 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.stock_cerate_please;
      }
      return null;
    };
    focusenode6 = FocusNode();
    controller6 = TextEditingController();
    validator6 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.stock_cerate_please;
      }
      return null;
    };
    focusenode7 = FocusNode();
    controller7 = TextEditingController();
    validator7 = (value) {
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
            color: Colors.red,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  locale.stock_cerate_create,
                  style: GoogleFonts.interTight(
                    fontSize: 24, // adapte la taille selon ton besoin
                    fontWeight:
                        FontWeight.w600, // exemple, adapte selon ton thème
                    fontStyle: FontStyle.normal, // adapte selon ton thème
                    letterSpacing: 0.0,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SvgPicture.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh00lQPnO3jPxTtNy1pn_JXIghifkT6BstOw&s',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, 1),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                15,
                                15,
                                0,
                                5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    locale.stock_cerate_name + ' : ', //Name
                                    style: GoogleFonts.inter(
                                      fontWeight:
                                          FontWeight
                                              .normal, // à ajuster selon besoin
                                      fontStyle: FontStyle.normal, // idem ici
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        0,
                                        15,
                                        0,
                                      ),
                                      child: Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller1,
                                          focusNode: focusenode1,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  FontWeight
                                                      .w500, // par exemple medium
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0.0,
                                              color: Colors.grey[700],
                                            ),
                                            hintText: locale.stock_cerate_name,
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0.0,
                                              color: Colors.grey[500],
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 0.0,
                                            color: Colors.black87,
                                          ),
                                          cursorColor: Colors.black87,
                                          validator: validator1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                15,
                                5,
                                0,
                                5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Id : ',
                                    style: GoogleFonts.inter(
                                      fontWeight:
                                          FontWeight
                                              .normal, // ajuste selon besoin
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0.0,
                                      color:
                                          Colors
                                              .black87, // couleur de texte par défaut
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: SizedBox(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller2,
                                          focusNode: focusenode2,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelText:
                                                'ID', // Tu peux adapter si besoin
                                            labelStyle: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0.0,
                                              color: Colors.grey[700],
                                            ),
                                            hintText:
                                                locale.stock_cerate_enterID,
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0.0,
                                              color: Colors.grey,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                            filled: true,
                                            fillColor: const Color(
                                              0xFFF5F5F5,
                                            ), // à adapter selon ton thème
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 0.0,
                                            color: Colors.black87,
                                          ),
                                          cursorColor: Colors.black,
                                          validator: validator2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                15,
                                5,
                                0,
                                5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    locale.stock_cerate_quantity,
                                    style: GoogleFonts.inter(
                                      fontSize:
                                          14.0, // Tu peux ajuster selon ton design
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0.0,
                                      color:
                                          Colors
                                              .black87, // Tu peux le changer selon ton thème
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors
                                              .grey
                                              .shade200, // remplace `secondaryBackground`
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.remove_rounded,
                                            color:
                                                count > 0
                                                    ? Colors.grey
                                                    : Colors.grey.shade400,
                                            size: 24,
                                          ),
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
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.add_rounded,
                                            color:
                                                Colors
                                                    .blue, // remplace `primary`
                                            size: 24,
                                          ),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                15,
                                5,
                                0,
                                5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    locale.stock_cerate_quantity_dell,
                                    style: GoogleFonts.inter(
                                      fontSize:
                                          14, // ou adapte selon ton besoin
                                      fontWeight:
                                          FontWeight
                                              .w400, // ou FontWeight.w500 si tu veux plus marqué
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0.0,
                                      color:
                                          Colors
                                              .black, // remplace par ta couleur personnalisée si nécessaire
                                    ),
                                  ), // à placer dans ton état (State)
                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors
                                              .grey[200], // équivalent à secondaryBackground
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_rounded,
                                            color:
                                                count2 > 0
                                                    ? Colors.grey
                                                    : Colors.grey[300],
                                            size: 24,
                                          ),
                                          onPressed:
                                              count2 > 0
                                                  ? () => setState(() {
                                                    count2--;
                                                  })
                                                  : null,
                                        ),
                                        Text(
                                          count2.toString(),
                                          style: GoogleFonts.interTight(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight
                                                    .w600, // équivalent à titleLarge
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_rounded,
                                            color:
                                                Colors
                                                    .blue, // équivalent à primary
                                            size: 24,
                                          ),
                                          onPressed:
                                              () => setState(() {
                                                count2++;
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                15,
                                15,
                                0,
                                5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Description :',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize:
                                          14.0, // ou la taille correspondant à bodyMedium dans FlutterFlow
                                      fontWeight:
                                          FontWeight
                                              .normal, // adapte selon ton design
                                      fontStyle:
                                          FontStyle
                                              .normal, // ou FontStyle.italic si nécessaire
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            15,
                                            0,
                                          ),
                                      child: Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller3,
                                          focusNode: focusenode3,
                                          autofocus: false,
                                          obscureText: false,
                                          maxLines:
                                              null, // autorise plusieurs lignes
                                          textAlign: TextAlign.start,
                                          cursorColor:
                                              Theme.of(
                                                context,
                                              ).primaryColor, // ou une autre couleur
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: 'Description',
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0.0,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color
                                                  ?.withOpacity(0.6),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                            filled: true,
                                            fillColor:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer,
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 0.0,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium?.color,
                                          ),
                                          validator: validator3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                15,
                                15,
                                0,
                                5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Position : ',
                                    style: GoogleFonts.inter(
                                      fontWeight:
                                          FontWeight
                                              .normal, // ou un poids spécifique selon ton thème
                                      fontStyle:
                                          FontStyle
                                              .normal, // ou italique si tu veux
                                      letterSpacing: 0.0,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            15,
                                            0,
                                          ),
                                      child: Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller4,
                                          focusNode: focusenode4,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            hintText: 'Bat',
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                            filled: true,
                                            fillColor:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary, // ou .secondaryBackground si défini
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontWeight,
                                            fontStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontStyle ??
                                                FontStyle.normal,
                                            letterSpacing: 0.0,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: null,
                                          cursorColor:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.color,
                                          validator: validator4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            15,
                                            0,
                                          ),
                                      child: Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller5,
                                          focusNode: focusenode5,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            hintText: locale.stock_cerate_row,
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                            filled: true,
                                            fillColor:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary, // ou ta couleur personnalisée
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontWeight,
                                            fontStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontStyle ??
                                                FontStyle.normal,
                                            letterSpacing: 0.0,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: null,
                                          cursorColor:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.color,
                                          validator: validator5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            15,
                                            0,
                                          ),
                                      child: Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller6,
                                          focusNode: focusenode6,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            hintText: 'Col',
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                            filled: true,
                                            fillColor:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary, // ou ta couleur personnalisée
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontWeight,
                                            fontStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontStyle ??
                                                FontStyle.normal,
                                            letterSpacing: 0.0,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: null,
                                          cursorColor:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.color,
                                          validator: validator6,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            15,
                                            0,
                                          ),
                                      child: Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: controller7,
                                          focusNode: focusenode7,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            hintText:
                                                locale.stock_cerate_height,
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontWeight,
                                              fontStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.fontStyle ??
                                                  FontStyle.normal,
                                              letterSpacing: 0.0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                            filled: true,
                                            fillColor:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.secondary,
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontWeight,
                                            fontStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontStyle ??
                                                FontStyle.normal,
                                            letterSpacing: 0.0,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: null,
                                          cursorColor:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.color,
                                          validator: validator7,
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
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        //FIXME
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(120, 48),
                        padding: EdgeInsets.all(8),
                        backgroundColor:
                            Theme.of(context)
                                .colorScheme
                                .secondary, // équivalent à secondaryBackground
                        side: BorderSide(
                          color: Colors.black, // équivalent à alternate
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        locale.employee_display_update_popup_annuler,
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onSecondary, // secondaryText
                            letterSpacing: 0.0,
                            fontWeight:
                                Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.fontWeight,
                            fontStyle:
                                Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.fontStyle,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //FIXME///
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(160, 48),
                        padding: EdgeInsets.all(8),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: Colors.transparent, width: 1),
                        ),
                      ),
                      child: Text(
                        locale.employee_display_create_popup_create,
                        style: GoogleFonts.inter(
                          color:
                              Colors
                                  .blue, // Remplace par la couleur que tu veux
                          letterSpacing: 0.0,
                          fontWeight:
                              FontWeight.w500, // Exemple, adapte selon besoin
                          fontStyle: FontStyle.normal,
                          fontSize: 16, // Ajuste selon la taille souhaitée
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
