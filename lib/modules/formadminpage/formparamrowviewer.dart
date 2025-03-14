import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:intl/intl.dart';
import 'package:nodelistview/modules/vwformeditortab/vwformeditortab.dart';
import 'package:vwform/modules/noderowviewer/noderowviewer.dart';
import 'package:vwform/modules/vwform/vwformdefinition/vwformdefinition.dart';


class FormParamRowViewer extends NodeRowViewer {
  FormParamRowViewer(
      {required super.rowNode,
      required super.appInstanceParam,
      super.highlightedText});



  @override
  Widget build(BuildContext context) {
    Widget returnValue = Text(rowNode.recordId);

    Map<String, HighlightedWord> words = {};

    if (highlightedText != null) {
      words = {
        highlightedText!: HighlightedWord(
          onTap: () {
            print("this.highlightedText");
          },
          textStyle: TextStyle(backgroundColor: Colors.yellow),
        ),
      };
    }



    try {
      /*
      if (
          rowNode.content.linkbasemodel != null &&
          rowNode.content.linkbasemodel!.rendered!=null &&
          rowNode.content.linkbasemodel!.rendered!.className=="VwFormParam") {
        VwFormDefinition formParam =
        VwFormDefinition.fromJson(rowNode.content.linkbasemodel!.rendered!.data!);

        Widget captionRow=Expanded(flex:5, child:Container( child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            formParam.formName,
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 0), child:formParam.timestamp==null?Container(): Text("Update "+ DateFormat('dd-MMM-yyyy HH:mm', 'id_ID').format(formParam.timestamp!.updated.subtract(Duration(days: 90))),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),)),
        ])));

        Widget iconRow=Container(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),  child: Icon(Icons.list_alt,color: Colors.purple,),);

        Widget row=Flexible(child:Container(padding: EdgeInsets.all(10),  child: Row(children: [iconRow,captionRow])));

        returnValue = InkWell(
            onTap: () {
              print("form tapped");

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VwFormEditorTab (appInstanceParam: this.appInstanceParam, formParam: formParam)),
              );
            },
            child: row
                );
      }*/
    } catch (error) {
      returnValue = Text(rowNode.recordId + ': Error=' + error.toString());
    }

    return returnValue;
  }
}
