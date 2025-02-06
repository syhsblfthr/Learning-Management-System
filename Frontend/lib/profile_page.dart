import 'dart:convert';
import 'package:flutter/material.dart';
import './networking.dart' as httpWrapper;

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({ required super.key, required this.userId });
  
  @override
  _ProfilePageState createState() => _ProfilePageState(userId: userId);
}

class _ProfilePageState extends State<ProfilePage> {
  final int userId;

  _ProfilePageState({ required this.userId });

  final Map<String, TextEditingController> _textControllers = {};
  TextEditingController tes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('learning management system'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildInputField('Nama', 'Masukkan Nama Anda'),
            const SizedBox(height: 16),
            _buildInputField('Tempat Lahir', 'Masukkan Tempat Lahir Anda'),
            const SizedBox(height: 16),
            _buildDatePickerField(
                'Tanggal Lahir', tes),
            const SizedBox(height: 16),
            _buildDropdownField(
              title: 'Jenis Kelamin',
              options: ['Laki-laki', 'Perempuan'],
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              title: 'Agama',
              options: ['Islam', 'Kristen', 'Hindu', 'Budha', 'Lainnya'],
            ),
            const SizedBox(height: 16),
            _buildInputField('Suku', 'Masukkan Suku Anda'),
            const SizedBox(height: 16),
            _buildInputField('Nomor KTP', 'Masukkan Nomor KTP'),
            const SizedBox(height: 16),
            _buildInputField('NPWP', 'Masukkan NPWP'),
            const SizedBox(height: 16),
            _buildDropdownField(
              title: 'Kewarganegaraan',
              options: ['Indonesia', 'WNA'],
            ),
            const SizedBox(height: 16),
            _buildInputField('Alamat', 'Masukkan Alamat Anda'),
            const SizedBox(height: 16),
            _buildInputField('RT', 'Masukkan RT'),
            const SizedBox(height: 16),
            _buildInputField('RW', 'Masukkan RW'),
            const SizedBox(height: 16),
            _buildInputField('Propinsi', 'Masukkan Propinsi Anda'),
            const SizedBox(height: 16),
            _buildInputField('Kabupaten/Kota', 'Masukkan Kabupaten/Kota Anda'),
            const SizedBox(height: 16),
            _buildInputField('Kecamatan', 'Masukkan Kecamatan Anda'),
            const SizedBox(height: 16),
            _buildInputField('Kelurahan', 'Masukkan Kelurahan Anda'),
            const SizedBox(height: 16),
            _buildInputField('Dusun', 'Masukkan Dusun Anda'),
            const SizedBox(height: 16),
            _buildInputField('Kode Pos', 'Masukkan Kode Pos Anda'),
            const SizedBox(height: 16),
            _buildDropdownField(
              title: 'Jenis Tinggal',
              options: ['Bersama Orang Tua', 'Kos', 'Rumah Pribadi'],
            ),
            const SizedBox(height: 16),
            _buildInputField('Telepon Rumah', 'Masukkan Telepon Rumah'),
            const SizedBox(height: 16),
            _buildInputField('Telepon Seluler', 'Masukkan Telepon Seluler'),
            const SizedBox(height: 16),
            _buildInputField('Alamat Kos', 'Masukkan Alamat Kos Anda'),
            const SizedBox(height: 16),
            _buildInputField('Kabupaten/Kota Kos',
                'Masukkan Kabupaten/Kota Kos Anda'),
            const SizedBox(height: 16),
            _buildDropdownField(
              title: 'Alat Transportasi',
              options: ['Jalan Kaki', 'Kendaraan Pribadi', 'Kendaraan Umum', 'Lainnya'],
            ),
            const SizedBox(height: 16),
            _buildInputField(
                'Email (Pribadi)', 'Masukkan Email Pribadi Anda'),
            const SizedBox(height: 16),
            _buildInputField('Email WBI', 'Masukkan Email WBI Anda'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final Map<String, String> map = {};

                  for (final MapEntry(:key, value: controller) in _textControllers.entries) {
                    map[key.toLowerCase()] = controller.text;
                  }

                  debugPrint("Request: ${map.toString()}");
                  debugPrint("UserID: $userId");

                  httpWrapper.put('/api/profile/$userId', map);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String title, String placeholder) {
    // Buat controller untuk input field ini dan letakkan ke dalam textControllers
    TextEditingController? controller;

    if (_textControllers.containsKey(title)) {
      controller = _textControllers[title];
    }
    else {
      _textControllers[title] = controller = TextEditingController();
    }

    InputDecoration makeDecoration(String placeholder) {
      return InputDecoration(
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: makeDecoration(placeholder),
        ),
      ],
    );
  }

  Widget _buildDatePickerField(String label, TextEditingController controller) {
    // Buat controller untuk input field ini dan letakkan ke dalam textControllers
    TextEditingController? controller;

    if (_textControllers.containsKey(label)) {
      controller = _textControllers[label];
    }
    else {
      _textControllers[label] = controller = TextEditingController();
    }
    
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            controller!.text = "${pickedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
          });
        }
      },
    );
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'OK',
    );

    debugPrint('Selected date: ${selectedDate.toString()}');

    if (selectedDate != null) {
      setState(() {
        // controller.text =
        //     '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}';
        controller.text = 'Testing String';
      });
    }
  }

  Widget _buildDropdownField({required String title, required List<String> options}) {
    TextEditingController? controller;

    if (_textControllers.containsKey(title)) {
      controller = _textControllers[title];
    }
    else {
      _textControllers[title] = controller = TextEditingController();
    }
    
    Text makeTitle(String text) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    void onChangedHandler(String? value) {
      if (value == null) {
        return;
      }

      controller!.text = value;
    }

    List<DropdownMenuItem<String>> makeDropdownItems(List<String> values) {
      return options.map(
        (option) => DropdownMenuItem(
          value: option,
          child: Text(option),
        ),
      ).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        makeTitle(title),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          items: makeDropdownItems(options),
          value: options[0],
          onChanged: onChangedHandler,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}
