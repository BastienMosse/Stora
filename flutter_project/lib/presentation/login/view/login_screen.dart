import '/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginScreenViewModel viewModel;

  late TextEditingController _loginController;
  late FocusNode _loginFocusNode;

  late TextEditingController _passwordController;
  late FocusNode _passwordFocusNode;

  late AppState appState;
  late UserPrefs userPrefs;
  late ThemeController theme;

  bool obscurePassword = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _loginController = TextEditingController();
    _loginController.addListener(_clearErrors);
    _loginFocusNode = FocusNode();

    _passwordController = TextEditingController();
    _passwordController.addListener(_clearErrors);
    _passwordFocusNode = FocusNode();

    viewModel = LoginScreenViewModel();
  }

  void _clearErrors() {
    if (_hasError) {
      setState(() {
        _hasError = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    appState = context.read<AppState>();
    userPrefs = context.read<UserPrefs>();
    theme = context.read<ThemeController>();

    viewModel.init(context);

    if (userPrefs.RememberMe) {
      _loginController.text = appState.Login;
      _passwordController.text = appState.Password;
    }
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
        obscureText: isPassword ? obscurePassword : false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${label.toLowerCase()}';
          }
          return null;
        },
        style: TextStyle(color: theme.currentTheme.PrimaryText),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: theme.currentTheme.SecondaryText,
          ),
          hintText: label,
          hintStyle: TextStyle(
            fontSize: 14,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w400,
            color: theme.currentTheme.SecondaryText,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  _hasError
                      ? theme.currentTheme.Error
                      : theme.currentTheme.Primary,
              width: _hasError ? 1 : 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  _hasError
                      ? theme.currentTheme.Error
                      : theme.currentTheme.Primary,
              width: _hasError ? 1 : 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.currentTheme.Error, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.currentTheme.Error, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: theme.currentTheme.SecondaryBackground,
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  )
                  : null,
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget loginButton({required String label}) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ElevatedButton(
        onPressed: () async {
          await viewModel.login(
            _loginController.text.trim(),
            _passwordController.text.trim(),
            onError: (message) {
              setState(() {
                _hasError = true;
              });
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.currentTheme.Primary,
          foregroundColor: theme.currentTheme.PrimaryText,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            letterSpacing: 0.0,
            fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight,
            fontStyle: Theme.of(context).textTheme.titleSmall?.fontStyle,
          ),
        ),
        child: Text('Login', style: TextStyle(color: Color(0xFFFFFFFF))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
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
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 40,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        color: theme.currentTheme.PrimaryText,
                      ),
                    ),
                  ),
                  SizedBox(height: 40, child: VerticalDivider(thickness: 2)),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: TextButton(
                      onPressed: () {
                        // TODO: Add forgot password logic
                        throw UnimplementedError(
                          'Forgot password functionality is not implemented yet.',
                        );
                      },
                      child: Text('Forgot Password ?'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: inputField(
                  label: 'Login',
                  controller: _loginController,
                  focusNode: _loginFocusNode,
                  keyboardType: TextInputType.name,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: inputField(
                  label: 'Password',
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: userPrefs.RememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        viewModel.toggleRememberMe(value ?? false);
                      });
                    },
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(color: theme.currentTheme.PrimaryText),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [loginButton(label: 'Login')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
