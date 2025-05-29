import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:visits_tracker/l10n/l10n.dart';
import 'package:visits_tracker/src/core/di/service_locator.dart';
import 'package:visits_tracker/src/core/shared/utils/validators.dart';
import 'package:visits_tracker/src/core/shared/widgets/text_input.dart';
import 'package:visits_tracker/src/features/customers/customers.dart';
import 'package:visits_tracker/src/features/customers/presentation/cubits/activities_done_cubit/activities_done_cubit.dart';
import 'package:visits_tracker/src/features/customers/presentation/views/visits/widgets/visits_card.dart';
import 'package:visits_tracker/src/features/customers/presentation/views/widgets/activities/activities_picker_widget.dart';

@RoutePage()
class CreateVisitsPage extends StatelessWidget {
  const CreateVisitsPage({required this.customer, super.key});

  final Customer? customer;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ActivitiesDoneCubit>()),
        BlocProvider(
          create: (_) => getIt<VisitsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ActivitiesCubit>()..getActivities(),
        ),
      ],
      child: CreateVisistsView(customer: customer),
    );
  }
}

class CreateVisistsView extends StatefulWidget {
  const CreateVisistsView({required this.customer, super.key});

  final Customer? customer;

  @override
  State<CreateVisistsView> createState() => _CreateVisistsViewState();
}

class _CreateVisistsViewState extends State<CreateVisistsView> {
  DateTime? dateSelected;
  final locationController = TextEditingController();
  final notesController = TextEditingController();

  String selectedStatus = 'Pending';
  final List<String> statuses = ['Completed', 'Pending', 'Cancelled'];
  final visitDateController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final activitiesDone =
        context.watch<ActivitiesDoneCubit>().state.activities;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.recordAVisit),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              spacing: 12,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    widget.customer?.name ?? '',
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(l10n.customers(0)),
                ),
                //location
                CustomTextInput(
                  suffixIcon: const Icon(Icons.place),
                  controller: locationController,
                  title: l10n.location,
                  validator: Validators.required(l10n.required_),
                ),
                // notes
                CustomTextInput(
                  controller: notesController,
                  title: l10n.notes,
                  maxLines: 5,
                  validator: Validators.required(l10n.required_),
                ),
                // visit date
                GestureDetector(
                  onTap: () async {
                    final selectedDateTime = await context.pickDateTime();
                    dateSelected = selectedDateTime;
                    visitDateController.text =
                        DateFormat('yyyy-MM-dd h:mm').format(selectedDateTime!);
                  },
                  child: CustomTextInput(
                    suffixIcon: const Icon(Icons.calendar_month),
                    controller: visitDateController,
                    title: l10n.visitDate,
                    enabled: false,
                    validator: Validators.required(l10n.required_),
                  ),
                ),

                BlocProvider.value(
                  value: context.read<ActivitiesCubit>(),
                  child: ActivitiesPickerWidget(
                    onSelected: (activity) {
                      context
                          .read<ActivitiesDoneCubit>()
                          .addActivityDone(activity);
                    },
                    validator: (Activity? s) {
                      if (s != null) {
                        Validators.required(l10n.required_);
                      }
                      return;
                    },
                  ),
                ),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: activitiesDone?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(activitiesDone?[i]?.description ?? ''),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<ActivitiesDoneCubit>()
                            .removeActivityDone(activitiesDone?[i]?.id ?? 0);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  children: statuses.map((status) {
                    final isSelected = status == selectedStatus;
                    final color = status.toColor();

                    return ChoiceChip(
                      label: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: color,
                      checkmarkColor: isSelected ? Colors.white : color,
                      backgroundColor: color,
                      onSelected: (_) {
                        setState(() {
                          selectedStatus = status;
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: 40,
                  child: BlocConsumer<VisitsCubit, VisitsState>(
                    listener: (context, state) {
                      if (state is VisitsError) {
                        toastification.show(
                          context: context,
                          alignment: Alignment.bottomCenter,
                          type: ToastificationType.error,
                          autoCloseDuration: const Duration(seconds: 5),
                          description:
                              Text(state.errorMessage ?? l10n.generalError),
                        );
                      }
                      if (state is VisitsCreated) {
                        toastification.show(
                          context: context,
                          alignment: Alignment.bottomCenter,
                          type: ToastificationType.success,
                          primaryColor: Theme.of(context).colorScheme.primary,
                          description: Text(l10n.recordVisitSuccess),
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                        AutoRouter.of(context).maybePop();
                      }
                    },
                    builder: (context, state) {
                      if (state is VisitsLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            BlocProvider.of<VisitsCubit>(context).postVisit(
                              Visit(
                                id: 1,
                                customerId: widget.customer?.id,
                                visitDate: dateSelected?.toIso8601String(),
                                notes: notesController.text,
                                location: locationController.text,
                                activitiesDone: activitiesDone
                                    ?.map((a) => a?.id.toString() ?? '')
                                    .toList(),
                                status: 'Pending',
                                createdAt: DateTime.now().toIso8601String(),
                              ),
                            );
                          }
                        },
                        child: Text(l10n.recordAVisit),
                      );
                    },
                  ),
                ),

                const SizedBox(height: kTextTabBarHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension DateTimePickerExtension on BuildContext {
  /// Shows a date picker first, then a time picker.
  /// Returns a combined DateTime or null if user cancels any picker.
  Future<DateTime?> pickDateTime({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    TimeOfDay? initialTime,
  }) async {
    final DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: this,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? now,
    );

    if (pickedDate == null) return null; // User canceled date picker

    final TimeOfDay? pickedTime = await showTimePicker(
      context: this,
      initialTime: initialTime ?? TimeOfDay.fromDateTime(now),
    );

    if (pickedTime == null) return null; // User canceled time picker

    // Combine picked date & time into one DateTime
    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}
