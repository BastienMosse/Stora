import '/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late FocusNode _emailFocusNode;

  late TextEditingController _passwordController;
  late FocusNode _passwordFocusNode;

  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);

    _emailController = TextEditingController(text: appState.Email);
    _emailFocusNode = FocusNode();

    _passwordController = TextEditingController(text: appState.Password);
    _passwordFocusNode = FocusNode();
  }

  Widget inputField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputType keyboardType,
    bool isPassword = false,
  }) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: false,
        autocorrect: false,
        obscureText: isPassword ? obscurePassword : false,
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: Colors.grey, // TODO : FlutterFlowTheme.of(context).secondaryText
          ),
          hintText: label.split(' ').first,
          hintStyle: TextStyle(
            fontSize: 14,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey, // TODO : FlutterFlowTheme.of(context).secondaryText
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.indigo, // TODO : FlutterFlowTheme.of(context).primary
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.indigo, // TODO : FlutterFlowTheme.of(context).primary
              width: 2
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // TODO : FlutterFlowTheme.of(context).error
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // TODO : FlutterFlowTheme.of(context).error
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white, // TODO : FlutterFlowTheme.of(context).secondaryBackground
          suffixIcon: isPassword ? IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ) : null,
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = context.watch<UserPrefs>();
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA), // blanc cassé
      body: SafeArea(
        top: true,
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, -1),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 40,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 40, child: VerticalDivider(thickness: 2)),
                  TextButton(
                    onPressed: () {
                      // TODO: Add forgot password logic
                    },
                    child: Text('Forgot Password ?'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: inputField(
                  label: 'Email address',
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: inputField(
                  label: 'Password',
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  keyboardType: TextInputType.text,
                  isPassword: true,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add login logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo, // TODO: FlutterFlowTheme.of(context).primary
                        foregroundColor: Colors.white, // TODO: FlutterFlowTheme.of(context).primaryText
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(
                          letterSpacing: 0.0,
                          fontWeight:
                              Theme.of(context).textTheme.titleSmall?.fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.titleSmall?.fontStyle,
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
