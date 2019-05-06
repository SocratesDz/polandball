class RedditResponse {
  String kind;
  Data data;

  RedditResponse({this.kind, this.data});

  RedditResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String modhash;
  int dist;
  List<Post> children;
  String after;
  String before;

  Data({this.modhash, this.dist, this.children, this.after, this.before});

  Data.fromJson(Map<String, dynamic> json) {
    modhash = json['modhash'];
    dist = json['dist'];
    if (json['children'] != null) {
      children = new List<Post>();
      json['children'].forEach((v) {
        children.add(new Post.fromJson(v));
      });
    }
    after = json['after'];
    before = json['before'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modhash'] = this.modhash;
    data['dist'] = this.dist;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    data['after'] = this.after;
    data['before'] = this.before;
    return data;
  }
}

class Post {
  String kind;
  PostData data;

  Post({this.kind, this.data});

  Post.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    data = json['data'] != null ? new PostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PostData {
  String subreddit;
  bool clicked;
  String title;
  String subredditNamePrefixed;
  bool hidden;
  int pwls;
  int downs;
  int thumbnailHeight;
  bool hideScore;
  String name;
  bool quarantine;
  String subredditType;
  int ups;
  String domain;
  int thumbnailWidth;
  bool isOriginalContent;
  bool isRedditMediaDomain;
  String linkFlairText;
  bool canModPost;
  int score;
  String thumbnail;
  String postHint;
  bool isSelf;
  double created;
  int wls;
  String authorFlairType;
  bool contestMode;
  String selftextHtml;
  bool archived;
  bool noFollow;
  bool isCrosspostable;
  bool pinned;
  bool over18;
  Preview preview;
  bool mediaOnly;
  String linkFlairTemplateId;
  bool canGild;
  bool spoiler;
  bool locked;
  String authorFlairText;
  String rteMode;
  bool visited;
  String subredditId;
  String id;
  String author;
  int numComments;
  bool sendReplies;
  String permalink;
  String parentWhitelistStatus;
  String url;
  int subredditSubscribers;
  double createdUtc;
  bool isVideo;

  PostData(
      {this.subreddit,
      this.clicked,
      this.title,
      this.subredditNamePrefixed,
      this.hidden,
      this.pwls,
      this.downs,
      this.thumbnailHeight,
      this.hideScore,
      this.name,
      this.quarantine,
      this.subredditType,
      this.ups,
      this.domain,
      this.thumbnailWidth,
      this.isOriginalContent,
      this.isRedditMediaDomain,
      this.linkFlairText,
      this.canModPost,
      this.score,
      this.thumbnail,
      this.postHint,
      this.isSelf,
      this.created,
      this.wls,
      this.authorFlairType,
      this.contestMode,
      this.selftextHtml,
      this.archived,
      this.noFollow,
      this.isCrosspostable,
      this.pinned,
      this.over18,
      this.preview,
      this.mediaOnly,
      this.linkFlairTemplateId,
      this.canGild,
      this.spoiler,
      this.locked,
      this.authorFlairText,
      this.rteMode,
      this.visited,
      this.subredditId,
      this.id,
      this.author,
      this.numComments,
      this.sendReplies,
      this.permalink,
      this.parentWhitelistStatus,
      this.url,
      this.subredditSubscribers,
      this.createdUtc,
      this.isVideo});

  PostData.fromJson(Map<String, dynamic> json) {
    subreddit = json['subreddit'];
    clicked = json['clicked'];
    title = json['title'];
    subredditNamePrefixed = json['subreddit_name_prefixed'];
    hidden = json['hidden'];
    pwls = json['pwls'];
    downs = json['downs'];
    thumbnailHeight = json['thumbnail_height'];
    hideScore = json['hide_score'];
    name = json['name'];
    quarantine = json['quarantine'];
    subredditType = json['subreddit_type'];
    ups = json['ups'];
    domain = json['domain'];
    thumbnailWidth = json['thumbnail_width'];
    isOriginalContent = json['is_original_content'];
    isRedditMediaDomain = json['is_reddit_media_domain'];
    linkFlairText = json['link_flair_text'];
    canModPost = json['can_mod_post'];
    score = json['score'];
    thumbnail = json['thumbnail'];
    postHint = json['post_hint'];
    isSelf = json['is_self'];
    created = json['created'];
    wls = json['wls'];
    authorFlairType = json['author_flair_type'];
    contestMode = json['contest_mode'];
    selftextHtml = json['selftext_html'];
    archived = json['archived'];
    noFollow = json['no_follow'];
    isCrosspostable = json['is_crosspostable'];
    pinned = json['pinned'];
    over18 = json['over_18'];
    preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
    mediaOnly = json['media_only'];
    linkFlairTemplateId = json['link_flair_template_id'];
    canGild = json['can_gild'];
    spoiler = json['spoiler'];
    locked = json['locked'];
    authorFlairText = json['author_flair_text'];
    rteMode = json['rte_mode'];
    visited = json['visited'];
    id = json['id'];
    author = json['author'];
    numComments = json['num_comments'];
    sendReplies = json['send_replies'];
    permalink = json['permalink'];
    parentWhitelistStatus = json['parent_whitelist_status'];
    url = json['url'];
    subredditSubscribers = json['subreddit_subscribers'];
    createdUtc = json['created_utc'];
    isVideo = json['is_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subreddit'] = this.subreddit;
    data['clicked'] = this.clicked;
    data['title'] = this.title;
    data['subreddit_name_prefixed'] = this.subredditNamePrefixed;
    data['hidden'] = this.hidden;
    data['pwls'] = this.pwls;
    data['downs'] = this.downs;
    data['thumbnail_height'] = this.thumbnailHeight;
    data['hide_score'] = this.hideScore;
    data['name'] = this.name;
    data['quarantine'] = this.quarantine;
    data['subreddit_type'] = this.subredditType;
    data['ups'] = this.ups;
    data['domain'] = this.domain;
    data['thumbnail_width'] = this.thumbnailWidth;
    data['is_original_content'] = this.isOriginalContent;
    data['is_reddit_media_domain'] = this.isRedditMediaDomain;
    data['link_flair_text'] = this.linkFlairText;
    data['can_mod_post'] = this.canModPost;
    data['score'] = this.score;
    data['thumbnail'] = this.thumbnail;
    data['post_hint'] = this.postHint;
    data['is_self'] = this.isSelf;
    data['created'] = this.created;
    data['wls'] = this.wls;
    data['author_flair_type'] = this.authorFlairType;
    data['contest_mode'] = this.contestMode;
    data['selftext_html'] = this.selftextHtml;
    data['archived'] = this.archived;
    data['no_follow'] = this.noFollow;
    data['is_crosspostable'] = this.isCrosspostable;
    data['pinned'] = this.pinned;
    data['over_18'] = this.over18;
    if (this.preview != null) {
      data['preview'] = this.preview.toJson();
    }
    data['media_only'] = this.mediaOnly;
    data['link_flair_template_id'] = this.linkFlairTemplateId;
    data['can_gild'] = this.canGild;
    data['spoiler'] = this.spoiler;
    data['locked'] = this.locked;
    data['author_flair_text'] = this.authorFlairText;
    data['rte_mode'] = this.rteMode;
    data['visited'] = this.visited;
    data['id'] = this.id;
    data['author'] = this.author;
    data['num_comments'] = this.numComments;
    data['send_replies'] = this.sendReplies;
    data['permalink'] = this.permalink;
    data['parent_whitelist_status'] = this.parentWhitelistStatus;
    data['url'] = this.url;
    data['subreddit_subscribers'] = this.subredditSubscribers;
    data['created_utc'] = this.createdUtc;
    data['is_video'] = this.isVideo;
    return data;
  }
}

class Preview {
  List<Images> images;
  bool enabled;

  Preview({this.images, this.enabled});

  Preview.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['enabled'] = this.enabled;
    return data;
  }
}

class Images {
  Source source;
  List<Resolutions> resolutions;
  String id;

  Images({this.source, this.resolutions, this.id});

  Images.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    if (json['resolutions'] != null) {
      resolutions = new List<Resolutions>();
      json['resolutions'].forEach((v) {
        resolutions.add(new Resolutions.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    if (this.resolutions != null) {
      data['resolutions'] = this.resolutions.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Source {
  String url;
  int width;
  int height;

  Source({this.url, this.width, this.height});

  Source.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Resolutions {
  String url;
  int width;
  int height;

  Resolutions({this.url, this.width, this.height});

  Resolutions.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
