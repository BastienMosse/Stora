import '/index.dart';
import 'package:google_fonts/google_fonts.dart';

class LogFilterWidget extends StatefulWidget {
  const LogFilterWidget({super.key});

  @override
  State<LogFilterWidget> createState() => _LogFilterWidgetState();
}

class _LogFilterWidgetState extends State<LogFilterWidget> {
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

  late AppLocalizations locale;

  late String _selectedChip;
  late List<String> options;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    locale = AppLocalizations.of(context)!;
    super.initState();
    focusenode1 = FocusNode();
    controller1 = TextEditingController();
    validator1 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };

    focusenode2 = FocusNode();
    controller2 = TextEditingController();
    validator2 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };

    focusenode3 = FocusNode();
    controller3 = TextEditingController();
    validator3 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };
    focusenode4 = FocusNode();
    controller4 = TextEditingController();
    validator4 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };
    focusenode5 = FocusNode();
    controller5 = TextEditingController();
    validator5 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };
    focusenode6 = FocusNode();
    controller6 = TextEditingController();
    validator6 = (value) {
      // Example: return null if valid, or an error string if invalid
      if (value == null || value.isEmpty) {
        return locale.filter_log_popup_please_enter_value;
      }
      return null;
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = AppLocalizations.of(context)!;
    _selectedChip = locale.filter_log_popup_all;
    options = [
      locale.filter_log_popup_all,
      locale.filter_log_popup_product,
      locale.filter_log_popup_employee,
      locale.filter_log_popup_customer,
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
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
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.filter_log_popup_option_filter,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(
                        fontFamily: GoogleFonts.interTight().fontFamily,
                        fontWeight:
                            Theme.of(
                              context,
                            ).textTheme.headlineSmall!.fontWeight,
                        fontStyle:
                            Theme.of(
                              context,
                            ).textTheme.headlineSmall!.fontStyle,
                        letterSpacing: 0.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color:
                            Theme.of(context)
                                .colorScheme
                                .onBackground, // ou autre selon ton thème
                        size: 24,
                      ),
                      iconSize: 40, // équivalent à buttonSize
                      padding:
                          EdgeInsets.zero, // évite du padding supplémentaire
                      splashRadius: 24, // optionnel : ajuste la zone tactile
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.filter_log_popup_type_filter,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            Theme.of(context).textTheme.bodyMedium?.fontStyle,
                        letterSpacing: 0.0,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          options.map((option) {
                            final isSelected = _selectedChip == option;

                            return ChoiceChip(
                              label: Text(
                                option,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      isSelected
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimary
                                          : Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  _selectedChip = option;
                                });
                              },
                              selectedColor: Theme.of(context).primaryColor,
                              backgroundColor: const Color(0xFFE0E3E7),
                              elevation: isSelected ? 4 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.filter_log_popup_date_range,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14, // ou autre selon ton besoin
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FontStyle
                                .normal, // ou FontStyle.italic si nécessaire
                        letterSpacing: 0.0,
                        color:
                            Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color, // ou Colors.black
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  0,
                                  4,
                                ),
                                child: Text(
                                  locale.filter_log_popup_start_date,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize:
                                        12, // ajustable selon la taille typique de labelMedium
                                    fontWeight:
                                        FontWeight
                                            .w500, // généralement pour les labels
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.0,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.color,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: controller1,
                                focusNode: focusenode1,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                obscureText: false,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'MM/DD/YYYY',
                                  hintStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context)
                                              .colorScheme
                                              .outlineVariant, // remplace `.alternate`
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant, // remplace `.secondaryBackground`
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                minLines: 1,
                                validator: validator1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  0,
                                  4,
                                ),
                                child: Text(
                                  locale.filter_log_popup_end_date,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize:
                                        12, // ajustable selon la taille typique de labelMedium
                                    fontWeight:
                                        FontWeight
                                            .w500, // généralement pour les labels
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.0,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.labelMedium?.color,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: controller2,
                                focusNode: focusenode2,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                obscureText: false,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'MM/DD/YYYY',
                                  hintStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context)
                                              .colorScheme
                                              .outlineVariant, // à adapter
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Theme.of(
                                        context,
                                      ).colorScheme.surfaceVariant, // à adapter
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                minLines: 1,
                                validator: validator2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Details',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize:
                            12, // ajustable selon la taille typique de labelMedium
                        fontWeight:
                            FontWeight.w500, // généralement pour les labels
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.0,
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                    ),
                    TextFormField(
                      controller: controller3,
                      focusNode: focusenode3,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Product ID',
                        hintStyle: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontFamily: 'Inter', letterSpacing: 0.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Theme.of(context)
                                    .colorScheme
                                    .outlineVariant, // à ajuster selon ton thème
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context)
                                .colorScheme
                                .surfaceVariant, // ou un équivalent à secondaryBackground
                        suffixIcon: Icon(Icons.search),
                      ),
                      minLines: 1,
                      validator: validator3,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Employee Details',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize:
                                12, // ajustable selon la taille typique de labelMedium
                            fontWeight:
                                FontWeight.w500, // généralement pour les labels
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.0,
                            color:
                                Theme.of(context).textTheme.labelMedium?.color,
                          ),
                        ),
                        TextFormField(
                          controller: controller4,
                          focusNode: focusenode4,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Employee ID',
                            hintStyle: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context)
                                        .colorScheme
                                        .outlineVariant, // à ajuster selon ton thème
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor:
                                Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant, // équivalent secondaryBackground
                            suffixIcon: Icon(Icons.search),
                          ),
                          minLines: 1,
                          validator: validator4,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      4,
                                    ),
                                    child: Text(
                                      'First Name',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize:
                                            12, // ajustable selon la taille typique de labelMedium
                                        fontWeight:
                                            FontWeight
                                                .w500, // généralement pour les labels
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0.0,
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.labelMedium?.color,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: controller5,
                                    focusNode: focusenode5,
                                    autofocus: false,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'First Name',
                                      hintStyle: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Theme.of(context)
                                                  .colorScheme
                                                  .outlineVariant, // équivalent alternate
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant, // secondaryBackground équivalent
                                    ),
                                    minLines: 1,
                                    validator: validator5,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      4,
                                    ),
                                    child: Text(
                                      'Last Name',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize:
                                            12, // ajustable selon la taille typique de labelMedium
                                        fontWeight:
                                            FontWeight
                                                .w500, // généralement pour les labels
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0.0,
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.labelMedium?.color,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: controller6,
                                    focusNode: focusenode6,
                                    autofocus: false,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
                                      hintStyle: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.outlineVariant,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.surfaceVariant,
                                    ),
                                    minLines: 1,
                                    validator: validator6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors
                                    .blue, // couleur du bouton, adapte à ton thème
                            elevation: 0,
                            minimumSize: Size(150, 48),
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color:
                                  Colors
                                      .white, // couleur du texte, adapte si besoin
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.0,
                              fontSize: 16, // adapte la taille à ton besoin
                              fontFamily:
                                  'Inter', // si tu utilises GoogleFonts, sinon enlève
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer, // couleur de fond
                            foregroundColor:
                                Theme.of(context)
                                    .colorScheme
                                    .primary, // couleur texte (non utilisé ici car on override)
                            minimumSize: Size(120, 48),
                            padding: EdgeInsets.all(8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.outline, // couleur bordure
                                width: 1,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              controller1.clear();
                              controller2.clear();
                              controller3.clear();
                              controller4.clear();
                              controller5.clear();
                              controller6.clear();
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Reset',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
                              fontFamily: 'Inter Tight',
                              fontWeight:
                                  FontWeight
                                      .w600, // ici on peut ajuster selon ton override
                              letterSpacing: 0.0,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors
                                    .blue, // couleur du bouton, adapte à ton thème
                            elevation: 0,
                            minimumSize: Size(150, 48),
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Apply Filters',
                            style: TextStyle(
                              color:
                                  Colors
                                      .white, // couleur du texte, adapte si besoin
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.0,
                              fontSize: 16, // adapte la taille à ton besoin
                              fontFamily:
                                  'Inter', // si tu utilises GoogleFonts, sinon enlève
                            ),
                          ),
                        ),
                      ],
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
