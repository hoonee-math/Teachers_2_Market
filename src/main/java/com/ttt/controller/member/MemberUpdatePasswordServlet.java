package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member2;
import com.ttt.service.MemberService;

@WebServlet(name="updatePassword", urlPatterns="/member/updatePassword.do")
public class MemberUpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberUpdatePasswordServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null 
            || session.getAttribute("passwordResetAuthorized") == null) {
            // 인증되지 않은 접근
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        String email = (String) session.getAttribute("email");
        String memberPw = request.getParameter("memberPw");
        
        Member2 m=Member2.builder()
        		.email(email)
        		.memberPw(memberPw)
        		.build();
        
        try {
            // 비밀번호 업데이트 서비스 호출
            new MemberService().updatePassword(m);
            
            // 세션 정리
            session.removeAttribute("email");
            session.removeAttribute("passwordResetAuthorized");
            
            // 성공 메시지와 함께 로그인 페이지로 리다이렉트
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>");
            response.getWriter().write("alert('비밀번호가 성공적으로 변경되었습니다. 새로운 비밀번호로 로그인해주세요.');");
            response.getWriter().write("location.href='" + request.getContextPath() + "/member/login';");
            response.getWriter().write("</script>");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>");
            response.getWriter().write("alert('비밀번호 변경 중 오류가 발생했습니다.');");
            response.getWriter().write("history.back();");
            response.getWriter().write("</script>");
        }
	}

}
