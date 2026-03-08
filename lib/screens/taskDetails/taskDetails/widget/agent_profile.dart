import 'package:fixz/hdHelper/commonWidget.dart';
import 'package:fixz/model/model_track_contractor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentProfile extends StatelessWidget {
  final ContractorData? contractorData;

  const AgentProfile({super.key, this.contractorData});

  _setCommonField(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setHeight(10),
        setCommonText(
          title,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        setCommonText(
          value,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ],
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _setCommonField('Name:', '${contractorData?.name}'),
          _setCommonField('Address:', '${contractorData?.address}'),
          _setCommonField('Description:', '${contractorData?.description}'),
          if (contractorData?.fbLink != null)
            InkWell(
              onTap: () {
                _launchUrl('${contractorData?.fbLink}');
              },
              child: _setCommonField('Facebook:', '${contractorData?.fbLink}'),
            ),
          if (contractorData?.fbLink != null)
            InkWell(
              onTap: () {
                _launchUrl('${contractorData?.instaLink}');
              },
              child:
                  _setCommonField('Instagram:', '${contractorData?.instaLink}'),
            ),
          if (contractorData?.fbLink != null)
            InkWell(
              onTap: () {
                _launchUrl('${contractorData?.tiktokLink}');
              },
              child:
                  _setCommonField('TikTok:', '${contractorData?.tiktokLink}'),
            ),
        ],
      ),
    );
  }
}
