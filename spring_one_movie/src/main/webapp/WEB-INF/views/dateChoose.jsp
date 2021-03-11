<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE HTML>
<html>
<head>
<style>
button {
  display: block;
}
</style>
<title>Home</title>
<!-- <link href="/resources/css/kotlin.css" rel="stylesheet" /> -->
</head>
<body onLoad="init()">
	<a href="http://14.37.14.12/LogInForm">로그인폼 이동</a>
	<br />
	<P>Now Time : ${Access}</P>
	<section id="movieZone" style="display: flex;">
		<div id="movieInfo"></div>
		<div id="selectionDate">selectionDate<br></div>
		<div id="selectionTime">selectionTime</div>
	</section>
</body>
<script>
	function init() {
		let datList = document.getElementById("selectionDate");
		//${Timeselection}
		/* Convert Date */
		let dayStr = "${Access}";
		let day = dayStr.split("-");
		let now = new Date();
		now.setFullYear(parseInt(day[0]), parseInt(day[1]) - 1,
				parseInt(day[2]));

		for (i = 0; i < 7; i++) {
			now.setDate(now.getDate() + ((i == 0) ? 0 : 1));
			let datebutton = document.createElement('button');
			datebutton.id = "date" + i;
			
			datebutton.addEventListener('click', function() {divClick(movie[0].mvCode, this.value);});
			datList.appendChild(datebutton);

			document.getElementById('date' + i).textContent = now
					.toLocaleDateString('ko-KR', {
						year : 'numeric',
						month : 'long',
						day : 'numeric',
						weekday : 'long',
					});
			document.getElementById('date' + i).value = now.toLocaleDateString(
					'zh-Hans-CN', {
						year : 'numeric',
						month : '2-digit',
						day : '2-digit',
					});
		}
		
		let movieInfo = document.getElementById("movieInfo");
		/* Append movieInfo Div */
		let movie = JSON.parse('${SelectedMovie}');

		let mvImage = document.createElement('Div');
		mvImage.style.width = "400px";
		mvImage.style.height = "400px";
		mvImage.style.margin = "0px 10px 20px 0px";
		mvImage.style.backgroundImage = "url(/resources/image/"
				+ movie[0].mvImage + ")";
		mvImage.style.backgroundSize = "contain";
		movieInfo.appendChild(mvImage);

		let mvTitle = document.createElement('Div');
		mvTitle.textContent = movie[0].mvName;
		mvImage.className = "movie";
		movieInfo.appendChild(mvTitle);
		/*
		let mvGrade = document.createElement('Div');              
		mvGrade.textContent = movie[0].mvGrade;
		mvGrade.className = "movie";
		movieInfo.appendChild(mvGrade);
		 */
		let mvGrade = document.createElement('Div');
		if (movie[0].mvGrade = 'K') {
			mvGrade.textContent = "전체상영가";
		} else if (movie[0].mvGrade = 'Y') {
			mvGrade.textContent = "12세 이상 관람가";
		} else if (movie[0].mvGrade = 'M') {
			mvGrade.textContent = "15세 이상 관람가";
		} else {
			mvGrade.textContent = "19세 이상 관람가";
		}
		mvGrade.className = "movie";
		movieInfo.appendChild(mvGrade);

		let mvStatus = document.createElement('Div');
		if (movie[0].mvStatus = 'I') {
			mvStatus.textContent = "상영중";
		} else {
			mvStatus.textContent = "상영예정";
		}
		mvStatus.className = "movie";
		movieInfo.appendChild(mvStatus);
		/*
		let mvStatus = document.createElement('Div');              
		mvStatus.textContent = movie[0].mvStatus;
		mvStatus.className = "movie";
		movieInfo.appendChild(mvStatus);
		 */
		let mvComments = document.createElement('Div');
		mvComments.textContent = movie[0].mvComments;
		mvComments.className = "movie";
		movieInfo.appendChild(mvComments);
		
	}

	function divClick(mvCode, myDate) {
		//서버전송
		let request = new XMLHttpRequest();
		request.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200){
				let reqData = decodeURIComponent(request.response);
				
				timeChoice(reqData, myDate);
			}
		};
		request.open("POST", "toTime", true);
		request.setRequestHeader("content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		//request.responseType='json';
		request.send("sCode=toTime&mvCode=" + mvCode + "&mvDate=" + myDate);
		
		/*
		let form = document.createElement("form");
		form.action = "toTime?sCode=toTime&mvCode=" + mvCode + "&mvDate=" + myDate;
		form.method = "post"
		alert(d)
		document.body.appendChild(form);
		form.submit();
		*/
	}
	function timeChoice(reqData, myDate) {
		let timeData = JSON.parse(reqData);
		let timeList = document.getElementById("selectionTime");
		
		while(timeList.firstChild){
			timeList.removeChild(timeList.firstChild);
		}
		
		for(i=0; i<timeData.length; i++){
			
			let screen = document.createElement('Div');
			screen.id = 'screen' + timeData[i].siScreen;
			let Screen = timeData[i].siScreen;
			let time = timeData[i].mvDateTime;
			screen.textContent = timeData[i].siScreen + "관:  "+ time.substring(0,2) + "시" + time.substring(2,4) + "분";
			screen.style.cursor = "pointer";
			screen.addEventListener('click', function() {timeClick(timeData[0].mvCode, Screen, myDate ,time);});
			timeList.appendChild(screen);
		}
	}
	
	function timeClick(mvCode,Screen,myDate,myTime){
		let form = document.createElement("form");
		form.action = "toSeat?sCode=toSeat&mvCode=" + mvCode + "&siScreen=" + Screen + "&mvDate=" + myDate + "&mvDateTime=" + myTime;
		form.method = "post"
		document.body.appendChild(form);
		form.submit();
	}
	
</script>
</html>
