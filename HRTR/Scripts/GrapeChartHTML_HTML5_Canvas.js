(function (cjs, an) {

	var p; // shortcut to reference prototypes
	var lib = {}; var ss = {}; var img = {};
	lib.ssMetadata = [
		{ name: "GrapeChartHTML_HTML5_Canvas_atlas_", frames: [[0, 682, 141, 124], [143, 682, 139, 121], [0, 346, 334, 334], [0, 0, 344, 344]] }
	];


	// symbols:



	(lib.Bitmap1 = function () {
		this.initialize(ss["GrapeChartHTML_HTML5_Canvas_atlas_"]);
		this.gotoAndStop(0);
	}).prototype = p = new cjs.Sprite();



	(lib.Bitmap2 = function () {
		this.initialize(ss["GrapeChartHTML_HTML5_Canvas_atlas_"]);
		this.gotoAndStop(1);
	}).prototype = p = new cjs.Sprite();



	(lib.CachedTexturedBitmap_1 = function () {
		this.initialize(ss["GrapeChartHTML_HTML5_Canvas_atlas_"]);
		this.gotoAndStop(2);
	}).prototype = p = new cjs.Sprite();



	(lib.CachedTexturedBitmap_2 = function () {
		this.initialize(ss["GrapeChartHTML_HTML5_Canvas_atlas_"]);
		this.gotoAndStop(3);
	}).prototype = p = new cjs.Sprite();
	// helper functions:

	function mc_symbol_clone() {
		var clone = this._cloneProps(new this.constructor(this.mode, this.startPosition, this.loop));
		clone.gotoAndStop(this.currentFrame);
		clone.paused = this.paused;
		clone.framerate = this.framerate;
		return clone;
	}

	function getMCSymbolPrototype(symbol, nominalBounds, frameBounds) {
		var prototype = cjs.extend(symbol, cjs.MovieClip);
		prototype.clone = mc_symbol_clone;
		prototype.nominalBounds = nominalBounds;
		prototype.frameBounds = frameBounds;
		return prototype;
	}


	(lib.LeafR = function (mode, startPosition, loop) {
		this.initialize(mode, startPosition, loop, {});

		// Layer_1
		this.instance = new lib.Bitmap1();
		this.instance.parent = this;
		this.instance.setTransform(0, 0, 2.5532, 2.4193);

		this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	}).prototype = getMCSymbolPrototype(lib.LeafR, new cjs.Rectangle(0, 0, 360, 300), null);


	(lib.LeafL = function (mode, startPosition, loop) {
		this.initialize(mode, startPosition, loop, {});

		// Layer_1
		this.instance = new lib.Bitmap2();
		this.instance.parent = this;
		this.instance.setTransform(0, 0, 2.5899, 2.4793);

		this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	}).prototype = getMCSymbolPrototype(lib.LeafL, new cjs.Rectangle(0, 0, 360, 300), null);


	(lib.Circle = function (mode, startPosition, loop) {
		this.initialize(mode, startPosition, loop, {});

		// Layer_1
		this.instance = new lib.CachedTexturedBitmap_1();
		this.instance.parent = this;
		this.instance.setTransform(-0.95, -0.95, 0.4696, 0.4696);

		this.timeline.addTween(cjs.Tween.get(this.instance).wait(1));

	}).prototype = getMCSymbolPrototype(lib.Circle, new cjs.Rectangle(-0.9, -0.9, 156.8, 156.8), null);


	(lib.CircleAndDay = function (mode, startPosition, loop) {
		this.initialize(mode, startPosition, loop, {});

		// Layer_1
		this.Day = new cjs.Text("1", "bold 80px 'Verdana'");
		this.Day.name = "Day";
		this.Day.textAlign = "center";
		this.Day.lineHeight = 99;
		this.Day.lineWidth = 122;
		this.Day.parent = this;
		this.Day.setTransform(79, 26);

		this.Circle = new lib.Circle();
		this.Circle.name = "Circle";
		this.Circle.parent = this;
		this.Circle.setTransform(78.5, 77.5, 1.0647, 1.0647, 0, 0, 0, 77.5, 77.5);

		this.instance = new lib.CachedTexturedBitmap_2();
		this.instance.parent = this;
		this.instance.setTransform(-7.55, -8.5, 0.5, 0.5);

		this.timeline.addTween(cjs.Tween.get({}).to({ state: [{ t: this.instance }, { t: this.Circle }, { t: this.Day }] }).wait(4));

	}).prototype = p = new cjs.MovieClip();
	p.nominalBounds = new cjs.Rectangle(-7.5, -8.5, 172, 172);


	// stage content:
	(lib.GrapeChartHTML_HTML5_Canvas = function (mode, startPosition, loop) {
		this.initialize(mode, startPosition, loop, {});

		// timeline functions:
		this.frame_0 = function () {

		}

		// actions tween:
		this.timeline.addTween(cjs.Tween.get(this).call(this.frame_0).wait(3));

		this.CircleAndDay31 = new lib.CircleAndDay();
		this.CircleAndDay31.name = "CircleAndDay31";
		this.CircleAndDay31.parent = this;
		this.CircleAndDay31.setTransform(606.35, 1532.6, 1, 1, 0, 0, 0, 78.5, 77.5);

		this.CircleAndDay30 = new lib.CircleAndDay();
		this.CircleAndDay30.name = "CircleAndDay30";
		this.CircleAndDay30.parent = this;
		this.CircleAndDay30.setTransform(702.45, 1393.7, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay30.Day.text = "2";



		this.CircleAndDay28 = new lib.CircleAndDay();
		this.CircleAndDay28.name = "CircleAndDay28";
		this.CircleAndDay28.parent = this;
		this.CircleAndDay28.setTransform(400.9, 1363.6, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay28.Day.text = "31";

		this.CircleAndDay29 = new lib.CircleAndDay();
		this.CircleAndDay29.name = "CircleAndDay31";
		this.CircleAndDay29.parent = this;
		this.CircleAndDay29.setTransform(560.85, 1379.2, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay29.Day.text = "1";

		this.CircleAndDay27 = new lib.CircleAndDay();
		this.CircleAndDay27.name = "CircleAndDay27";
		this.CircleAndDay27.parent = this;
		this.CircleAndDay27.setTransform(681.95, 1236.7, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay27.Day.text = "30";

		this.CircleAndDay26 = new lib.CircleAndDay();
		this.CircleAndDay26.name = "CircleAndDay26";
		this.CircleAndDay26.parent = this;
		this.CircleAndDay26.setTransform(512.95, 1236.7, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay26.Day.text = "29";

		this.CircleAndDay25 = new lib.CircleAndDay();
		this.CircleAndDay25.name = "CircleAndDay25";
		this.CircleAndDay25.parent = this;
		this.CircleAndDay25.setTransform(334.4, 1214.7, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay25.Day.text = "28";

		this.CircleAndDay24 = new lib.CircleAndDay();
		this.CircleAndDay24.name = "CircleAndDay24";
		this.CircleAndDay24.parent = this;
		this.CircleAndDay24.setTransform(752.3, 1085.7, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay24.Day.text = "27";

		this.CircleAndDay23 = new lib.CircleAndDay();
		this.CircleAndDay23.name = "CircleAndDay23";
		this.CircleAndDay23.parent = this;
		this.CircleAndDay23.setTransform(609, 1102.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay23.Day.text = "26";
		this.CircleAndDay22 = new lib.CircleAndDay();
		this.CircleAndDay22.name = "CircleAndDay22";
		this.CircleAndDay22.parent = this;
		this.CircleAndDay22.setTransform(440, 1102.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay22.Day.text = "25";

		this.CircleAndDay21 = new lib.CircleAndDay();
		this.CircleAndDay21.name = "CircleAndDay21";
		this.CircleAndDay21.parent = this;
		this.CircleAndDay21.setTransform(271, 1076.6, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay21.Day.text = "24";

		this.CircleAndDay20 = new lib.CircleAndDay();
		this.CircleAndDay20.name = "CircleAndDay20";
		this.CircleAndDay20.parent = this;
		this.CircleAndDay20.setTransform(800.7, 933.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay20.Day.text = "23";

		this.CircleAndDay19 = new lib.CircleAndDay();
		this.CircleAndDay19.name = "CircleAndDay19";
		this.CircleAndDay19.parent = this;
		this.CircleAndDay19.setTransform(648.3, 956.85, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay19.Day.text = "22";

		this.CircleAndDay18 = new lib.CircleAndDay();
		this.CircleAndDay18.name = "CircleAndDay18";
		this.CircleAndDay18.parent = this;
		this.CircleAndDay18.setTransform(503.4, 967.9, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay18.Day.text = "21";


		this.CircleAndDay17 = new lib.CircleAndDay();
		this.CircleAndDay17.name = "CircleAndDay17";
		this.CircleAndDay17.parent = this;
		this.CircleAndDay17.setTransform(343.95, 933.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay17.Day.text = "20";


		this.CircleAndDay16 = new lib.CircleAndDay();
		this.CircleAndDay16.name = "CircleAndDay16";
		this.CircleAndDay16.parent = this;
		this.CircleAndDay16.setTransform(188.9, 933.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay16.Day.text = "19";

		this.CircleAndDay15 = new lib.CircleAndDay();
		this.CircleAndDay15.name = "CircleAndDay15";
		this.CircleAndDay15.parent = this;
		this.CircleAndDay15.setTransform(812.7, 787.85, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay15.Day.text = "18";

		this.CircleAndDay14 = new lib.CircleAndDay();
		this.CircleAndDay14.name = "CircleAndDay14";
		this.CircleAndDay14.parent = this;
		this.CircleAndDay14.setTransform(650.5, 810.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay14.Day.text = "17";

		this.CircleAndDay13 = new lib.CircleAndDay();
		this.CircleAndDay13.name = "CircleAndDay13";
		this.CircleAndDay13.parent = this;
		this.CircleAndDay13.setTransform(497.45, 810.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay13.Day.text = "16";

		this.CircleAndDay12 = new lib.CircleAndDay();
		this.CircleAndDay12.name = "CircleAndDay12";
		this.CircleAndDay12.parent = this;
		this.CircleAndDay12.setTransform(338.45, 787.85, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay12.Day.text = "15";



		this.CircleAndDay11 = new lib.CircleAndDay();
		this.CircleAndDay11.name = "CircleAndDay11";
		this.CircleAndDay11.parent = this;
		this.CircleAndDay11.setTransform(178.95, 778.9, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay11.Day.text = "14";

		this.CircleAndDay10 = new lib.CircleAndDay();
		this.CircleAndDay10.name = "CircleAndDay10";
		this.CircleAndDay10.parent = this;
		this.CircleAndDay10.setTransform(729.85, 663.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay10.Day.text = "13";

		this.CircleAndDay9 = new lib.CircleAndDay();
		this.CircleAndDay9.name = "CircleAndDay9";
		this.CircleAndDay9.parent = this;
		this.CircleAndDay9.setTransform(572.85, 680.9, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay9.Day.text = "12";

		this.CircleAndDay8 = new lib.CircleAndDay();
		this.CircleAndDay8.name = "CircleAndDay8";
		this.CircleAndDay8.parent = this;
		this.CircleAndDay8.setTransform(400.9, 663.8, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay8.Day.text = "11";

		this.CircleAndDay7 = new lib.CircleAndDay();
		this.CircleAndDay7.name = "CircleAndDay7";
		this.CircleAndDay7.parent = this;
		this.CircleAndDay7.setTransform(238.95, 631.9, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay7.Day.text = "10";

		this.CircleAndDay6 = new lib.CircleAndDay();
		this.CircleAndDay6.name = "CircleAndDay6";
		this.CircleAndDay6.parent = this;
		this.CircleAndDay6.setTransform(695.9, 527.9, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay6.Day.text = "9";

		this.CircleAndDay5 = new lib.CircleAndDay();
		this.CircleAndDay5.name = "CircleAndDay5";
		this.CircleAndDay5.parent = this;
		this.CircleAndDay5.setTransform(526.9, 511.9, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay5.Day.text = "8";

		this.CircleAndDay4 = new lib.CircleAndDay();
		this.CircleAndDay4.name = "CircleAndDay4";
		this.CircleAndDay4.parent = this;
		this.CircleAndDay4.setTransform(357.9, 509.9, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay4.Day.text = "7";

		this.CircleAndDay3 = new lib.CircleAndDay();
		this.CircleAndDay3.name = "CircleAndDay3";
		this.CircleAndDay3.parent = this;
		//this.CircleAndDay3.setTransform(457.35, 372.4, 1, 1, 0, 0, 0, 78.5, 77.5);
		this.CircleAndDay3.setTransform(626.35, 372.4, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay3.Day.text = "5";

		this.CircleAndDay2 = new lib.CircleAndDay();
		this.CircleAndDay2.name = "CircleAndDay2";
		this.CircleAndDay2.parent = this;
		//this.CircleAndDay2.setTransform(626.35, 372.4, 1, 1, 0, 0, 0, 78.5, 77.5);
		this.CircleAndDay2.setTransform(457.35, 372.4, 1, 1, 0, 0, 0, 78.5, 77.5);
		//this.CircleAndDay2.Day.text = "6";

		this.CircleAndDay1 = new lib.CircleAndDay();
		this.CircleAndDay1.name = "CircleAndDay1";
		this.CircleAndDay1.parent = this;
		this.CircleAndDay1.setTransform(532.45, 246.4, 1, 1, 0, 0, 0, 77.5, 77.5);

		// var objCircleColor = new lib.ColorTransform();
		//var objCircleColor:ColorTransform = new ColorTransform();
		// objCircleColor.Color = 0xFF0000;
		this.CircleAndDay1.setTransform(532.45, 246.4, 1, 1, 0, 0, 0, 77.5, 77.5);
		this.CircleAndDay1.Day.text = "4";
		// this.CircleAndDay1.Day.color = "#ff0000";
		// this.CircleAndDay25.Day.color = "#ff0000";
		// this.CircleAndDay8.Day.color = "#FFFF00";
		// this.CircleAndDay28.Day.color = "#FFFF00";
		// this.CircleAndDay22.Day.color = "#993399";

		this.timeline.addTween(cjs.Tween.get({}).to({ state: [{ t: this.CircleAndDay3 }, { t: this.CircleAndDay1 }, { t: this.CircleAndDay2 }, { t: this.CircleAndDay4 }, { t: this.CircleAndDay5 }, { t: this.CircleAndDay6 }, { t: this.CircleAndDay7 }, { t: this.CircleAndDay8 }, { t: this.CircleAndDay9 }, { t: this.CircleAndDay10 }, { t: this.CircleAndDay11 }, { t: this.CircleAndDay13 }, { t: this.CircleAndDay12 }, { t: this.CircleAndDay14 }, { t: this.CircleAndDay15 }, { t: this.CircleAndDay18 }, { t: this.CircleAndDay17 }, { t: this.CircleAndDay16 }, { t: this.CircleAndDay20 }, { t: this.CircleAndDay19 }, { t: this.CircleAndDay24 }, { t: this.CircleAndDay21 }, { t: this.CircleAndDay23 }, { t: this.CircleAndDay22 }, { t: this.CircleAndDay25 }, { t: this.CircleAndDay30 }, { t: this.CircleAndDay27 }, { t: this.CircleAndDay29 }, { t: this.CircleAndDay28 }, { t: this.CircleAndDay26 }, { t: this.CircleAndDay31 }] }).wait(3));

		// Bitmap_1
		this.LeafRight = new lib.LeafR();
		this.LeafRight.name = "LeafRight"; 1
		this.LeafRight.parent = this;
		this.LeafRight.setTransform(670.4, 170, 1, 1, 0, 0, 0, 140, 166);

		this.timeline.addTween(cjs.Tween.get(this.LeafRight).wait(3));

		// Bitmap_2
		this.LeafLeft = new lib.LeafL();
		this.LeafLeft.name = "LeafLeft";
		this.LeafLeft.parent = this;
		this.LeafLeft.setTransform(374.85, 183.9, 1, 1, 0, 0, 0, 200, 182);

		this.timeline.addTween(cjs.Tween.get(this.LeafLeft).wait(3));

	}).prototype = p = new cjs.MovieClip();
	p.nominalBounds = new cjs.Rectangle(592.9, 826.9, 305.80000000000007, 791.6999999999999);
	// library properties:
	lib.properties = {
		id: '8BDBB6501509744B8312E81AEBEF7A95',
		width: 1000,
		height: 1650,
		fps: 24,
		color: "#FFFFFF",
		opacity: 1.00,
		manifest: [
			{ src: "images/GrapeChartHTML_HTML5_Canvas_atlas_.png?1627809471360", id: "GrapeChartHTML_HTML5_Canvas_atlas_" }
		],
		preloads: []
	};



	// bootstrap callback support:

	(lib.Stage = function (canvas) {
		createjs.Stage.call(this, canvas);
	}).prototype = p = new createjs.Stage();

	p.setAutoPlay = function (autoPlay) {
		this.tickEnabled = autoPlay;
	}
	p.play = function () { this.tickEnabled = true; this.getChildAt(0).gotoAndPlay(this.getTimelinePosition()) }
	p.stop = function (ms) { if (ms) this.seek(ms); this.tickEnabled = false; }
	p.seek = function (ms) { this.tickEnabled = true; this.getChildAt(0).gotoAndStop(lib.properties.fps * ms / 1000); }
	p.getDuration = function () { return this.getChildAt(0).totalFrames / lib.properties.fps * 1000; }

	p.getTimelinePosition = function () { return this.getChildAt(0).currentFrame / lib.properties.fps * 1000; }

	an.bootcompsLoaded = an.bootcompsLoaded || [];
	if (!an.bootstrapListeners) {
		an.bootstrapListeners = [];
	}

	an.bootstrapCallback = function (fnCallback) {
		an.bootstrapListeners.push(fnCallback);
		if (an.bootcompsLoaded.length > 0) {
			for (var i = 0; i < an.bootcompsLoaded.length; ++i) {
				fnCallback(an.bootcompsLoaded[i]);
			}
		}
	};

	an.compositions = an.compositions || {};
	an.compositions['8BDBB6501509744B8312E81AEBEF7A95'] = {
		getStage: function () { return exportRoot.getStage(); },
		getLibrary: function () { return lib; },
		getSpriteSheet: function () { return ss; },
		getImages: function () { return img; }
	};

	an.compositionLoaded = function (id) {
		an.bootcompsLoaded.push(id);
		for (var j = 0; j < an.bootstrapListeners.length; j++) {
			an.bootstrapListeners[j](id);
		}
	}

	an.getComposition = function (id) {
		return an.compositions[id];
	}



})(createjs = createjs || {}, AdobeAn = AdobeAn || {});
var createjs, AdobeAn;