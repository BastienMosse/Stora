enum ActionType {
  CREATE('CREATE'),
  UPDATE('UPDATE'),
  DELETE('DELETE');

  final String value;
  const ActionType(this.value);
}
