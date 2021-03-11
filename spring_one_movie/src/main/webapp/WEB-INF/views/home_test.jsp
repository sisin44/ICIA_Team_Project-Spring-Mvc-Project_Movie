<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Home</title>
</head>
<body>

<a href="http://14.37.14.12/LogInForm">로그인 이동</a>
<P>  Now Time: ${Access}.${week} </P>
${makeMovie}
</body>

<script>
function toDate(code){
    
	
    
// 	get 방식
// 	var mvCode = code;
//  	var form = document.createElement("form");
//  	form.action="toDate?mvCode=" + mvCode;
//  	form.method="post";
  
    var form = document.createElement("form");
    form.action="toDate";
    form.method="post";
    var mvCode =document.createElement("input");
    mvCode.type = "hidden";
    mvCode.name = "mvCode";
    mvCode.value = code;
    form.appendChild(mvCode);
   
   
	var sCode = document.createElement("input");
	sCode.type = "hidden";
	sCode.name = "sCode";
	sCode.value = "toDate";
	form.appendChild(sCode);
   
    document.body.appendChild(form);
    form.submit();
 }
</script>

</html>

