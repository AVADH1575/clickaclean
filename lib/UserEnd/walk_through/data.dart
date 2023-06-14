
class SliderModel{
  String imageAssetPath;
  String title;
  String desc;

  SliderModel(
      {
        this.imageAssetPath,this.title,this.desc
      });

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}

  List<SliderModel> getSlides(){
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel =  new SliderModel();

  //1
  sliderModel.setDesc("Professional Cleaning Service Let us do the dirty work!");
  sliderModel.setTitle("CLEANING SERVICES");
  sliderModel.setImageAssetPath("assets/images/walk-2x.png");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Professional Cleaning Service Let us do the dirty work!");
  sliderModel.setTitle("HOME CLEANING ");
  sliderModel.setImageAssetPath("assets/images/walk2-2x.png");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Professional Cleaning Service Let us do the dirty work!");
  sliderModel.setTitle("CAR CLEANING");
  sliderModel.setImageAssetPath("assets/images/walk3-2x.png");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  return slides;
  }