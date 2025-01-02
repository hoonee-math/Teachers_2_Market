package com.ttt.controller.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ClaudeFileDownloadServlet")
public class ClaudeFileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ClaudeFileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    //클로드가 짜 준 파일 접근 제어 방법 (이용할 때 참고하기!)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 세션에서 로그인 정보 확인
        Member2 loginMember = (Member2)request.getSession().getAttribute("loginMember");
        if(loginMember == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // 2. 파일 구매 여부 확인
        String fileNo = request.getParameter("fileNo");
        // DB에서 구매 이력 및 다운로드 가능 기간 확인
        
        // 3. 파일 다운로드 처리
        String fileName = "실제파일명.pdf";
        String filePath = getServletContext().getRealPath("/WEB-INF/secure-files/" + fileName);
        
        // 파일 전송 로직...
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
