import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testcase_project/app/modules/widgets/input_label.dart';
import 'package:testcase_project/app/modules/widgets/picked_image_item.dart';
import 'package:testcase_project/app/modules/widgets/rounded_select_field.dart';

import '../../widgets/picker_image_box.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Laporan"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              const InputLabel(label: "NIK Pelapor"),
              const SizedBox(height: 4.0),
              RoundedTextField(
                controller: controller.reportCitizenNik,
                hintText: 'Tulis Nomor NIK',
                keyboardType: TextInputType.number,
                onChanged: (_) => controller.changedFormValue(),
              ),
              const SizedBox(height: 16.0),
              const InputLabel(label: "Nama Pelapor"),
              const SizedBox(height: 4.0),
              RoundedTextField(
                controller: controller.reportCitizenName,
                hintText: 'Tulis Nama Anda',
                keyboardType: TextInputType.name,
                onChanged: (_) => controller.changedFormValue(),
              ),
              const SizedBox(height: 16.0),
              const InputLabel(label: "Email Pelapor"),
              const SizedBox(height: 4.0),
              RoundedTextField(
                controller: controller.reportCitizenEmail,
                hintText: 'Tulis Alamat Email',
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => controller.changedFormValue(),
              ),
              const SizedBox(height: 16.0),
              const InputLabel(label: "No HP Pelapor"),
              const SizedBox(height: 4.0),
              RoundedTextField(
                controller: controller.reportCitizenPhone,
                hintText: 'Tulis Nomor HP',
                keyboardType: TextInputType.phone,
                onChanged: (_) => controller.changedFormValue(),
              ),
              const SizedBox(height: 16.0),
              const InputLabel(label: "Alamat Pelapor"),
              const SizedBox(height: 4.0),
              RoundedTextField(
                controller: controller.reportCitizenAddress,
                hintText: 'Tulis Alamat Anda',
                keyboardType: TextInputType.streetAddress,
                onChanged: (_) => controller.changedFormValue(),
              ),
              const SizedBox(height: 16.0),
              const InputLabel(label: "Judul Laporan"),
              const SizedBox(height: 4.0),
              RoundedTextField(
                controller: controller.reportTitleController,
                hintText: 'Tulis Judul Laporan',
                onChanged: (_) => controller.changedFormValue(),
              ),
              const SizedBox(height: 16.0),
              const InputLabel(label: "Deskripsi"),
              const SizedBox(height: 4.0),
              RoundedTextField(
                controller: controller.reportDescController,
                hintText: 'Tulis Deskripsi',
                maxLines: 6,
                onChanged: (_) => controller.changedFormValue(),
              ),
              const SizedBox(height: 16.0),
              const InputLabel(label: "Foto (Maksimal 3 Foto)"),
              const SizedBox(height: 4.0),
              GetBuilder(
                init: controller,
                builder: (_) => controller.images.isEmpty
                    ? RoundedSelectField(
                        hintText: 'Masukkan Foto',
                        icon: Icons.image_outlined,
                        onTap: controller.openSelectOptionImage,
                      )
                    : SizedBox(
                        height: 70,
                        width: context.width,
                        child: Row(
                          children: [
                            Flexible(
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, position) => PickedImageItem(
                                  imgFile: controller.images[position],
                                  onImageTap: () => controller
                                      .openImage(controller.images[position]),
                                  onDeletePressed: () =>
                                      controller.deletePickedImage(position),
                                ),
                                separatorBuilder: (_, index) =>
                                    const SizedBox(width: 4.0),
                                itemCount: controller.images.length,
                                shrinkWrap: true,
                              ),
                            ),
                            if (controller.images.length < 3)
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: PickerImageBox(
                                  onTap: controller.openSelectOptionImage,
                                ),
                              )
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 24.0),
              GetBuilder(
                init: controller,
                builder: (_) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.white,
                    child: RoundedButton(
                      title: "Kirim",
                      onPressed: !controller.canSubmit
                          ? null
                          : controller.confirmAddReport,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
