import '/index.dart';

class GenericPageState extends ChangeNotifier {
  final Map<String, dynamic> _stateVariables = {};

  /// Getter for a state variable by key
  T? get<T>(String key) {
    return _stateVariables[key] as T?;
  }

  /// Setter for a state variable by key
  void set<T>(String key, T value) {
    if (_stateVariables[key] != value) {
      _stateVariables[key] = value;
      notifyListeners();
    }
  }

  /// Check if a state variable exists
  bool containsKey(String key) {
    return _stateVariables.containsKey(key);
  }

  /// Remove a state variable by key
  void remove(String key) {
    if (_stateVariables.containsKey(key)) {
      _stateVariables.remove(key);
      notifyListeners();
    }
  }

  /// Reset all state variables
  void resetState() {
    _stateVariables.clear();
    notifyListeners();
  }
}
