import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _tanggalLahirController = TextEditingController();

  @override
  void dispose() {
    _tanggalLahirController.dispose();
    super.dispose();
  }

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
                'Tanggal Lahir', 'DD-MM-YYYY', _tanggalLahirController),
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
              options: ['Jalan Kaki', 'Motor', 'Mobil', 'Angkutan Umum'],
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
                  // Tambahkan logika untuk menyimpan data
                  debugPrint('Tanggal Lahir: ${_tanggalLahirController.text}');
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
          decoration: InputDecoration(
            hintText: placeholder,
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

  Widget _buildDatePickerField(
      String title, String placeholder, TextEditingController controller) {
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
          readOnly: true,
          onTap: () => _selectDate(controller),
          decoration: InputDecoration(
            hintText: placeholder,
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

    if (selectedDate != null) {
      setState(() {
        controller.text =
            '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}';
      });
    }
  }

  Widget _buildDropdownField(
      {required String title, required List<String> options}) {
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
        DropdownButtonFormField<String>(
          items: options
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
          onChanged: (value) {},
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
