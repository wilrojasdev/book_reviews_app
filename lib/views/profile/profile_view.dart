import 'package:book_reviews_app/viewmodels/profile_viewmodel.dart';
import 'package:book_reviews_app/views/profile/widgets/profile_detail.dart';
import 'package:book_reviews_app/views/profile/widgets/profile_nologin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (viewModel.userId == null) {
          return const ProfileNologin();
        }

        return ProfileDetail(viewModel: viewModel);
      },
    );
  }
}
