import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.dart';

final mockFeedbackParameterTaxiGood1 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Good Driving",
  isGood: true,
);

final mockFeedbackParameterTaxiBad1 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Bad Driving",
  isGood: false,
);

final mockFeedbackParameterTaxiGood2 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Good Car",
  isGood: true,
);

final mockFeedbackParameterTaxiBad2 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Bad Car",
  isGood: false,
);

final mockFeedbackParameterTaxiGood3 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Good Service",
  isGood: true,
);

final mockFeedbackParameterTaxiBad3 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Bad Service",
  isGood: false,
);

final mockFeedbackParameterTaxiGood4 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Good Price",
  isGood: true,
);

final mockFeedbackParameterTaxiBad4 = Fragment$reviewTaxiParameter(
  id: "1",
  title: "Bad Price",
  isGood: false,
);

final mockReviewTaxi1 = Fragment$reviewTaxi(
  id: "1",
  score: 90,
  description: "Good",
  reviewTimestamp: DateTime.now().subtract(const Duration(days: 1)),
  requestId: "1",
  driver: mockDriverName1,
  parameters: [
    mockFeedbackParameterTaxiGood1,
    mockFeedbackParameterTaxiGood2,
    mockFeedbackParameterTaxiGood3,
    mockFeedbackParameterTaxiBad1,
    mockFeedbackParameterTaxiBad2,
  ],
);

final mockReviewTaxi2 = Fragment$reviewTaxi(
  id: "2",
  score: 70,
  description: "Bad",
  reviewTimestamp: DateTime.now().subtract(const Duration(days: 2)),
  requestId: "1",
  driver: mockDriverName1,
  parameters: [
    mockFeedbackParameterTaxiGood1,
    mockFeedbackParameterTaxiGood2,
    mockFeedbackParameterTaxiBad3,
    mockFeedbackParameterTaxiBad4,
  ],
);

final mockReviewTaxi3 = Fragment$reviewTaxi(
  id: "3",
  score: 80,
  description: "Good",
  reviewTimestamp: DateTime.now().subtract(const Duration(days: 14)),
  requestId: "1",
  driver: mockDriverName1,
  parameters: [
    mockFeedbackParameterTaxiGood1,
    mockFeedbackParameterTaxiGood2,
    mockFeedbackParameterTaxiGood3,
    mockFeedbackParameterTaxiGood4,
  ],
);

final mockReviewTaxi4 = Fragment$reviewTaxi(
  id: "4",
  score: 60,
  description: "Bad",
  reviewTimestamp: DateTime.now().subtract(const Duration(hours: 4)),
  requestId: "1",
  driver: mockDriverName1,
  parameters: [
    mockFeedbackParameterTaxiBad1,
    mockFeedbackParameterTaxiBad2,
    mockFeedbackParameterTaxiBad3,
    mockFeedbackParameterTaxiBad4,
  ],
);

final mockReviewsTaxi = [
  mockReviewTaxi1,
  mockReviewTaxi2,
  mockReviewTaxi3,
  mockReviewTaxi4,
];

final mockReviewTaxiParameterListItem1 = Fragment$reviewTaxiParameterListItem(
  id: "1",
  title: "Good Driving",
  isGood: true,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 1,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItem2 = Fragment$reviewTaxiParameterListItem(
  id: "2",
  title: "Good Car",
  isGood: true,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 2,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItem3 = Fragment$reviewTaxiParameterListItem(
  id: "3",
  title: "Good Service",
  isGood: true,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 3,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItem4 = Fragment$reviewTaxiParameterListItem(
  id: "4",
  title: "Good Price",
  isGood: true,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 4,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItem5 = Fragment$reviewTaxiParameterListItem(
  id: "5",
  title: "Bad Driving",
  isGood: false,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 5,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItem6 = Fragment$reviewTaxiParameterListItem(
  id: "6",
  title: "Bad Car",
  isGood: false,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 6,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItem7 = Fragment$reviewTaxiParameterListItem(
  id: "7",
  title: "Bad Service",
  isGood: false,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 7,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItem8 = Fragment$reviewTaxiParameterListItem(
  id: "8",
  title: "Bad Price",
  isGood: false,
  feedbacksAggregate: [
    Fragment$reviewTaxiParameterListItem$feedbacksAggregate(
      count: Fragment$reviewTaxiParameterListItem$feedbacksAggregate$count(
        id: 8,
      ),
    ),
  ],
);

final mockReviewTaxiParameterListItems = [
  mockReviewTaxiParameterListItem1,
  mockReviewTaxiParameterListItem2,
  mockReviewTaxiParameterListItem3,
  mockReviewTaxiParameterListItem4,
  mockReviewTaxiParameterListItem5,
  mockReviewTaxiParameterListItem6,
  mockReviewTaxiParameterListItem7,
  mockReviewTaxiParameterListItem8,
];
