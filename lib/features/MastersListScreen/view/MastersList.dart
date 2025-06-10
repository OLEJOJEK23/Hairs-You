import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/master.dart';
import 'package:hairs_and_you/api/domain/usecases/get_masters.dart';
import 'package:hairs_and_you/features/MastersListScreen/widgets/masterCard.dart';

import '../../../blocks/booking_block/booking_bloc.dart';

@RoutePage()
class MastersListScreen extends StatefulWidget {
  const MastersListScreen({super.key});

  @override
  State<MastersListScreen> createState() => _MastersListScreenState();
}

class _MastersListScreenState extends State<MastersListScreen> {
  final GetMasters _getMasters = GetIt.I<GetMasters>();
  bool _isMastersLoading = false;
  String? _mastersError;
  List<Master> _masters = [];
  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    _fetchMasters();
    super.initState();
  }

  void _selectMaster(String masterName) {
    context.router.pushNamed('/master');
  }

  Future<void> _fetchMasters() async {
    final state = context.read<BookingBloc>().state;
    setState(() {
      _isMastersLoading = true;
      _mastersError = null;
    });
    final result = await _getMasters(userID: user, salonID: state.salonId);
    result.fold(
      (failure) => setState(() {
        _mastersError = failure.message;
        _isMastersLoading = true;
      }),
      (masters) => setState(() {
        _masters = masters;
        _isMastersLoading = false;
      }),
    );
    if (_mastersError != null) {
      print(_mastersError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Выбор мастера',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
      ),
      body: _isMastersLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surfaceContainerLow
                        .withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: _masters.length,
                  itemBuilder: (context, index) {
                    final master = _masters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                      child: MasterCard(
                        master: master,
                        onSelectMaster: () => _selectMaster(master.fullName),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
