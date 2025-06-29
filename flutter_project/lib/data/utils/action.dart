enum ActionType {
  CREATE('CREATE'),
  UPDATE('UPDATE'),
  DELETE('DELETE'),
  LOGIN('LOGIN'),
  LOGOUT('LOGOUT'),
  REVERT('REVERT');

  final String value;
  const ActionType(this.value);
}
