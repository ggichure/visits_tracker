import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visits_tracker/l10n/l10n.dart';
import 'package:visits_tracker/src/core/di/service_locator.dart';
import 'package:visits_tracker/src/core/router/app_router.dart';
import 'package:visits_tracker/src/features/customers/customers.dart';
import 'package:visits_tracker/src/features/customers/presentation/views/visits/widgets/visits_card.dart';

@RoutePage()
class VisitsPage extends StatelessWidget {
  const VisitsPage({required this.customer, super.key});

  final Customer? customer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VisitsCubit>()..getVisits(customerId: customer?.id),
      child: VisistsView(customer: customer),
    );
  }
}

class VisistsView extends StatelessWidget {
  const VisistsView({super.key, this.customer});
  final Customer? customer;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(CreateVisitsRoute(customer: customer));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(l10n.activities(9)),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          unawaited(
            context.read<VisitsCubit>().getVisits(customerId: customer?.id),
          );
        },
        child: BlocConsumer<VisitsCubit, VisitsState>(
          listener: (context, state) {
            if (state is VisitsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? '')),
              );
            }
          },
          builder: (context, state) {
            if (state is VisitsLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is VisitsEmpty) {
              return const Center(
                child: SizedBox(),
              );
            }
            if (state is VisitsSuccess) {
              return ListView.builder(
                itemCount: state.visits?.length,
                itemBuilder: (_, i) => VisitsCard(
                  visit: state.visits?[i],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
