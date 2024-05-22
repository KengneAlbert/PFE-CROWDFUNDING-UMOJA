import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color:Color(0xFF13B156)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('About us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    
                    Image.asset("assets/images/logo_mini.png"),
                    SizedBox(height: 32),
                    Text(
                      'We Focus on the Digital Charity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna id volutpat lacus laoreet non curabitur gravida arcu. Amet nisl purus in mollis nunc sed id. Elementum curabitur vitae nunc sed. A pellentesque sit amet porttitor eget. Ac turpis egestas integer eget aliquet nibh. Nibh praesent tristique magna sit amet purus gravida.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Sagittis vitae et leo duis ut diam. Et pharetra pharetra massa massa. Faucibus et molestie ac feugiat. Ac feugiat sed lectus vestibulum. Sagittis eu volutpat odio facilisis. Venenaatis urna cursus eget nunc scelerisque viverra mauris. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat. Etiam tempor orci eu lobortis elementum nibh. Quis auctor elit sed vulputate mi sit.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Sagittis eu volutpat odio facilisis. Venenaatis urna cursus eget nunc scelerisque viverra mauris. Facilisi cras',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}