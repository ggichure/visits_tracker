import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visits_tracker/l10n/l10n.dart';
import 'package:visits_tracker/src/core/router/app_router.dart';

import 'package:visits_tracker/src/features/customers/presentation/cubits/customers_cubit/customers_cubit.dart';

@RoutePage()
class CutsomersPage extends StatelessWidget {
  const CutsomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.customers(9)),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          unawaited(BlocProvider.of<CustomersCubit>(context).getCustomers());
        },
        child: BlocConsumer<CustomersCubit, CustomersState>(
          listener: (context, state) {
            if (state is CustomersError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? '')),
              );
            }
          },
          builder: (context, state) {
            if (state is CustomersLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is CustomersEmpty) {
              return Center(
                // TODO(griffins): use a dedicated assets file
                child: SvgPicture.asset(
                  'assets/empty.svg',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              );
            }
            if (state is CustomersSuccess) {
              return ListView.separated(
                separatorBuilder: (_, i) => const Divider(
                  endIndent: 18,
                  indent: 18,
                ),
                itemCount: state.customers?.length ?? 0,
                itemBuilder: (_, i) => ListTile(
                  onTap: () => AutoRouter.of(context)
                      .push(VisitsRoute(customer: state.customers?[i])),
                  title: Text(state.customers?[i].name ?? ''),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
