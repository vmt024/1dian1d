//	HYPE.documents["1dian1di"]

(function HYPE_DocumentLoader() {
	var resourcesFolderName = "1dian1di_Resources";
	var documentName = "1dian1di";

	// load HYPE.js if it hasn't been loaded yet
	if(typeof HYPE == "undefined") {
		if(typeof window.HYPE_DocumentsToLoad == "undefined") {
			window.HYPE_DocumentsToLoad = new Array();
		}
		window.HYPE_DocumentsToLoad.push(HYPE_DocumentLoader);

		var headElement = document.getElementsByTagName('head')[0];
		var scriptElement = document.createElement('script');
		scriptElement.type= 'text/javascript';
		scriptElement.src = resourcesFolderName + '/' + 'HYPE.js';
		headElement.appendChild(scriptElement);
		return;
	}
	
	var attributeTransformerMapping = {"BoxShadowBlurRadius":"PixelValueTransformer","BackgroundColor":"ColorValueTransformer","BorderWidthBottom":"PixelValueTransformer","WordSpacing":"PixelValueTransformer","BoxShadowXOffset":"PixelValueTransformer","Opacity":"FractionalValueTransformer","BorderWidthRight":"PixelValueTransformer","BorderWidthTop":"PixelValueTransformer","BoxShadowColor":"ColorValueTransformer","BorderColorBottom":"ColorValueTransformer","FontSize":"PixelValueTransformer","BorderRadiusTopRight":"PixelValueTransformer","TextColor":"ColorValueTransformer","Rotate":"DegreeValueTransformer","Height":"PixelValueTransformer","BorderColorTop":"ColorValueTransformer","PaddingLeft":"PixelValueTransformer","Top":"PixelValueTransformer","BackgroundGradientStartColor":"ColorValueTransformer","TextShadowXOffset":"PixelValueTransformer","PaddingTop":"PixelValueTransformer","BackgroundGradientAngle":"DegreeValueTransformer","PaddingBottom":"PixelValueTransformer","PaddingRight":"PixelValueTransformer","BorderColorLeft":"ColorValueTransformer","Width":"PixelValueTransformer","TextShadowColor":"ColorValueTransformer","ReflectionOffset":"PixelValueTransformer","Left":"PixelValueTransformer","BorderRadiusBottomRight":"PixelValueTransformer","LineHeight":"PixelValueTransformer","ReflectionDepth":"FractionalValueTransformer","BorderColorRight":"ColorValueTransformer","BorderRadiusBottomLeft":"PixelValueTransformer","BorderWidthLeft":"PixelValueTransformer","TextShadowBlurRadius":"PixelValueTransformer","TextShadowYOffset":"PixelValueTransformer","BorderRadiusTopLeft":"PixelValueTransformer","BackgroundGradientEndColor":"ColorValueTransformer","BoxShadowYOffset":"PixelValueTransformer","LetterSpacing":"PixelValueTransformer"};

var scenes = [{"timelines":{"kTimelineDefaultIdentifier":{"framesPerSecond":30,"animations":[{"startValue":"360px","isRelative":true,"endValue":"0px","identifier":"Left","duration":1,"timingFunction":"easeinout","type":0,"oid":"A4B2A119-4FCB-49BA-B6A8-0452505DE698-203-00000222D672A852","startTime":0},{"startValue":"80deg","isRelative":true,"endValue":"0deg","identifier":"Rotate","duration":1,"timingFunction":"easeinout","type":0,"oid":"A4B2A119-4FCB-49BA-B6A8-0452505DE698-203-00000222D672A852","startTime":0},{"startValue":"0.279720","isRelative":true,"endValue":"0.884615","identifier":"Opacity","duration":1,"timingFunction":"easeinout","type":0,"oid":"A4B2A119-4FCB-49BA-B6A8-0452505DE698-203-00000222D672A852","startTime":0},{"startValue":"556px","isRelative":true,"endValue":"-554px","identifier":"Left","duration":0.5333333,"timingFunction":"easeout","type":0,"oid":"1AAC2C9A-B613-4219-9CBB-178A48CA53D5-203-00000267E34A683F","startTime":1}],"identifier":"kTimelineDefaultIdentifier","name":"Main Timeline","duration":1.533333}},"id":"862C0645-8878-4E1C-8CAD-085929EE6963-203-00000222D6A3F48F","sceneIndex":0,"perspective":"600px","oid":"862C0645-8878-4E1C-8CAD-085929EE6963-203-00000222D6A3F48F","initialValues":{"1AAC2C9A-B613-4219-9CBB-178A48CA53D5-203-00000267E34A683F":{"BorderWidthBottom":"0px","TagName":"div","BorderColorBottom":"#A0A0A0","BorderStyleRight":"None","BorderStyleBottom":"None","Top":"79px","BorderWidthRight":"0px","BorderStyleLeft":"None","BorderColorTop":"#A0A0A0","BorderColorLeft":"#A0A0A0","Position":"absolute","Height":"5px","Left":"556px","BorderColorRight":"#A0A0A0","BorderStyleTop":"None","Width":"538px","ZIndex":"2","BorderWidthTop":"0px","Overflow":"visible","BorderWidthLeft":"0px","BackgroundColor":"#F99F01"},"A4B2A119-4FCB-49BA-B6A8-0452505DE698-203-00000222D672A852":{"Position":"absolute","BackgroundOrigin":"content-box","Left":"360px","Display":"inline","BackgroundImage":"tagline-1-1-1.png","RotationAxis":"1","Height":"100px","Opacity":"0.279720","Overflow":"visible","Top":"1px","Width":"540px","ZIndex":"1","BackgroundSize":"100% 100%","TagName":"div","InnerHTML":"","Rotate":"80deg"}},"name":"tagline Copy","backgroundColor":"#FFFFFF"}];

var javascriptMapping = {};


	
	var Custom = (function() {
	return {
	};
}());

	
	var hypeDoc = new HYPE();
	
	hypeDoc.attributeTransformerMapping = attributeTransformerMapping;
	hypeDoc.scenes = scenes;
	hypeDoc.javascriptMapping = javascriptMapping;
	hypeDoc.Custom = Custom;
	hypeDoc.currentSceneIndex = 0;
	hypeDoc.mainContentContainerID = "1dian1di_hype_container";
	hypeDoc.resourcesFolderName = resourcesFolderName;
	hypeDoc.showHypeBuiltWatermark = 0;
	hypeDoc.showLoadingPage = false;
	hypeDoc.drawSceneBackgrounds = true;
	hypeDoc.documentName = documentName;

	HYPE.documents[documentName] = hypeDoc.API;

	hypeDoc.documentLoad(this.body);
}());

