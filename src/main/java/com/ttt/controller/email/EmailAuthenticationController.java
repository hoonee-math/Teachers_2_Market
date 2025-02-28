package com.ttt.controller.email;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.AuthenticationResult;
import com.ttt.service.EmailAuthenticationService;

@WebServlet("/auth/*")
public class EmailAuthenticationController extends HttpServlet {
    private EmailAuthenticationService authService = new EmailAuthenticationService();
	private static final long serialVersionUID = 1L;
       
    public EmailAuthenticationController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, 
        HttpServletResponse response) 
        throws ServletException, IOException {
        
    	// 서블릿 주소 요청 주소에 따라서 분기처리
        String pathInfo = request.getPathInfo();
        
        switch (pathInfo) {
            case "/sendEmail":
                handleSendEmail(request, response);
                break;
            case "/verify":
                handleVerification(request, response);
                break;
            case "/complete":
                handleComplete(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void handleSendEmail(HttpServletRequest request, 
        HttpServletResponse response) 
        throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String authType = request.getParameter("authType"); // signup or reset
        
        try {
            String authNumber = authService.generateAuthNumber();
            String hashedNumber = authService.hashAuthNumber(authNumber);
            
            authService.setAuthenticationInfo(request.getSession(), 
                email, hashedNumber);
            authService.sendAuthEmail(email, authNumber);
            
            // JSP 선택 (회원가입용/비밀번호 재설정용)
            String jspPath = authType.equals("signup") ? 
                "/WEB-INF/views/enroll/checkEmail.jsp" :
                "/WEB-INF/views/enroll/checkEmailForFindPassword.jsp";
            
            request.setAttribute("email", email);
            request.getRequestDispatcher(jspPath).forward(request, response);
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"" + 
                e.getMessage() + "\"}");
        }
    }
    
    private void handleVerification(HttpServletRequest request, 
        HttpServletResponse response) 
        throws ServletException, IOException {
        
        String inputCode = request.getParameter("authCode");
        String authType = request.getParameter("authType");
        
        AuthenticationResult result = 
            authService.verifyAuthNumber(request.getSession(), inputCode);
        
        request.setAttribute("result", result.isSuccess());
        request.setAttribute("message", result.getMessage());
        
        // returnPath를 authType에 따라 분기처리
        String returnPath = "/WEB-INF/views/enroll/" + 
            (authType.equals("reset") ? "checkEmailForFindPassword.jsp" : "checkEmail.jsp");
           
        request.getRequestDispatcher(returnPath).forward(request, response);
    }
    
    private void handleComplete(HttpServletRequest request, 
        HttpServletResponse response) 
        throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        boolean isPasswordReset = Boolean.parseBoolean(request.getParameter("isPasswordReset"));
        String email = request.getParameter("email");  // 이메일 파라미터 받기
        
        try {
            if (isPasswordReset) {
                session.setAttribute("passwordResetAuthorized", true);
                session.setAttribute("email", email);  // 이메일도 세션에 저장
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true}");
            }
			/* authService.clearAuthenticationInfo(session); */
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"" + 
                e.getMessage() + "\"}");
        }
    }

}
