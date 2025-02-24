
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="writing.Writing"%>
<%@ page import="writing.WritingDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content=Type" content="text/html; charset=UTF-8">
<meta name="viewlort" content="width=device=width" inital-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>일상공유블로그</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int writingID = 0;

	if (request.getParameter("writingID") != null) {
		writingID = Integer.parseInt(request.getParameter("writingID"));
	}

	if (writingID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'board.jsp'");
		script.println("</script>");
	}

	Writing writing = new WritingDAO().getWriting(writingID);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">일상공유블로그</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<%
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"> 접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"> 회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="border: 1px solid #dddddd">
            <thead>
                <tr>
                    <th colspan="3" style="background-color: #eeeeee; text-align: center;">글쓰기 상세페이지</th>
                </tr>
            </thead>
            <tbody>
                <tr> 
                    <td style="width:20%; text-align: left;">글 제목</td>
                    <td colspan="2" style="text-align: left;"><%= writing.getWritingTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                </tr>
                <tr> 
                    <td style="text-align: left;">작성자</td>
                    <td colspan="2" style="text-align: left;"><%= writing.getUserID() %></td>
                </tr>
                <tr> 
                    <td style="text-align: left;">작성일자</td>
                    <td colspan="2" style="text-align: left;"><%= writing.getWritingDate().substring(0, 11) %></td>
                </tr>
                <tr> 
                    <td style="text-align: left;">내용</td>
                    <td colspan="2" style="min-height:200px; text-align: left;">
                        <%= writing.getWritingContent().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
                    </td>
                </tr>
            </tbody>
        </table>
        <div style="text-align: right;">
            <a href="board.jsp" class="btn btn-primary" style="float: left;">목록</a>
            <%
                if(userID != null && userID.equals(writing.getUserID())){
            %>
                <a href="update.jsp?writingID=<%= writingID %>" class="btn btn-primary">수정</a>        
                <a onclick="return confirm('정말로 이 글을 삭제하시겠습니까?')" href="deleteAction.jsp?writingID=<%= writingID %>" class="btn btn-danger">삭제</a>
            <%
                }
            %>
        </div>
    </div>
</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>