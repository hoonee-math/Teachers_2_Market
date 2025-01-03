package com.ttt.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member2;

@WebServlet("/member/enrollend")
public class MemberEnrollEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberEnrollEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberName = request.getParameter("memberName");
		String memberId = request.getParameter("memberId");
		
		String emailId = request.getParameter("emailId");
		String emailDomain = request.getParameter("emailDomain");
		String email = emailId + "@" + emailDomain;
		
		String memberPw = request.getParameter("memberPw");
		String memberNick = request.getParameter("memberNick");
		
		String addressNo = request.getParameter("addressNo");
		String addressRoad = request.getParameter("addressRoad");
		String addressDetail = request.getParameter("addressDetail");
		String address = "("+addressNo+") "+addressRoad+" "+addressDetail;
		
		int eduType = Integer.parseInt(request.getParameter("eduType"));
		
		Member2 m = Member2.builder()
				.memberName(memberName)
				.memberId(memberId)
				.memberPw(memberPw)
				.email(email)
				.address(address)
				.eduType(eduType)
				.build();
		
		//db에 저장하기!
		String msg, loc="/";
		
		try {
			int result = new Member2Service().
		}catch {
			
			
		}
		
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
