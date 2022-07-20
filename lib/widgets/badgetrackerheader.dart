import 'package:badgetracker/utils/utils.dart';
import 'package:badgetracker/widgets/gcloudlogoanim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BadgeTrackerHeader extends StatefulWidget {
  const BadgeTrackerHeader({Key? key}) : super(key: key);

  @override
  State<BadgeTrackerHeader> createState() => _BadgeTrackerHeaderState();
}

class _BadgeTrackerHeaderState extends State<BadgeTrackerHeader> with SingleTickerProviderStateMixin {
  
  late AnimationController ctrl;

  @override
  void initState() {
    super.initState();

    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    )..forward();
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            offset: const Offset(0, 5),
            blurRadius: 10
          )
        ]
      ),
      child: Row(
        children: [
          Row(
            children: [
              const GCloudLogoAnim(animate: false, animateOnce: true, colorLogo: true, scale: 0.2),
              const SizedBox(width: 10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  FadeTransition(
                    opacity: Tween<double>(
                      begin: 0.0, end: 1.0
                    ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut)),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.25, 0.0),
                        end: const Offset(0.0, 0.0)
                      ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Road to Certification',
                                style: TextStyle(color: Utils.darkGrey, fontSize: 15)
                              ),
                              Text('Badge Tracker',
                                style: TextStyle(color: Utils.darkGrey, fontSize: 30, fontWeight: FontWeight.bold)
                              )
                            ],
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Utils.mainBlue.withOpacity(0.2),
                                width: 3
                              ),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: const Text(
                              'Associate Cloud Engineer',
                              style: TextStyle(color: Utils.mainBlue)
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}