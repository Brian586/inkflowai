class Activity {
  final String? activityID;
  final String? title;
  final String? image;
  final String? description;

  Activity({this.activityID, this.title, this.image, this.description});
}

String lipsumDesc =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";

final List<Activity> activities = [
  Activity(
    activityID: "mosaic",
    title: "Mosaic",
    image: "mosaic",
    description:
        "Monitor mosaic coloring progress, segment completion percentage, and color tracking.",
  ),
  Activity(
    activityID: "stroke",
    title: "Stroke",
    image: "polyline",
    description: lipsumDesc,
  ),
  Activity(
    activityID: "difference",
    title: "Spot Difference",
    image: "difference",
    description: lipsumDesc,
  ),
  Activity(
    activityID: "paint",
    title: "Colour Images",
    image: "paint",
    description: lipsumDesc,
  ),
  Activity(
    activityID: "pick",
    title: "Pick Object",
    image: "paint",
    description: lipsumDesc,
  ),
  Activity(
    activityID: "match",
    title: "Match",
    image: "difference",
    description:
        "Match objects names with corresponding objects images on the right in real-time.",
  ),
  Activity(
    activityID: "find",
    title: "Find",
    image: "find",
    description: "Find a specific object within a crowded scene in real time!",
  ),
  Activity(
    activityID: "characters",
    title: "Characters",
    image: "find",
    description: "Identify numbers and handwritten characters in real time!",
  ),
];
