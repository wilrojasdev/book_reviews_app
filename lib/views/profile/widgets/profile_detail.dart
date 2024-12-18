class ProfileDetail extends StatelessWidget {
  final ProfileViewModel viewModel;
  const ProfileDetail({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                viewModel.userName ?? '',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                viewModel.userEmail ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Logout'),
                        content:
                            const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogout == true) {
                    await viewModel.logout();
                    if (!context.mounted) return;
                    context.go('/login');
                  }
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}