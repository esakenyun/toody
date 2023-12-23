import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:toody/data/user_data.dart';
import 'package:toody/ui/constants/app_style.dart';
import 'package:toody/ui/provider/datetime_provider.dart';
import 'package:toody/ui/provider/radiobutton_provider.dart';
import 'package:toody/ui/widget/datetime_widget.dart';
import 'package:toody/ui/widget/radiobutton_widget.dart';
import 'package:toody/ui/widget/textfield_widget.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

class AddTaskModel extends ConsumerWidget {
  const AddTaskModel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'New Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            const Gap(12),
            const Text(
              'Title Task',
              style: AppStyle.headingStyle,
            ),
            const Gap(6),
            TextFieldWidget(
              maxLine: 1,
              hintText: 'Add title Task',
              txtController: titleController,
            ),
            const Gap(12),
            const Text(
              'Description',
              style: AppStyle.headingStyle,
            ),
            const Gap(6),
            TextFieldWidget(
              maxLine: 5,
              hintText: 'Add Descriptions',
              txtController: descriptionController,
            ),
            const Gap(12),
            const Text(
              'Category',
              style: AppStyle.headingStyle,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioButtonWidget(
                    categColor: Colors.black,
                    titleRadio: 'Learning',
                    valueInput: 1,
                    onChangeValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 1),
                  ),
                ),
                Expanded(
                  child: RadioButtonWidget(
                    categColor: Colors.green.shade800,
                    titleRadio: 'Working',
                    valueInput: 2,
                    onChangeValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 2),
                  ),
                ),
                Expanded(
                  child: RadioButtonWidget(
                    categColor: Colors.amber,
                    titleRadio: 'General',
                    valueInput: 3,
                    onChangeValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 3),
                  ),
                ),
              ],
            ),

            //Date & Time

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  titleText: 'Date',
                  valueText: date,
                  iconSection: CupertinoIcons.calendar,
                  onTap: () async {
                    final getDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2027),
                      cancelText: 'Close',
                      confirmText: 'Select',
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData().copyWith(
                              colorScheme: const ColorScheme.dark(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            surface: Colors.teal,
                            onSurface: Colors.black,
                          )),
                          child: child!,
                        );
                      },
                    );

                    if (getDate != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getDate));
                    }
                  },
                ),
                const Gap(22),
                DateTimeWidget(
                  titleText: 'Time',
                  valueText: ref.watch(timeProvider),
                  iconSection: CupertinoIcons.clock,
                  onTap: () async {
                    final getTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (getTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getTime.format(context));
                    }
                  },
                ),
              ],
            ),

            // Button Section
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      ref.read(radioProvider.notifier).update((state) => 0);
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => defaultDateValue);
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => defaultTimeValue);
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      String title = titleController.text;
                      String description = descriptionController.text;
                      String timeTask = ref.read(timeProvider);
                      String dateTask = ref.read(dateProvider);
                      final getRadioValue = ref.read(radioProvider);
                      String category = '';

                      switch (getRadioValue) {
                        case 1:
                          category = 'Learning';
                          break;
                        case 2:
                          category = 'Working';
                          break;
                        case 3:
                          category = 'General';
                          break;
                      }

                      FirestoreDatasource().addTask(
                        title,
                        description,
                        category,
                        timeTask,
                        dateTask,
                      );

                      titleController.clear();
                      descriptionController.clear();
                      ref.read(radioProvider.notifier).update((state) => 0);
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => defaultDateValue);
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => defaultTimeValue);
                      Navigator.pop(context);

                      FlutterToastr.show(
                        'Task Added Successfully',
                        context,
                        position: FlutterToastr.bottom,
                        duration: FlutterToastr.lengthLong,
                        backgroundColor: Colors.green.withOpacity(0.7),
                      );
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
