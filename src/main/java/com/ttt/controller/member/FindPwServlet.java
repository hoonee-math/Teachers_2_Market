package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member2;
import com.ttt.service.MemberService;

@WebServlet("/auth/checkEmailDuplicate.do")
public class FindPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FindPwServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType=request.getParameter("searchType");
		String email=request.getParameter("email");
		String memberId=request.getParameter("memberId");
		
	    System.out.println("Received parameters:");
	    System.out.println("searchType: " + searchType);
	    System.out.println("email: " + email);
	    System.out.println("memberId: " + memberId);
		
		System.out.println(searchType + "," + email + ","+ memberId);
		
		Member2 m= new Member2();
		switch(searchType) {
		case "emailDuplicate" : m.setEmail(email); System.out.println(m); break;
		case "searchPassword" : m.setEmail(email); m.setMemberId(memberId);; System.out.println(m); break;
		}
		
		
		Member2 result=new MemberService().selectMemberByIdAndEmail(m);
		System.out.println("Query result: " + result);

        response.setContentType("application/json");
        response.getWriter().write("{\"exists\": " + (result != null) + "}");
	}

}
