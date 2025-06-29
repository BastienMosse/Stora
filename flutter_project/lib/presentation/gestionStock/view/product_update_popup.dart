import '/index.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductUpdateWidget extends StatefulWidget {
  const ProductUpdateWidget({super.key});

  @override
  State<ProductUpdateWidget> createState() => _ProductUpdateWidgetState();
}

class _ProductUpdateWidgetState extends State<ProductUpdateWidget> {
  late int deliv_init;
  late int quantity_init;
  late int soll_init;

  late int deliv;
  late int quantity;
  late int soll;

  late TextEditingController controller;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
    deliv_init = 404;
    quantity_init = 404;
    soll_init = 404;
    deliv = deliv_init;
    quantity = quantity_init;
    soll = soll_init;
    controller = TextEditingController(text: 'Lorem ipsum dolor sit amet');
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Update Product',
                  style: GoogleFonts.interTight(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                                Colors
                                    .grey
                                    .shade200, // remplace par ta couleur si besoin
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color:
                                  Colors
                                      .blue, // remplace par ta couleur primaire
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: [
                              Image.network(
                                'https://images.unsplash.com/photo-1610483178766-8092d96033f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMnx8bGVnb3xlbnwwfHx8fDE3NDc4MDgxMTJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue, // couleur primaire
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white, // couleur icône
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jojo',
                                style: GoogleFonts.inter(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  5,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  'id : 908765742',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  10,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  'Description : ',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    30,
                                    0,
                                    10,
                                  ),
                                  child: Text(
                                    'On delivery : ',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.0,
                                      fontStyle:
                                          FontStyle
                                              .normal, // Par défaut, ou adapte si tu veux italique
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    10,
                                    0,
                                    10,
                                  ),
                                  child: Text(
                                    'Stock quantity : ',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.0,
                                      fontStyle:
                                          FontStyle
                                              .normal, // adapte selon besoin
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    10,
                                    0,
                                    0,
                                  ),
                                  child: Text(
                                    'To ship : ',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.0,
                                      fontStyle:
                                          FontStyle
                                              .normal, // ou adapte selon ton thème
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Actual',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                    fontStyle:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontStyle ??
                                        FontStyle.normal,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    10,
                                    0,
                                    10,
                                  ),
                                  child: Text(
                                    deliv_init.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.0,
                                      fontStyle:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontStyle ??
                                          FontStyle.normal,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    11,
                                    0,
                                    10,
                                  ),
                                  child: Text(
                                    quantity_init.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.0,
                                      fontStyle:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontStyle ??
                                          FontStyle.normal,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    11,
                                    0,
                                    0,
                                  ),
                                  child: Text(
                                    soll_init.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.0,
                                      fontStyle:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontStyle ??
                                          FontStyle.normal,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'New',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                    fontStyle:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontStyle ??
                                        FontStyle.normal,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_rounded,
                                            size: 22,
                                            color:
                                                deliv > 0
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.color
                                                    : Colors.grey,
                                          ),
                                          onPressed:
                                              deliv > 0
                                                  ? () => setState(() {
                                                    deliv--;
                                                  })
                                                  : null,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        Text(
                                          deliv.toString(),

                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.0,
                                            fontStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontStyle ??
                                                FontStyle.normal,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium?.color,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_rounded,
                                            size: 22,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                          onPressed:
                                              () => {
                                                setState(() {
                                                  deliv++;
                                                }),
                                              },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_rounded,
                                            size: 22,
                                            color:
                                                quantity > 0
                                                    ? Theme.of(
                                                      context,
                                                    ).colorScheme.onSurface
                                                    : Theme.of(
                                                      context,
                                                    ).disabledColor,
                                          ),
                                          onPressed:
                                              quantity > 0
                                                  ? () => {
                                                    setState(() {
                                                      quantity--;
                                                    }),
                                                  }
                                                  : null,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.0,
                                            fontStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontStyle ??
                                                FontStyle.normal,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium?.color,
                                            fontFamily:
                                                GoogleFonts.interTight()
                                                    .fontFamily,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_rounded,
                                            size: 22,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                          onPressed:
                                              () => {
                                                setState(() {
                                                  quantity++;
                                                }),
                                              },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_rounded,
                                            size: 22,
                                            color:
                                                soll > 0
                                                    ? Theme.of(
                                                      context,
                                                    ).colorScheme.onSurface
                                                    : Theme.of(
                                                      context,
                                                    ).disabledColor,
                                          ),
                                          onPressed:
                                              soll > 0
                                                  ? () => setState(() {
                                                    soll--;
                                                  })
                                                  : null,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        Text(
                                          soll.toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.0,
                                            fontStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.fontStyle ??
                                                FontStyle.normal,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium?.color,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_rounded,
                                            size: 22,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                          onPressed:
                                              () => setState(() {
                                                soll++;
                                              }),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'Note',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.0,
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
                                .shade200, // Remplace secondaryBackground
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.blue, // Remplace primary
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              10,
                              10,
                              10,
                              10,
                            ),
                            child: TextFormField(
                              ///////////a test
                              controller: controller,
                              maxLines: null, // Autorise plusieurs lignes
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                hintText: 'Enter your note here',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(120, 48),
                        padding: EdgeInsets.all(8),
                        backgroundColor:
                            Colors.grey.shade200, // secondaryBackground
                        elevation: 0,
                        side: BorderSide(
                          color: Colors.grey.shade400, // alternate
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Annuler', // "Cancel" en français si tu veux
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade800, // secondaryText
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(160, 48),
                        padding: EdgeInsets.all(8),
                        backgroundColor:
                            Theme.of(
                              context,
                            ).primaryColor, // équivalent à FlutterFlowTheme.of(context).primary
                        elevation: 0,
                        side: BorderSide(color: Colors.transparent, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight:
                              FontWeight
                                  .w500, // tu peux ajuster selon ce que tu veux hériter
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.0,
                          color:
                              Theme.of(context)
                                  .colorScheme
                                  .onPrimary, // équivalent à FlutterFlowTheme.of(context).info
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
