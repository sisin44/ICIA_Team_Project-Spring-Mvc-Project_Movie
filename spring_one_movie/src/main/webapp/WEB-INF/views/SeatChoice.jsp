<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.movie{
		width: 150px;
		height: 30px;
		margin: 5px 5px 5px 5px;
		background-size: contain;
	}
	.row{
		display: flex;
	}
	.able{
		width: 4%;
		height: 30px;
		float: left;
		background-color: #4374D9;
		border: 1px solid #FFFFFF;
		cursor: pointer;
	}
	.hall{
		width: 4%;
		height: 30px;
		float: left;
		background-color: #FFFFFF;
		border: 1px solid #FFFFFF;
		cursor: default;
	}
	.repair{
		width: 4%;
		height: 30px;
		float: left;
		background-color: #BDBDBD;
		border: 1px solid #FFFFFF;
		cursor: default;
	}
	.reserve{
		width: 4%;
		height: 30px;
		float: left;
		background-color: #FFBB00;
		border: 1px solid #FFFFFF;
		cursor: default;
	}
	.non{
	width: 4%;
		height: 30px;
		float: left;
		background-color: SKYBLUE;
		border: 1px solid #FFFFFF;
		cursor: default;
	}
</style>
<meta charset="UTF-8">
<title>좌석선택</title>
</head>
<body onLoad="init()">
<section id="seatZone"></section>
</body>

<script type="text/javascript">
	function init() {
		let sZone = document.getElementById ("seatZone");
		let seatInfo = JSON.parse('${getSeat}');
		let rows;
		let cols;
		let count1 = 65;
		let count2 = 1;
		
		for(rowIndex=0; rowIndex<20; rowIndex++){
			rows = document.createElement("div");
			rows.className = "row";
			for(colIndex=0; colIndex<20; colIndex++){
				cols = document.createElement("div");
				cols.setAttribute("name", "seat");
				cols.className = "able";
				
				rows.appendChild(cols);
			}
			sZone.appendChild(rows);
		}
		
		/* 인액티브 좌석 배치*/
		let seat = document.getElementsByName("seat");
		for(index = 0; index < seatInfo.length; index++){
			seat[seatInfo[index].seatNum-1].className = (seatInfo[index].seatType == "H")? "hall" : ((seatInfo[index].seatType == "R")? "reserve" : "repair");

		}
		
		for(index = 0; index < seat.length; index++){
			if(seat[index].className == "able" || seat[index].className=="reserve"){
				seat[index].textContent = String.fromCharCode(count1) + count2;
				count2++;
				if(count2>10){
					count2 = 1;
					count1++;
				}
			}
			let sc = seat[index].textContent;
			if(seat[index].className == "able"){
				seat[index].setAttribute("onClick", "selectSeat("+(index+1)+")");
			}
			
			//(index+1)
		}
		
		
	}
	
	function selectSeat(sNum) {
		alert(sNum);
	}
</script>
</html>