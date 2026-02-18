


const double defaultBorderRadius = 16.0;
const double defaultVerticalMargin = 10.0;
const double smallBorderRadius = 12.0;


// Icon Sizes
const double largeIconSize = 28.0;
const double mediumIconSize = 26.0;

class Utils{
  String formatTime(String time) {
    final date = DateTime.parse(time);
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

}

