import '/index.dart';

class QuantitySelector extends StatelessWidget {
  final int value;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final Color color;

  const QuantitySelector({
    required this.value,
    required this.onAdd,
    required this.onRemove,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: const Icon(Icons.remove), onPressed: onRemove),
          Text('$value', style: TextStyle(color: color)),
          IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
        ],
      ),
    );
  }
}
