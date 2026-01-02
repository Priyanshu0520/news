class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://newsdata.io/api/1';
  
  // API Key
  static const String apiKey = 'pub_dd64dfe3df4c4c198f90e0e048e05a2d';
  
  // Endpoints
  static const String latest = '/latest';
  
  // Countries
  static const String countryIndia = 'in';
  
  // India-focused search queries
  static const String indiaLatest = 'India latest news';
  static const String indiaPolitics = 'Indian politics';
  static const String indiaSports = 'Indian sports';
  static const String indiaBusiness = 'India business';
  static const String indiaEcommerce = 'India e-commerce technology';
  static const String bollywood = 'Bollywood';
  static const String indiaBreaking = 'India breaking news';
  static const String indiaHot = 'India trending';
  
  // Category Keywords
  static const List<Map<String, String>> indiaCategories = [
    {'title': 'Latest News', 'query': 'India latest news', 'icon': 'fiber_new'},
    {'title': 'Politics', 'query': 'Indian politics', 'icon': 'account_balance'},
    {'title': 'Sports', 'query': 'Indian sports cricket', 'icon': 'sports_cricket'},
    {'title': 'Business', 'query': 'India business economy', 'icon': 'business_center'},
    {'title': 'Technology', 'query': 'India technology startups', 'icon': 'computer'},
    {'title': 'Bollywood', 'query': 'Bollywood entertainment', 'icon': 'movie'},
    {'title': 'Breaking', 'query': 'India breaking news today', 'icon': 'notifications_active'},
    {'title': 'Trending', 'query': 'India trending viral', 'icon': 'trending_up'},
  ];
}
