<%@ page language="java" contentType="text/html; charset=EUC-KR"
pageEncoding="EUC-KR"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="config.DB"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="account.AccountDTO" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%!
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String userid, passwd, name, phonenum, email, photo;
	int birth;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/session_check.jsp"/>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/psManager/Resources/css/chatbox.css">
<script src="../Resources/js/bootstrap.js"></script>
<style type="text/css">
textarea {
	resize: none;
}
</style>
</head>
<body>
<jsp:include page="/include/nav_login.jsp" />
<%	
	userid=(String)session.getAttribute("userid");		//DB���� ���� �ϴ��Ŷ� �ٸ� �ٵ� �Ǳ�� 
	String sql = "select photo from account where userid= ? ";
	conn=DB.dbConn();
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, userid);
	rs=pstmt.executeQuery();
	
	
	while(rs.next()) {
		photo=rs.getString("photo");
		System.out.println(photo);
	}

%>
</body>
		
<form method="post" enctype="multipart/form-data" action="upload.jsp">  <!-- ���ε� -->
	<%if(photo!=null){
		%>
		���� �����ʻ��� : <input type="text" name="photo" size="20" value=<%=photo%> readonly="readonly"/><br>
		<img src="${pageContext.request.contextPath}/img/<%=photo%>"/>
		<%
	} 
	else{%>
		���� �����ʻ��� : <input type="text" name="photo" size="20" value="������ ������ ����ϼ���" readonly="readonly"/><br>
		<img src="${pageContext.request.contextPath}/img/default.png"  width="300" height="200">
		<%}%> 
	<!-- <input type="file" name="filename1" /><br><br> -->
				
<br>	

<br>�� ������ ����: <br><br><br>

<div id="preview"></div>




<input type="file" name="filename1" class="inp-img" accept=".gif, .jpg, .png"> <button class="btn-delete">����</button>

<script src="lib/jquery/2.2.3/jquery.min.js"></script>
<script type="text/javascript">

// ��� �̹��� ��� �̸�����
function readInputFile(input) {
    if(input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#preview').html("<img src="+ e.target.result +">");
        }
        reader.readAsDataURL(input.files[0]);
    }
}
 
$(".inp-img").on('change', function(){
    readInputFile(this);
});
//��� �̹��� ���� ( input file reset )
function resetInputFile($input, $preview) {
    var agent = navigator.userAgent.toLowerCase();
    if((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
        // ie �϶�
        $input.replaceWith($input.clone(true));
        $preview.empty();
    } else {
        //other
        $input.val("");
        $preview.empty();
    }       
}
 
$(".btn-delete").click(function(event) {
    var $input = $(".inp-img");
    var $preview = $('#preview');
    resetInputFile($input, $preview);
});


</script>
	<br><input type="submit" value="���ε�"><br><br>
	<button type="button" onclick="location.href='/psManager/account/account_view.jsp' ">���</button>
	<!-- �̹��� ���ϸ� ��ϵǰ� accept Ȯ���� ���� -->

</form>
</html>

