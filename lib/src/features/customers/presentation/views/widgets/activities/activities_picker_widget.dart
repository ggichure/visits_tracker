import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';
import 'package:visits_tracker/l10n/l10n.dart';
import 'package:visits_tracker/src/features/customers/customers.dart'
    show Activity;
import 'package:visits_tracker/src/features/customers/presentation/cubits/activities_cubit/activities_cubit.dart';

class ActivitiesPickerWidget extends StatefulWidget {
  const ActivitiesPickerWidget({super.key, this.validator, this.onSelected});

  final void Function(Activity? selectedValue)? onSelected;
  final FormFieldValidator<Activity>? validator;

  @override
  State<ActivitiesPickerWidget> createState() => _ActivitiesPickerWidgetState();
}

class _ActivitiesPickerWidgetState extends State<ActivitiesPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<ActivitiesCubit, ActivitiesState>(
      listener: (context, state) {
        switch (state.status) {
          case ActivitiesStatus.loading:
            break;
          case ActivitiesStatus.error:
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              type: ToastificationType.error,
              title: Text(state.errorMessage ?? ''),
              autoCloseDuration: const Duration(seconds: 5),
            );
          case ActivitiesStatus.initial:
            break;
          case ActivitiesStatus.success:
            break;
          case ActivitiesStatus.empty:
            break;
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ActivitiesStatus.loading:
            return const Center(child: CircularProgressIndicator.adaptive());
          case ActivitiesStatus.error:
            return const SizedBox();
          case ActivitiesStatus.initial:
            return const SizedBox();
          case ActivitiesStatus.success:
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: DropdownButtonFormField<Activity>(
                hint: Text(l10n.activitiesDone),
                validator: widget.validator,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                items: state.activities
                    ?.map<DropdownMenuItem<Activity>>((Activity value) {
                  return DropdownMenuItem<Activity>(
                    value: value,
                    child: Text(value.description ?? ''),
                  );
                }).toList(),
                onChanged: (changed) {
                  widget.onSelected?.call(changed);
                },
              ),
            );
          case ActivitiesStatus.empty:
            return Center(
              // TODO(griffins): use a dedicated assets file
              child: SvgPicture.asset(
                'assets/empty.svg',
                height: 300,
                fit: BoxFit.cover,
              ),
            );
        }
      },
    );
  }
}
