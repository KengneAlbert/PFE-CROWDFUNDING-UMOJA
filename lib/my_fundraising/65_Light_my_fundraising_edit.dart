import 'package:flutter/material.dart';

class EditFundraisingPage extends StatefulWidget {
  @override
  _EditFundraisingPageState createState() => _EditFundraisingPageState();
}

class _EditFundraisingPageState extends State<EditFundraisingPage> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _category = 'Disaster';
  String? _totalDonationRequired;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Edit Fundraising'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Handle close button press
              _showUnpublishDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campaign Image
                Image.asset(
                  'assets/images/Frame.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                // Image Thumbnails
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildThumbnailImage('assets/images/Frame.png'),
                    _buildThumbnailImage('assets/images/Frame.png'),
                    _buildThumbnailImage('assets/images/Frame.png'),
                    _buildThumbnailImage('assets/images/Frame.png'),
                  ],
                ),
                SizedBox(height: 24),
                // Fundraising Details
                Text(
                  'Fundraising Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                // Title
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'Help Victims of Flash Flood in Surabaya',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value;
                  },
                ),
                SizedBox(height: 16),
                // Category
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category *',
                    border: OutlineInputBorder(),
                  ),
                  value: _category,
                  items: <String>['Disaster', 'Education', 'Healthcare']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                   }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Total Donation Required
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Total Donation Required *',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '10,540',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the total donation required';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _totalDonationRequired = value;
                  },
                ),
                SizedBox(height: 24),
                // Update & Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle form submission
                      print('Title: $_title');
                      print('Category: $_category');
                      print('Total Donation Required: $_totalDonationRequired');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Update & Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnailImage(String imageUrl) {
    return Container(
      width: 80,
      height: 80,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  void _showUnpublishDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.delete,
                size: 48,
                color: Colors.green,
              ),
              Text('Stop Publishing Fundraising'
                ,style: TextStyle(color: Colors.green, fontSize: 18),),
              SizedBox(height: 16),
              Text(
                'After you stop this publication, you cannot republish it',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure?',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle unpublishing the fundraising
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text('Yes, Unpublish'),
            ),
          ],
        );
      },
    );
  }
}