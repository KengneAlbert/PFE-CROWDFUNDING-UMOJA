import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umoja/models/projet_vote_model.dart';
import 'package:umoja/services/ProjetVoteService.dart';
import 'package:umoja/views/generalLayouts/ContainerBottom.dart';
import 'package:umoja/views/homepage/HomePage.dart';
import 'package:umoja/views/projetdocument/PdfViewerPage.dart';

class ProjectDocument extends StatelessWidget {
  final String projectId;

  const ProjectDocument({Key? key, required this.projectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final projectService = ProjetVoteService();

    return FutureBuilder<ProjetVoteModel?>(
      future: projectService.getProjetById(projectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
                backgroundColor: Color(0x13B1561A),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(child: Text('Error loading project')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('No Project'),
            ),
            body: Center(child: Text('No project found')),
          );
        } else {
          final ProjetVoteModel? project = snapshot.data;
          final documentUrls = project?.documents ?? [];

          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              title: Text(
                'Document',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      // Action when tapped
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF13B156).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: documentUrls.length,
              itemBuilder: (context, index) {
                final documentUrl = documentUrls[index];
                final int num = index + 1;
                return Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Image.asset("assets/images/health.png"),
                        title: Text(
                          "Documents $num",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [

                                Text(
                                  "PDF",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF858C94),
                                  ),
                                ),

                                SizedBox(width: 5,),
                                
                                SvgPicture.asset(
                                  'assets/icons/svg/super.svg',
                                  height: 15,
                                  width: 15,
                                  )

                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewerPage(
                                      url: documentUrl,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'See',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal:25, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(
                                    color: Colors.green,
                                    width: 3,
                                  ),
                                )
                              ),
                            ),
                          ),
                        )
                      ),
                  ],
                );
              },
            ),
            bottomNavigationBar: ContainerBottom(),
          );
        }
      },
    );
  }
}
