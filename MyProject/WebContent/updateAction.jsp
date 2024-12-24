<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="writing.Writing"%>
<%@ page import="writing.WritingDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content=Type" content="text/html; charset=UTF-8">
<title>일상공유블로그</title>
<body>
	<%	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		int writingID = 0;
		
		if(request.getParameter("writingID") != null) {
			writingID = Integer.parseInt(request.getParameter("writingID"));
		}
		
		if(writingID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		
		Writing writing = new WritingDAO().getWriting(writingID);
		if(!userID.equals(writing.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		} else {
			if(request.getParameter("writingTitle") == null || request.getParameter("writingContent") == null
					|| request.getParameter("writingTitle").equals(" ") || request.getParameter("writingTitle").equals(" ")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				WritingDAO writingDAO = new WritingDAO();
				int result = writingDAO.update(writingID, request.getParameter("writingTitle"), request.getParameter("writingContent"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>"); 
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</head>

