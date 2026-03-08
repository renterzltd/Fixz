import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../model/model_agent_profile.dart';

class ContractorProfile extends StatelessWidget {
  final AgentProfileData agentProfile;
  const ContractorProfile({super.key, required this.agentProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.white.lightColorHex(),
        iconTheme: IconThemeData(
          color: AppColors.colorPrimaryDark.lightColorHex(),
        ),
        title: setCommonText(
          'Professionals Details',
          color: AppColors.colorPrimaryDark.lightColorHex(),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColors.white.lightColorHex(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            setHeight(20),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: SizedBox(
                height: 80,
                width: 80,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: agentProfile.profilePicture ?? '',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Image.asset(
                    APPIMAGES.dummyUser,
                  ),
                ),
              ),
            ),
            setHeight(16),
            setCommonText(
              agentProfile.name ?? '',
              color: AppColors.black.lightColorHex(),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            setHeight(30),
            Row(
              children: [
                Expanded(
                  child: CommonUserSection(
                    title: 'AVG. RATING',
                    value: '${agentProfile.avgReviews ?? 0.0}',
                    isReview: true,
                  ),
                ),
                Expanded(
                  child: CommonUserSection(
                    title: 'REVIEWS',
                    value: '${agentProfile.totalReviews ?? 0.0}',
                  ),
                ),
                Expanded(
                  child: CommonUserSection(
                    title: 'HIRED',
                    value: '${agentProfile.totalJobs ?? 0.0}',
                  ),
                ),
              ],
            ),
            setHeight(20),
            Divider(color: AppColors.gray.lightColorHex()),
            CommonProgressIndicator(
                title: 'Excellent(${agentProfile.exellentCount})',
                value: '${agentProfile.exellentCount}'),
            CommonProgressIndicator(
                title: 'Good(${agentProfile.verygoodCount})',
                value: '${agentProfile.verygoodCount}'),
            CommonProgressIndicator(
                title: 'Average(${agentProfile.goodCount})',
                value: '${agentProfile.goodCount}'),
            CommonProgressIndicator(
                title: 'Bad(${agentProfile.averageCount})',
                value: '${agentProfile.averageCount}'),
            CommonProgressIndicator(
                title: 'Terrible(${agentProfile.poorCount})',
                value: '${agentProfile.poorCount}'),
            setHeight(8),
            Divider(color: AppColors.gray.lightColorHex()),
            if (agentProfile.fbLink != null)
              CommonSocialMediaLinkWidget(
                link: agentProfile.fbLink!,
                title: 'Facebook Profile: ',
              ),
            if (agentProfile.instaLink != null)
              CommonSocialMediaLinkWidget(
                link: agentProfile.instaLink!,
                title: 'Instagram Profile: ',
              ),
            if (agentProfile.tiktokLink != null)
              CommonSocialMediaLinkWidget(
                link: agentProfile.tiktokLink!,
                title: 'TikTok Profile: ',
              ),
            if (agentProfile.companyLink != null)
              CommonSocialMediaLinkWidget(
                link: agentProfile.companyLink!,
                title: 'Company Profile: ',
              ),
            Divider(color: AppColors.gray.lightColorHex()),
            setHeight(8),
            setCommonText(
              'REVIEWS',
              color: AppColors.black.lightColorHex(),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            setHeight(20),
            CommonReviewList(
              reviewList: agentProfile.reviewList ?? [],
            ),
          ],
        ),
      ),
    );
  }
}

class CommonSocialMediaLinkWidget extends StatelessWidget {
  final String title;
  final String link;
  const CommonSocialMediaLinkWidget(
      {super.key, required this.title, required this.link});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          setCommonText(
            title,
            fontSize: 16,
            color: Colors.grey.shade700,
          ),
          setWidth(5),
          Expanded(
            child: setCommonText(
              link,
              fontSize: 16,
              color: AppColors.gray_mid.lightColorHex(),
              noOfLine: 2,
            ),
          ),
          setWidth(5),
          InkWell(
            onTap: () {
              if (Uri.parse(link).host.isNotEmpty) {
                SharedManager.shared.openSocialMediaProfile(link);
              } else {
                AlertClass.shared.setSnackbar('Invalid website link');
              }
            },
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.colorPrimaryDark.lightColorHex(),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonReviewList extends StatelessWidget {
  final List<ReviewList> reviewList;
  const CommonReviewList({super.key, required this.reviewList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: reviewList.length,
      itemBuilder: (context, index) {
        final item = reviewList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: setCommonText(
                      item.name ?? '',
                      color: AppColors.black.lightColorHex(),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  setCommonText(
                    item.created ?? '',
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              setHeight(8),
              RatingBar.builder(
                initialRating: double.parse('${item.reviews ?? 0.0}'),
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 16,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: AppColors.colorPrimaryDark.lightColorHex(),
                ),
                onRatingUpdate: (rating) {},
              ),
              setHeight(8),
              if (item.message != null)
                setCommonText(
                  item.message!,
                  noOfLine: 5,
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(color: AppColors.gray.lightColorHex());
      },
    );
  }
}

class CommonProgressIndicator extends StatelessWidget {
  final String title;
  final String value;
  const CommonProgressIndicator(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          setWidth(16),
          Expanded(
            child: setCommonText(
              title,
              color: AppColors.gray.lightColorHex(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 6.0,
                animationDuration: 2000,
                percent: double.parse(value) / 100,
                barRadius: const Radius.circular(12),
                progressColor: AppColors.colorPrimaryDark.lightColorHex(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonUserSection extends StatelessWidget {
  final String title;
  final String value;
  final bool isReview;
  const CommonUserSection({
    super.key,
    required this.title,
    required this.value,
    this.isReview = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        setCommonText(
          title,
          color: Colors.grey.shade600,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        setHeight(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isReview)
              Icon(
                Icons.star,
                color: AppColors.colorPrimaryDark.lightColorHex(),
              ),
            Flexible(
              child: setCommonText(
                value,
                color: isReview
                    ? AppColors.colorPrimaryDark.lightColorHex()
                    : AppColors.black.lightColorHex(),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textAlignment: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
