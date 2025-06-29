import '/index.dart';

import 'popup/employee_disply_update_popup.dart';

class EmployeeDisplay extends StatefulWidget {
  final String userId;

  const EmployeeDisplay({super.key, required this.userId});

  @override
  State<EmployeeDisplay> createState() => _EmployeeDisplayScreenState();
}

class _EmployeeDisplayScreenState extends State<EmployeeDisplay> {
  late EmplyeeDisplayScreenViewModel viewModel;

  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    viewModel = EmplyeeDisplayScreenViewModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.watch<AppState>().isAdmin) {
      context.go(Routes.home);
    }

    viewModel.init(context);
    _fetchAndRefresh();
  }

  Future<void> _fetchAndRefresh() async {
    await viewModel.fetchUserId(widget.userId);
    if (mounted) setState(() {});
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    await viewModel.fetchUserId(widget.userId);

    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        viewModel.user?.photo != null &&
                                viewModel.user!.photo.isNotEmpty
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                viewModel.user!.photo.replaceFirst(
                                  'localhost',
                                  '10.0.2.2',
                                ),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${viewModel.user?.username ?? ''}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('id : ${viewModel.user?.id ?? ''}'),
                              const SizedBox(height: 8),
                              Text('login : ${viewModel.user?.login ?? ''}'),
                              const SizedBox(height: 8),
                              Text('role : ${viewModel.user?.role ?? ''}'),
                              const SizedBox(height: 8),
                              Text('Born: ${viewModel.user?.birth ?? ''}'),
                              const SizedBox(height: 8),
                              Text('Number : ${viewModel.user?.tel ?? ''}'),
                              const SizedBox(height: 8),
                              Text('email : ${viewModel.user?.email ?? ''}'),
                              const SizedBox(height: 8),
                              Text('Pay : ${viewModel.user?.pay ?? ''} \$'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Note',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 80,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(viewModel.user?.note ?? ''),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final updated = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) =>
                                EmployeeUpdatePopup(user: viewModel.user!),
                      );
                      if (updated == true) {
                        await _refreshData();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Modifier',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        viewModel.deleteUser(widget.userId);
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Utilisateur supprimé avec succès',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Supprimer',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
