import 'package:flutter/material.dart';

class CreateNewFundraisingPage extends StatefulWidget {
  @override
  _CreateNewFundraisingPageState createState() =>
      _CreateNewFundraisingPageState();
}

class _CreateNewFundraisingPageState
    extends State<CreateNewFundraisingPage> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _category = 'Education';
  String? _totalDonationRequired;
  DateTime? _donationExpirationDate;
  String? _fundUsagePlan;
  String? _recipientName;
  String? _donationProposalDocument;
  String? _medicalDocument;
  String? _story;
  bool _termsAndConditionsAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Create New Fundraising'),
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
                  'assets/images/Frame2.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                // Image Thumbnails
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildThumbnailImage(
                        'assets/images/Frame2.png'),
                    _buildThumbnailImage(
                        'assets/images/Frame2.png'),
                    _buildThumbnailImage(
                        'assets/images/Frame2.png'),
                    _buildThumbnailImage(
                        'assets/images/Frame2.png'),
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
                  initialValue: 'Help African Children\'s Education',
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
                  items: <String>['Education', 'Disaster', 'Healthcare']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value                     ,
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
                  initialValue: '8,200',
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
                SizedBox(height: 16),
                // Choose Donation Expiration Date
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Choose Donation Expiration Date *',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _donationExpirationDate = pickedDate;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: _donationExpirationDate != null
                        ? _donationExpirationDate!.toString()
                        : 'December 20, 2024',
                  ),
                ),
                SizedBox(height: 16),
                // Fund Usage Plan
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Fund Usage Plan *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud. ut labore et dolore magna aliqua. Ut enim ad minim.',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a fund usage plan';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _fundUsagePlan = value;
                  },
                ),
                SizedBox(height: 24),
                // Donation Recipient Details
                Text(
                  'Donation Recipient Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                // Name of Recipients
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name of Recipients (People/Organization) *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'African Children',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the recipient name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _recipientName = value;
                  },
                ),
                SizedBox(height: 16),
                // Upload Donation Proposal Documents
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Upload Donation Proposal Documents *',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.cloud_upload),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Handle file selection
                    setState(() {
                      _donationProposalDocument = 'Proposal African Children Education.pdf';
                    });
                  },
                  controller: TextEditingController(
                    text: _donationProposalDocument ?? '',
                  ),
                ),
                SizedBox(height: 16),
                // Upload Medical Documents (optional)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Upload Medical Documents (optional for medical)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.cloud_upload),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Handle file selection
                    setState(() {
                      _medicalDocument = 'Medical Documents.pdf';
                    });
                  },
                  controller: TextEditingController(
                    text: _medicalDocument ?? '',
                  ),
                ),
                SizedBox(height: 16),
                // Story
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Story *',
                    border: OutlineInputBorder(),
                  ),
                  initialValue:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud. ut labore et dolore magna aliqua. Ut enim ad minim.',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a story';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _story = value;
                  },
                ),
                SizedBox(height: 16),
                // Terms and Conditions
                Row(
                  children: [
                    Checkbox(
                      value: _termsAndConditionsAgreed,
                      onChanged: (value) {
                        setState(() {
                          _termsAndConditionsAgreed = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'By checking this, you agree to the terms & conditions that apply to us.',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle Draft button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.drafts),
                          SizedBox(width: 8),
                          Text('Draft'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Handle form submission
                          print('Title: $_title');
                          print('Category: $_category');
                          print('Total Donation Required: $_totalDonationRequired');
                          print('Donation Expiration Date: $_donationExpirationDate');
                          print('Fund Usage Plan: $_fundUsagePlan');
                          print('Recipient Name: $_recipientName');
                          print('Donation Proposal Document: $_donationProposalDocument');
                          print('Medical Document: $_medicalDocument');
                          print('Story: $_story');
                          print('Terms and Conditions Agreed: $_termsAndConditionsAgreed');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Create & Submit'),
                    ),
                  ],
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
}