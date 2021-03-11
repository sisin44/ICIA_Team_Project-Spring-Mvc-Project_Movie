<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날짜선택</title>
</head>
<body>
	<div>
	<div><img src="resources/image/${SelectedMovie.getMvImage() }" /></div>
	<div>${SelectedMovie.getMvName() } / ${SelectedMovie.getMvGrade() }</div>
	<!--  ${SelectedMovie.getMvComments() } -->
	</div>
	
	${Access }
	<br>
	<button id=date0 onClick="date(0)"></button><br>
	<button id=date1 onClick="date(1)"></button><br>
	<button id=date2 onClick="date(2)"></button><br>
	<button id=date3 onClick="date(3)"></button><br>
	<button id=date4 onClick="date(4)"></button><br>
	<button id=date5 onClick="date(5)"></button><br>
	<button id=date6 onClick="date(6)"></button><br>
</body>
<script>
let dayStr = "${Access}";
let day = (dayStr.split(" "))[0].split("-");
let now = new Date();

now.setFullYear(parseInt(day[0]), parseInt(day[1])-1, parseInt(day[2]));

now.setDate(now.getDate());
document.getElementById('date0').innerHTML=now.toLocaleDateString('ko-KR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    weekday: 'long',
});
document.getElementById('date0').value=now.toLocaleDateString('zh-Hans-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
});
for(var i=1; i<7; i++){
	now.setDate(now.getDate()+1);
	document.getElementById('date'+1).innerHTML=now.toLocaleDateString('ko-KR', {
	    year: 'numeric',
	    month: 'long',
	    day: 'numeric',
	    weekday: 'long',
	});
	document.getElementById('date'+1).value=now.toLocaleDateString('zh-Hans-CN', {
	    year: 'numeric',
	    month: '2-digit',
	    day: '2-digit',
	});
}



function date(d) {
	var day = document.getElementById('date'+d).value;
	
	var form = document.createElement("form");
    form.action="toTime?mvDate="+day;
    form.method="post";
    
    var mvCode =document.createElement("input");
    mvCode.type = "hidden";
    mvCode.name = "mvCode";
    mvCode.value = ${SelectedMovie.getMvCode()};
    form.appendChild(mvCode);
   
   
	var sCode = document.createElement("input");
	sCode.type = "hidden";
	sCode.name = "sCode";
	sCode.value = "toTime";
	form.appendChild(sCode);
   
    document.body.appendChild(form);
    form.submit();
}

	//document.writeln(date.toLocaleDateString());
	

</script>

</html>