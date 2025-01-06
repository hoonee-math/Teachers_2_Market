package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/* 비밀번호 재설정 페이지로 이동하는 서블릿 */
@WebServlet(name="resetPassword", urlPatterns = "/member/resetpassword.do")
public class ToMemberResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToMemberResetPasswordServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        
        // 인증 상태 확인
        if (session == null || 
            session.getAttribute("passwordResetAuthorized") == null || 
            session.getAttribute("email") == null) {
            
            // 인증되지 않은 접근 시 로그인 페이지로 리다이렉트
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>");
            response.getWriter().write("alert('잘못된 접근입니다.');");
            response.getWriter().write("location.href='" + request.getContextPath() + "/member/login';");
            response.getWriter().write("</script>");
            return;
        }
        
        // 인증된 접근이면 비밀번호 재설정 페이지로 포워드
        request.getRequestDispatcher("/WEB-INF/views/enroll/resetPassword.jsp")
               .forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
