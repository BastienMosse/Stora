import 'package:stora/index.dart';

class AfficheLogWidget extends StatefulWidget {
  const AfficheLogWidget({super.key});

  @override
  State<AfficheLogWidget> createState() => _AfficheLogWidgetState();
}

class _AfficheLogWidgetState extends State<AfficheLogWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor:
            custom_color._currentTheme.Primary, // adapte selon ton thème
        appBar: AppBar(
          backgroundColor:
              custom_color
                  ._currentTheme
                  .PrimaryBackground, // adapte à ta couleur principale
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: custom_color._currentTheme.PrimaryBackground,
              size: 24,
            ),
            onPressed: () {
              print(locale.displaylog_screen_icon_pressed);
              Navigator.pop(context);
            },
          ),
          elevation: 2,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Id : 123456789', // FIXME
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: custom_color._currentTheme.PrimaryText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '${locale.displaylog_screen_change_date_birth} SMITH John (id: 135792468)', // FIXME
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: custom_color._currentTheme.PrimaryText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    locale.displaylog_screen_detail,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: custom_color._currentTheme.PrimaryText,
                    ),
                  ),
                ),
                Text(
                  locale.displaylog_screen_old,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '24-12-1997', // FIXME
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: custom_color._currentTheme.PrimaryText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    locale.displaylog_screen_new,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  '12-10-1998', // FIXME
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: custom_color._currentTheme.PrimaryText,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        custom_color
                            ._currentTheme
                            .PrimaryBackground, // couleur du bouton, adapte à ton thème
                    elevation: 0,
                    minimumSize: Size(150, 48),
                    padding: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.transparent, width: 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    locale.displaylog_screen_revert_log,
                    style: TextStyle(
                      color:
                          custom_color
                              ._currentTheme
                              .PrimaryBackground, // couleur du texte, adapte si besoin
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
          ),
        ),
      ),
    );
  }
}
