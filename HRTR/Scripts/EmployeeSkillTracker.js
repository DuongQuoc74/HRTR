// JScript File
jQuery.noConflict();
jQuery(document).ready(function () {
});
function RefreshGrapeChart(month, year) {
	var canvas2, anim_container2, dom_overlay_container2, strurl;

	const days = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1", "2", "3", "4", "5", "6", "7", "8", "-1", "-1", "-1"];
	const colors = ["#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000"];

	var employeeid_id = jQuery('[id$="hdEmployeeID_ID"]').val();
	var stremployeeid = jQuery('[id$="txtEmployeeID"]').val();
	var stremployeename = jQuery('[id$="txtEmployeeName"]').val();

	canvas2 = "canvas";
	anim_container2 = "animation_container";
	dom_overlay_container2 = "dom_overlay_container";
	strurl = "../AjaxServer/ASGrapeChart.aspx?type=11&employeeid_id=" + employeeid_id + "&year=" + year + "&month=" + month + "";

	jQuery.ajax({
		type: "POST",
		url: strurl,
		contentType: "text/xml; charset=utf-8",
		dataType: "xml",
		async: false,
		success: function (response) {
			var i = 0;
			jQuery(response).find('GrapeChartChart').each(function () {
				var iStatus = jQuery(this).find('DayStatus').text();
				var strDay = jQuery(this).find('Day').text();
				days[i] = strDay;
				switch (iStatus) {
					case "1":
						colors[i] = "#66CC00";
						break;
					case "2":
						colors[i] = "#FFFF00";
						break;
					case "3":
						colors[i] = "#FF0000";
						break;
					case "4":
						colors[i] = "#7F7F5B";
						break;
					case "5":
						colors[i] = "#6E0A83";
						break;
				}
				i++;
			});
			init(canvas2, anim_container2, dom_overlay_container2, days, colors);
			var MyGrapeChartByMonth = jQuery(response).find('EmployeeSkillTrackerByMonth').text();
			jQuery('#divEmployeeSkillTrackerByMonth').html(MyGrapeChartByMonth);
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {

		}
	});

	jQuery('[id$="lblGrapeChart"]').html("Grape Chart");
	jQuery('[id$="lblEmployeeName"]').html(stremployeeid + " - " + stremployeename);
	jQuery('[id$="lblMonthYear"]').html(month + " - " + year);
	return false;
}

function cvEmployeeID_ClientValidate(source, args) {
	var employeeid_id = jQuery('[id$="hdEmployeeID_ID"]').val();
	if (employeeid_id == "" || employeeid_id == "0") {
		args.IsValid = false;
	}
	else {
		args.IsValid = true;
	}
}


function EmployeeSelected(source, eventArgs) {

	if (source._serviceMethod == "GetEmployeeList") {
		var avalue = eventArgs.get_value();
		GetEmployeeProfile(avalue);
	}
}

function GetEmployeeProfile(employeeid) {

	if (employeeid != '') {
		var strurl = "../AjaxServer/ASEmployee.aspx?type=2&employeeid=" + employeeid;
		jQuery.ajax({
			type: "POST",
			url: strurl,
			contentType: "text/xml; charset=utf-8",
			dataType: "xml",
			async: false,
			success: function (response) {

				jQuery(response).find('Employee').each(function () {
					var strtemp = jQuery(this).find('EmployeeName').text();

					jQuery('[id$="txtEmployeeName"]').val(strtemp);

					strtemp = jQuery(this).find('EmployeeID_ID').text();
					jQuery('[id$="hdEmployeeID_ID"]').val(strtemp);
				});
			},
			error: function (XMLHttpRequest, textStatus, errorThrown) {

			}
		});
	}
}

var stage, exportRoot, fnStartAnimation;


function init(canvasId, anim_containerId, dom_overlay_containerId, days, colors) {
	var canvas, anim_container, dom_overlay_container;
	canvas = document.getElementById(canvasId);
	anim_container = document.getElementById(anim_containerId);
	dom_overlay_container = document.getElementById(dom_overlay_containerId);
	var comp = AdobeAn.getComposition("8BDBB6501509744B8312E81AEBEF7A95");
	var lib = comp.getLibrary();
	var loader = new createjs.LoadQueue(false);
	loader.addEventListener("fileload", function (evt) { handleFileLoad(evt, comp) });
	loader.addEventListener("complete", function (evt) { handleComplete(evt, comp, canvas, anim_container, dom_overlay_container, days, colors) });

	loader.loadManifest(lib.properties.manifest);
}
function handleFileLoad(evt, comp) {
	var images = comp.getImages();
	if (evt && (evt.item.type == "image")) { images[evt.item.id] = evt.result; }
}
function handleComplete(evt, comp, canvas, anim_container, dom_overlay_container, days, colors) {
	//This function is always called, irrespective of the content. You can use the variable "stage" after it is created in token create_stage.
	var lib = comp.getLibrary();
	var ss = comp.getSpriteSheet();
	var queue = evt.target;
	var ssMetadata = lib.ssMetadata;
	for (i = 0; i < ssMetadata.length; i++) {
		ss[ssMetadata[i].name] = new createjs.SpriteSheet({ "images": [queue.getResult(ssMetadata[i].name)], "frames": ssMetadata[i].frames })
	}
	exportRoot = new lib.GrapeChartHTML_HTML5_Canvas();
	stage = new lib.Stage(canvas);
	//Registers the "tick" event listener.
	fnStartAnimation = function () {
		stage.addChild(exportRoot);
		createjs.Ticker.setFPS(lib.properties.fps);
		createjs.Ticker.addEventListener("tick", stage);
	}
	//Code to support hidpi screens and responsive scaling.
	function makeResponsive(isResp, respDim, isScale, scaleType) {
		var lastW, lastH, lastS = 1;
		window.addEventListener('resize', resizeCanvas);
		resizeCanvas();
		function resizeCanvas() {
			var w = lib.properties.width, h = lib.properties.height;
			var iw = 300, ih = 400;
			var pRatio = window.devicePixelRatio || 1, xRatio = iw / w, yRatio = ih / h, sRatio = 1;
			if (isResp) {
				if ((respDim == 'width' && lastW == iw) || (respDim == 'height' && lastH == ih)) {
					sRatio = lastS;
				}
				else if (!isScale) {
					if (iw < w || ih < h)
						sRatio = Math.min(xRatio, yRatio);
				}
				else if (scaleType == 1) {
					sRatio = Math.min(xRatio, yRatio);
				}
				else if (scaleType == 2) {
					sRatio = Math.max(xRatio, yRatio);
				}
			}
			canvas.width = w * pRatio * sRatio;
			canvas.height = h * pRatio * sRatio;
			canvas.style.width = '300px';
			canvas.style.height = '460px';
			stage.scaleX = pRatio * sRatio;
			stage.scaleY = pRatio * sRatio;
			lastW = iw; lastH = ih; lastS = sRatio;
			stage.tickOnUpdate = false;
			stage.update();
			stage.tickOnUpdate = true;
		}
	}
	makeResponsive(false, 'both', false, 1);
	AdobeAn.compositionLoaded(lib.properties.id);
	fnStartAnimation();
	var GrapeChart = stage.getChildAt(0);

	GrapeChart.CircleAndDay1.Day.text = days[0];
	GrapeChart.CircleAndDay2.Day.text = days[1];
	GrapeChart.CircleAndDay3.Day.text = days[2];
	GrapeChart.CircleAndDay4.Day.text = days[3];
	GrapeChart.CircleAndDay5.Day.text = days[4];
	GrapeChart.CircleAndDay6.Day.text = days[5];
	GrapeChart.CircleAndDay7.Day.text = days[6];
	GrapeChart.CircleAndDay8.Day.text = days[7];
	GrapeChart.CircleAndDay9.Day.text = days[8];
	GrapeChart.CircleAndDay10.Day.text = days[9];
	GrapeChart.CircleAndDay11.Day.text = days[10];
	GrapeChart.CircleAndDay12.Day.text = days[11];
	GrapeChart.CircleAndDay13.Day.text = days[12];
	GrapeChart.CircleAndDay14.Day.text = days[13];
	GrapeChart.CircleAndDay15.Day.text = days[14];
	GrapeChart.CircleAndDay16.Day.text = days[15];
	GrapeChart.CircleAndDay17.Day.text = days[16];
	GrapeChart.CircleAndDay18.Day.text = days[17];
	GrapeChart.CircleAndDay19.Day.text = days[18];
	GrapeChart.CircleAndDay20.Day.text = days[19];
	GrapeChart.CircleAndDay21.Day.text = days[20];
	GrapeChart.CircleAndDay22.Day.text = days[21];
	GrapeChart.CircleAndDay23.Day.text = days[22];
	GrapeChart.CircleAndDay24.Day.text = days[23];
	GrapeChart.CircleAndDay25.Day.text = days[24];
	GrapeChart.CircleAndDay26.Day.text = days[25];
	GrapeChart.CircleAndDay27.Day.text = days[26];
	GrapeChart.CircleAndDay28.Day.text = days[27];
	GrapeChart.CircleAndDay29.Day.text = days[28];
	GrapeChart.CircleAndDay30.Day.text = days[29];
	GrapeChart.CircleAndDay31.Day.text = days[30];

	GrapeChart.CircleAndDay1.Day.color = colors[0];
	GrapeChart.CircleAndDay2.Day.color = colors[1];
	GrapeChart.CircleAndDay3.Day.color = colors[2];
	GrapeChart.CircleAndDay4.Day.color = colors[3];
	GrapeChart.CircleAndDay5.Day.color = colors[4];
	GrapeChart.CircleAndDay6.Day.color = colors[5];
	GrapeChart.CircleAndDay7.Day.color = colors[6];
	GrapeChart.CircleAndDay8.Day.color = colors[7];
	GrapeChart.CircleAndDay9.Day.color = colors[8];
	GrapeChart.CircleAndDay10.Day.color = colors[9];
	GrapeChart.CircleAndDay11.Day.color = colors[10];
	GrapeChart.CircleAndDay12.Day.color = colors[11];
	GrapeChart.CircleAndDay13.Day.color = colors[12];
	GrapeChart.CircleAndDay14.Day.color = colors[13];
	GrapeChart.CircleAndDay15.Day.color = colors[14];
	GrapeChart.CircleAndDay16.Day.color = colors[15];
	GrapeChart.CircleAndDay17.Day.color = colors[16];
	GrapeChart.CircleAndDay18.Day.color = colors[17];
	GrapeChart.CircleAndDay19.Day.color = colors[18];
	GrapeChart.CircleAndDay20.Day.color = colors[19];
	GrapeChart.CircleAndDay21.Day.color = colors[20];
	GrapeChart.CircleAndDay22.Day.color = colors[21];
	GrapeChart.CircleAndDay23.Day.color = colors[22];
	GrapeChart.CircleAndDay24.Day.color = colors[23];
	GrapeChart.CircleAndDay25.Day.color = colors[24];
	GrapeChart.CircleAndDay26.Day.color = colors[25];
	GrapeChart.CircleAndDay27.Day.color = colors[26];
	GrapeChart.CircleAndDay28.Day.color = colors[27];
	GrapeChart.CircleAndDay29.Day.color = colors[28];
	GrapeChart.CircleAndDay30.Day.color = colors[29];
	GrapeChart.CircleAndDay31.Day.color = colors[30];
	if (days[28] == "-1")
		GrapeChart.CircleAndDay29.visible = false;
	if (days[29] == "-1")
		GrapeChart.CircleAndDay30.visible = false;
	if (days[30] == "-1")
		GrapeChart.CircleAndDay31.visible = false;
}