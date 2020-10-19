import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:happy/models/orphanage.dart';
import 'package:happy/widgets/contact-button.dart';
import 'package:happy/widgets/header.dart';
import 'package:happy/widgets/routes-map.dart';
import 'package:happy/widgets/schedule-item.dart';
import 'package:happy/widgets/separator.dart';
import 'package:happy/widgets/title-with-description.dart';

class OrphanageDetailsScreen extends StatefulWidget {
  final Orphanage orphanage;

  const OrphanageDetailsScreen({Key key, @required this.orphanage})
      : super(key: key);

  @override
  _OrphanageDetailsScreenState createState() => _OrphanageDetailsScreenState();
}

class _OrphanageDetailsScreenState extends State<OrphanageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final orphanage = widget.orphanage;

    return Scaffold(
      appBar: Header(
        title: orphanage.name,
        showCancel: false,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 240.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: orphanage.images
                  .map((image) => Image.network(image))
                  .toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TitleWithDescription(
                  title: orphanage.name,
                  description: orphanage.about,
                ),
                RoutesMap(),
                Separator(),
                TitleWithDescription(
                  title: 'Instruções para visita',
                  description: orphanage.instructions,
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ScheduleItem(
                        color: const Color(0xffe6f7fb),
                        borderColor: const Color(0xffb3dae2),
                        icon: Icon(Icons.alarm, color: const Color(0xff2ab5d1)),
                        text: 'Segunda à Sexta ${orphanage.openingHours}',
                      ),
                      if (orphanage.openOnWeekends == true)
                        ScheduleItem(
                          color: const Color(0xffedfff6),
                          borderColor: const Color(0xffa1e9c5),
                          icon: Icon(
                            Icons.info,
                            color: const Color(0xff39cc83),
                          ),
                          text: 'Atendemos fim de semana',
                        )
                      else
                        ScheduleItem(
                          color: const Color(0xfffdf0f5),
                          borderColor: const Color(0xffffbcd4),
                          icon: Icon(
                            Icons.info,
                            color: const Color(0xffff669d),
                          ),
                          text: 'Não atendemos fim de semana',
                        ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: ContactButton(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
