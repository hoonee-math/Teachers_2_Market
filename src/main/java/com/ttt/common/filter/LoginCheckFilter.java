package com.ttt.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member2;

/* 로그인 여부 확인하는 서블릿 */
@WebFilter( servletNames= {
		/* 로그인을 체크할 서블릿에 네이밍 후 서블릿네임 선언하기 */
		"shoppingList", "purchase", "viewNotify", "viewPost", "writePost"
})
public class LoginCheckFilter extends HttpFilter implements Filter {
	public LoginCheckFilter() {
		super();
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here

		// HttpSession 에 로그인 정보가 있는지 확인
		HttpSession session=((HttpServletRequest)request).getSession();
		Member2 loginMember=(Member2)session.getAttribute("loginMember");

		if(session==null||loginMember==null) {
	        // 메시지와 원래 URL을 전달하여 예외 발생
	        request.setAttribute("msg", "로그인 후 이용 가능한 서비스입니다.");
	        request.setAttribute("loc", "");

	        // msg.jsp로 포워드
	        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	        return; // 필터 체인 종료
		}
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}
	
	public void init(FilterConfig fConfig) throws ServletException {
	}
	
	public void destroy() {
	}

}
