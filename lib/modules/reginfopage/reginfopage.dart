import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matrixclient2base/appconfig.dart';
import 'package:matrixclient2base/modules/base/vwdataformat/vwfiedvalue/vwfieldvalue.dart';
import 'package:matrixclient2base/modules/base/vwnode/vwnode.dart';
import 'package:nodelistview/modules/reginfopage/invalidticket.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vwform/modules/pagecoordinator/bloc/pagecoordinator_bloc.dart';
import 'package:vwform/modules/vwappinstanceparam/vwappinstanceparam.dart';
import 'package:vwform/modules/vwwidget/vwformresponseuserpage/branchviewer/branchviewer.dart';
import 'package:vwutil/modules/util/nodeutil.dart';
import 'package:matrixclient2base/appconfig.dart';

class RegInfoPage extends StatefulWidget {
  RegInfoPage({required this.state, required this.baseAppConfig});
  final RegInfoPagePagecoordinatorState state;

  final BaseAppConfig baseAppConfig;


  _RegInfoPageState createState() => _RegInfoPageState();
}

class _RegInfoPageState extends State<RegInfoPage> {
  Widget eventTitleWidget(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget organizationLogoWidget() {
    return Container(
        height: 80, child: Image.asset('assets/logo/logo_itb99_circle.png'));
  }

  Widget eventDescriptionWidget(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          description,
          style: TextStyle(fontSize: 18),
        ),
        /*
      Container(margin: EdgeInsets.all(10), height: 40, child:Image.asset('assets/logo/logo_itb99_circle.png')),
      Text("Reuni Perak ITB 99 6-7 Juli 2024 - Kampus ITB Ganesha ",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      Text("QR Code ini berfungsi sebagai Tanda Registrasi Untuk Masuk Gerbang Kampus ITB Ganesha & Registrasi di Meja Pendaftaran :"),
      Text("\n- 6 Juli 2024 99 The F Nite Fest - Malam Reuni Perak ITB 99 Open Gate pukul 15.00"),
      Text("- 7 Juli 2024 Golf ITB 99 di Lap. Dago Heritage"),
      Text("- 7 Juli 2024 Olahraga Pagi Bersama di Kampus Ganesha kumpul pukul 06.30 "),

       */
      ],
    );
  }

  Widget displayNodeContent(VwNode? node) {
    if (node != null) {
      VwFieldValue? nameFieldValue =
          node.content!.rowData!.getFieldByName("name");
      VwFieldValue? nimFieldValue =
          node.content!.rowData!.getFieldByName("nim");
      VwFieldValue? eventFieldValue =
          node.content!.rowData!.getFieldByName("event");

      VwFieldValue? regCodeFieldValue =
          node.content!.rowData!.getFieldByName("regcode");

      if (nameFieldValue != null &&
          nimFieldValue != null &&
          eventFieldValue != null) {
        Widget lEventTitleWidget = Container();
        Widget lDescriptionWidget = Container();
        Widget lNoteWidget = Container();

        try {
          VwNode? eventNode =
              NodeUtil.getNode(linkNode: eventFieldValue.valueLinkNode!);

          if (eventNode != null) {
            VwFieldValue? nameFieldName =
                eventNode.content.rowData!.getFieldByName("name");
            VwFieldValue? descriptionFieldName =
                eventNode.content.rowData!.getFieldByName("description");
            VwFieldValue? noteFieldName =
                eventNode.content.rowData!.getFieldByName("note");

            if (nameFieldName != null && nameFieldName.valueString != null) {
              lEventTitleWidget = eventTitleWidget(nameFieldName.valueString!);
            }

            if (descriptionFieldName != null &&
                descriptionFieldName.valueString != null) {
              lDescriptionWidget =
                  eventDescriptionWidget(descriptionFieldName.valueString!);
            }

            if (noteFieldName != null && noteFieldName.valueString != null) {
              lNoteWidget = Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(noteFieldName.valueString!));
            }
          }
        } catch (error) {}

        Widget backgroundTicket =
            Image.asset("assets/image/background_tiket_99_F_Nite_Fest.jpg");

        Widget ticketWidget = Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LayoutBuilder(builder: (context, constraint) {
              double height = 200;
              double width = 200;
              double logoSize = height * 0.1;

              if (constraint.hasInfiniteWidth == false &&
                  constraint.maxWidth > 0) {
                height = constraint.maxWidth;
                logoSize = height * 0.1;
              }

              return Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  //alignment: Alignment.center,

                  //constraints: BoxConstraints(maxHeight: 200),
                  margin: EdgeInsets.fromLTRB(
                      height * 0.1, width * 1.6, height * 0.1, 0),
                  child: QrImageView(
                    data: this.widget.baseAppConfig.generalConfig.baseUrl +
                        "/#/tiket/" +
                        Uri.encodeComponent(regCodeFieldValue!.valueString!),
                    version: QrVersions.auto,
                    size: 200,
                    gapless: false,
                    /*
            embeddedImage: AssetImage('assets/logo/logo_itb99_circle.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(logoSize, logoSize),
            ),*/
                  ));
            }),
            Text(
              nameFieldValue!.valueString.toString().toUpperCase(),
              style: TextStyle(
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Text(
              nimFieldValue!.valueString.toString(),
              style: TextStyle(backgroundColor: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),

            //SizedBox(height: 10,),
            //Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children:[organizationLogoWidget(),lEventTitleWidget]),
            Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: lDescriptionWidget),
            lNoteWidget,

            SizedBox(
              height: 100,
            )
            /*Container(margin: EdgeInsets.fromLTRB(20, 0, 20, 0), child:Text(
              "Checkpoint QR Code di Gerbang Masuk Kampus ITB Ganesha & Meja Registrasi")),*/
          ],
        ));

        return Stack(
          alignment: Alignment.topCenter,
          children: [backgroundTicket, ticketWidget],
        );
      } else {
        return InvalidTicketPage();
        ;
      }
    } else {
      return InvalidTicketPage();
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      try {
        double sideMargin = 0;
        if (constraint.maxWidth > 500) {
          sideMargin = (constraint.maxWidth - 500) / 2;
        }

        return MaterialApp(
            home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.fromLTRB(sideMargin, 0, sideMargin, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [displayNodeContent(widget.state.regInfoNode)],
            ),
          )),
        ));
      } catch (error) {
        return InvalidTicketPage();
      }
    });
  }
}
