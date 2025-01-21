import 'package:flutter/material.dart';
import 'profile.dart';
import 'api_service.dart';

class ProfileFormScreen extends StatefulWidget {
  final Profile? profile; // Profile untuk Edit
  final bool isEdit;
  final VoidCallback onSubmit;

  const ProfileFormScreen({
    Key? key,
    this.profile,
    required this.isEdit,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _ProfileFormScreenState createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile?.name ?? '');
    _emailController = TextEditingController(text: widget.profile?.email ?? '');
    _bioController = TextEditingController(text: widget.profile?.bio ?? '');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final profile = Profile(
        id: widget.profile?.id ?? 0,
        name: _nameController.text,
        email: _emailController.text,
        bio: _bioController.text,
      );

      if (widget.isEdit) {
        apiService.updateProfile(profile.id, profile).then((_) {
          widget.onSubmit();
          Navigator.pop(context);
        });
      } else {
        apiService.createProfile(profile).then((_) {
          widget.onSubmit();
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Profile' : 'Create Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Email is required'
                    : null,
              ),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(labelText: 'Bio'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.isEdit ? 'Update' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
